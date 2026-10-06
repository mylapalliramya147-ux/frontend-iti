package com.server.frontend.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * TEMPORARY development-only tool: /dev lists every JSP in WEB-INF so
 * developers can open any page (including WIP pages with no route yet).
 * Delete this file and WEB-INF/jsp/dev.jsp when development wraps up.
 */
@Controller
public class DevPageController {

    /** JSP folders surfaced on /dev (whitelist also blocks path traversal). */
    private static final List<String> FOLDERS = List.of(
            "admission", "checkmeritschedule", "implant", "Institute", "jsp",
            "labs", "navbars", "placements", "reports", "student");

    /** Folders whose JSPs are done but are partials/includes (navbars). */
    private static final List<String> FOLDERS_PARTIAL = List.of("navbars");

    /** Specific partial/snippet views that are includes, not standalone pages. */
    private static final java.util.Set<String> PARTIAL_VIEWS = java.util.Set.of(
            "jsp/_api_base_url",
            "reports/header"
    );

    /** view name -> real controller URL; others fall back to /dev/view. */
    private static final Map<String, String> REAL_ROUTES = buildRoutes();

    /** roleId -> the label shown on the /dev tags and section headings. */
    private static final Map<String, String> ROLE_LABELS = Map.of(
            "2", "Admin Login",
            "3", "District Login",
            "4", "ITI Login",
            "10", "Nodal Login");

    /** Admin (role 2) can open every page, mirroring the open-ended hasRole() guards. */
    private static final String ADMIN_ROLE = "2";

    /**
     * DEV TOOL ONLY. view name -> the roleIds the real controller guard allows.
     *
     * <p>This mirrors the guards that already exist; it never changes them. A view that is
     * absent from this map has no server-side role guard (public page, or an unrouted WIP
     * page), so it stays open to every signed-in developer.
     */
    private static final Map<String, List<String>> VIEW_ROLE_IDS = buildRoleAccess();

    private static Map<String, List<String>> buildRoleAccess() {
        Map<String, List<String>> m = new LinkedHashMap<>();
        // ---- ReportsController.hasRole ----
        m.put("reports/students-not-admitted", List.of("10", "3", "4"));
        m.put("reports/api-dashboard-iti", List.of("4"));
        m.put("reports/applicant-report", List.of("4"));
        m.put("reports/admission-report", List.of("4"));
        m.put("reports/dsc-list", List.of("4", "3", "10"));
        m.put("reports/caste-wise-admissions-abstract", List.of("3", "10"));
        m.put("reports/applicant-address-with-mobile", List.of("3"));
        m.put("reports/api-dashboard-district", List.of("3"));
        m.put("reports/verification-report", List.of("3", "10"));
        m.put("reports/api-dashboard-state", List.of("10"));
        m.put("reports/phase-wise-admissions-details", List.of("10"));
        m.put("reports/today-schedule-itis", List.of("10"));
        m.put("reports/trade-wise-report", List.of("10"));
        m.put("reports/applicant-report-dist-wise", List.of("10"));
        m.put("reports/dist-iti-trade-wise-seats-abstract", List.of("10"));
        m.put("reports/duration-wise-trade-seats-abstract", List.of("10"));
        m.put("reports/govt-or-pvt-dist-wise-seats-abstract", List.of("10"));
        m.put("reports/student-reg-details", List.of("10"));

        // ---- ImplantController (isDistrictRole / isItiRole / isNodalRole) ----
        m.put("implant/implant_dist_report", List.of("3"));
        m.put("implant/implant_entry", List.of("4"));
        m.put("implant/implant_report", List.of("4"));
        m.put("implant/implant_mapping", List.of("4"));
        m.put("implant/implant_mapping_edit", List.of("4"));
        for (String nodal : List.of("industry_master_preview", "industry_master_edit",
                "industry_master_entry", "industry_mapping_nodal", "industry_partner_details",
                "industry_partner_details_edit", "inplant_nodal_report", "industry_master_report",
                "industry_mapping_report", "inplant_trainees_report", "inplant_yearwise_report",
                "inplant_two_year_report", "inplant_twelve_24_months_report",
                "inplant_district_report", "inplant_datewise_report", "IndustryConnectedTrades",
                "inplant_industry_not_connected_trades")) {
            m.put("implant/" + nodal, List.of("10"));
        }

        // ---- LabsController (isItiRole) ----
        m.put("labs/labs_entry", List.of("4"));
        m.put("labs/labs_report", List.of("4"));

        // ---- PlacementsController ----
        m.put("placements/placements_schedule_entry", List.of("3"));
        m.put("placements/placements_dist_report", List.of("3"));
        m.put("placements/placements_entry", List.of("4"));
        m.put("placements/placements_iti_report", List.of("4"));

        return java.util.Collections.unmodifiableMap(m);
    }

    /** Role ids allowed to open this view, or null when the view has no role guard. */
    private static List<String> allowedRoles(String viewName) {
        return VIEW_ROLE_IDS.get(viewName);
    }

    /**
     * Whether the signed-in developer may open this view through /dev/view.
     *
     * <p>Admin opens everything. A session with no roleId is not filtered, which matches
     * ReportsController's deliberate "role not stored yet - don't lock out" behaviour.
     */
    private static boolean canOpen(String viewName, Object roleId) {
        List<String> allowed = allowedRoles(viewName);
        if (allowed == null || roleId == null || String.valueOf(roleId).isBlank()) {
            return true;
        }
        String role = String.valueOf(roleId).trim();
        return ADMIN_ROLE.equals(role) || allowed.contains(role);
    }

    /** "ITI Login", "District Login, Nodal Login", or "" when the view has no role guard. */
    private static String roleTagText(String viewName) {
        List<String> allowed = allowedRoles(viewName);
        if (allowed == null) {
            return "";
        }
        List<String> labels = new ArrayList<>();
        for (String roleId : allowed) {
            String label = ROLE_LABELS.get(roleId);
            if (label != null) labels.add(label);
        }
        if (labels.isEmpty()) {
            return "Any Login";
        }
        // Nodal is the most privileged label already present; Admin opens everything.
        if (labels.contains("Admin Login")) {
            return "Admin Login";
        }
        return String.join(", ", labels);
    }

    /**
     * CSS suffix for a page's role tag, so a multi-role page gets a combined colour.
     * Returns "" for views with no role guard (no tag is rendered for them).
     */
    private static String roleTagClass(String viewName) {
        List<String> allowed = allowedRoles(viewName);
        if (allowed == null) {
            return "";
        }
        if (allowed.size() > 1) return "role-multi";
        String label = ROLE_LABELS.get(allowed.get(0));
        if (label == null) return "role-any";
        return switch (label) {
            case "ITI Login" -> "role-iti";
            case "District Login" -> "role-district";
            case "Nodal Login" -> "role-nodal";
            case "Admin Login" -> "role-admin";
            default -> "role-any";
        };
    }

    private static Map<String, String> buildRoutes() {
        Map<String, String> m = new LinkedHashMap<>();
        m.put("jsp/index", "/");
        m.put("jsp/dev", "/dev");
        m.put("jsp/authHome", "/authHome");
        m.put("jsp/authHome_admin", "/authHome/admin");
        m.put("jsp/authHome_district", "/authHome/district");
        m.put("jsp/authHome_iti", "/authHome/iti");
        m.put("jsp/authHome_nodal", "/authHome/nodal");
        m.put("jsp/placements", "/placements");
        m.put("jsp/placementDashboard", "/placements/loginSuccess");
        m.put("jsp/under_construction", "/under-construction");
        m.put("student/StudentRegistration", "/student-registration");
        m.put("student/StudentApply", "/student-apply");
        m.put("student/StudentEditDetails", "/student-edit-details");
        m.put("student/ForgotRegId", "/forgot-regid");
        m.put("checkmeritschedule/MeritList", "/MeritList");
        m.put("checkmeritschedule/MeritResults", "/MeritResults");
        m.put("checkmeritschedule/AdmissionPhase", "/AdmissionPhase");
        m.put("checkmeritschedule/DscList", "/DgtPermittedShift");
        m.put("checkmeritschedule/distVerification", "/VerificationReport");
        m.put("checkmeritschedule/admissionIntialization", "/PrintAdmissionSlip");
        m.put("admission/dischargeAdmission", "/admissions/discharge-admission");
        m.put("checkmeritschedule/ScheduleEntry", "/ScheduleEntry");
        m.put("labs/labs_entry", "/labs/entry");
        m.put("labs/labs_report", "/labs/report");
        m.put("placements/placements_schedulewise", "/placements/schedulewise");
        m.put("placements/placements_schedule_datewise", "/placements/scheduledatewise");
        m.put("placements/placements_state_report", "/placements/statereport");
        m.put("placements/placements_yearwise_report", "/placements/yearwisereport");
        m.put("placements/placements_ssdp_report", "/placements/ssdpreport");
        m.put("placements/placements_data_details", "/placements/datadetails");
        m.put("placements/placements_schedule_entry", "/placements/scheduleentry");
        m.put("placements/placements_dist_report", "/placements/distreport");
        m.put("placements/placements_entry", "/placements/placemententry");
        m.put("placements/placements_iti_report", "/placements/itireport");
        m.put("implant/implant_dist_report", "/implant/distreport");
        m.put("implant/implant_entry", "/implant/entry");
        m.put("implant/implant_report", "/implant/report");
        m.put("implant/implant_mapping", "/implant/mapping");
        m.put("implant/implant_mapping_edit", "/implant/mapping/edit");
        m.put("implant/industry_master_preview", "/implant/industrymaster");
        m.put("implant/industry_master_edit", "/implant/industrymaster/edit");
        m.put("implant/industry_master_entry", "/implant/industrymaster/entry");
        m.put("implant/industry_mapping_nodal", "/implant/mapping-nodal");
        m.put("implant/industry_partner_details", "/implant/partners");
        m.put("implant/industry_partner_details_edit", "/implant/partners/edit");
        m.put("implant/inplant_nodal_report", "/implant/nodalreport");
        m.put("implant/industry_master_report", "/implant/industrymaster/report");
        m.put("implant/industry_mapping_report", "/implant/mappingreport");
        m.put("implant/inplant_trainees_report", "/implant/traineesreport");
        m.put("implant/inplant_yearwise_report", "/implant/yearwisereport");
        m.put("implant/inplant_two_year_report", "/implant/twoyearwisereport");
        m.put("implant/inplant_twelve_24_months_report", "/implant/twelve24monthsreport");
        m.put("implant/inplant_district_report", "/implant/inplantdistrictreport");
        m.put("implant/inplant_datewise_report", "/implant/datewisereport");
        m.put("implant/IndustryConnectedTrades", "/implant/industryconnectedtrades");
        m.put("implant/inplant_industry_not_connected_trades", "/implant/industry-not-connected-trades");
        m.put("reports/district-applicant-report-view", "/applicant-report-by-phase");
        m.put("reports/state-dashboard", "/nodal-report/dashboard");
        m.put("Institute/ItiList", "/itiList");
        m.put("Institute/ItiDetails", "/iti-details");
        m.put("Institute/ItiCreate", "/iti-create");
        m.put("Institute/ItiTradeSelection", "/iti-trade-selection");
        m.put("Institute/ShiftUnitPermitted", "/shift-unit-permitted");
        m.put("reports/reports", "/reports/");
        String rep = "reports/";
        String[] reportViews = {"students-not-admitted", "api-dashboard-iti", "applicant-report",
                "admission-report", "dsc-list", "caste-wise-admissions-abstract",
                "applicant-address-with-mobile", "api-dashboard-district", "verification-report",
                "api-dashboard-state", "phase-wise-admissions-details", "today-schedule-itis",
                "trade-wise-report", "applicant-report-dist-wise", "dist-iti-trade-wise-seats-abstract",
                "duration-wise-trade-seats-abstract", "govt-or-pvt-dist-wise-seats-abstract",
                "student-reg-details", "iti-profile", "iti-list",
                "district-schedule", "shift-unit-report", "admitted-seats-abstract",
                "all-resource-role", "distwise-admitted-seats-abstract",
                "trade-dist-wise-admission-report", "tradewise-vacant-position", "about-strive",
                "disclosure-management", "api-documentation", "trade-display2", "disclaimer"};
        for (String v : reportViews) m.put(rep + v, "/reports/" + v);
        return java.util.Collections.unmodifiableMap(m);
    }

    private final ServletContext servletContext;

    public DevPageController(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /** Standalone dev login. Log in here, then /dev opens with your login's pages unlocked. */
    @GetMapping("/dev/login")
    public String devLoginPage() {
        return "jsp/devLogin";
    }

    @GetMapping("/dev")
    public String devIndex(Model model, HttpServletRequest request) {

        // The dev pages point at real, session-guarded controllers, so the index needs the
        // developer to be signed in first. Without a session there is nothing to show.
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionUser") == null) {
            return "redirect:/dev/login";
        }
        Object roleId = session.getAttribute("roleId");
        model.addAttribute("devUserName", session.getAttribute("username"));
        model.addAttribute("devRoleId", roleId);
        model.addAttribute("devItiName", session.getAttribute("itiName"));
        model.addAttribute("devFullName", session.getAttribute("fullName"));
        model.addAttribute("devRoleLabel",
                roleId == null ? "No role" : ROLE_LABELS.getOrDefault(String.valueOf(roleId).trim(), "Role " + roleId));
        model.addAttribute("devIsAdmin", ADMIN_ROLE.equals(String.valueOf(roleId).trim()));

        // Every page is listed for every developer; roleTag/allowed say which ones their
        // own login can actually open.
        model.addAttribute("roleTags", buildRoleTags());
        model.addAttribute("roleTagClasses", buildRoleTagClasses());
        model.addAttribute("allowedViews", buildAllowedViews(roleId));

        Map<String, List<String>> pages = new LinkedHashMap<>();
        for (String folder : FOLDERS) {
            java.util.Set<?> resources = servletContext.getResourcePaths("/WEB-INF/" + folder + "/");
            if (resources == null) continue;
            List<String> names = new ArrayList<>();
            for (Object r : resources) {
                String path = r.toString();
                if (path.endsWith(".jsp")) {
                    names.add(path.substring(path.lastIndexOf('/') + 1, path.length() - 4));
                }
            }
            names.sort(String.CASE_INSENSITIVE_ORDER);
            if (!names.isEmpty()) pages.put(folder, names);
        }
        model.addAttribute("pages", pages);
        model.addAttribute("realRoutes", REAL_ROUTES);

        Map<String, String> pageStatuses = new LinkedHashMap<>();
        for (Map.Entry<String, List<String>> entry : pages.entrySet()) {
            String folder = entry.getKey();
            for (String page : entry.getValue()) {
                String viewName = folder + "/" + page;
                if (REAL_ROUTES.containsKey(viewName)) {
                    pageStatuses.put(viewName, "done");
                } else if (FOLDERS_PARTIAL.contains(folder) || PARTIAL_VIEWS.contains(viewName)) {
                    pageStatuses.put(viewName, "partial");
                } else {
                    pageStatuses.put(viewName, "wip");
                }
            }
        }
        model.addAttribute("pageStatuses", pageStatuses);

        Map<String, Boolean> doneMap = new LinkedHashMap<>();
        for (String folder : FOLDERS) doneMap.put(folder, FOLDERS_PARTIAL.contains(folder));
        model.addAttribute("doneFolders", doneMap);
        return "jsp/dev";
    }

    /** view name -> its role tag label, and view name -> the CSS suffix for that tag. */
    private Map<String, String> buildRoleTags() {
        Map<String, String> tags = new LinkedHashMap<>();
        for (String viewName : VIEW_ROLE_IDS.keySet()) {
            tags.put(viewName, roleTagText(viewName));
        }
        return tags;
    }

    /** view name -> CSS suffix so the JSP can colour the tag without duplicating logic. */
    private Map<String, String> buildRoleTagClasses() {
        Map<String, String> classes = new LinkedHashMap<>();
        for (String viewName : VIEW_ROLE_IDS.keySet()) {
            classes.put(viewName, roleTagClass(viewName));
        }
        return classes;
    }

    /** view name -> whether the signed-in developer can open it through /dev/view. */
    private Map<String, Boolean> buildAllowedViews(Object roleId) {
        Map<String, Boolean> allowed = new LinkedHashMap<>();
        for (String folder : FOLDERS) {
            java.util.Set<?> resources = servletContext.getResourcePaths("/WEB-INF/" + folder + "/");
            if (resources == null) continue;
            for (Object r : resources) {
                String path = r.toString();
                if (!path.endsWith(".jsp")) continue;
                String name = path.substring(path.lastIndexOf('/') + 1, path.length() - 4);
                String viewName = folder + "/" + name;
                allowed.put(viewName, canOpen(viewName, roleId));
            }
        }
        return allowed;
    }

    /** Drops the dev session and sends the developer back to the dev login form. */
    @GetMapping("/dev/logout")
    public String devLogout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/dev/login";
    }

    /**
     * Passthrough so any page can be opened while developing, gated by the same role map the
     * real controllers use. The real route is still reachable via the ↗ badge on /dev when a
     * developer wants to check the genuine guard.
     */
    @GetMapping("/dev/view/{folder}/{name}")
    public String devView(@PathVariable String folder, @PathVariable String name, HttpServletRequest request) {
        if (!FOLDERS.contains(folder) || !name.matches("[A-Za-z0-9_\\.-]+")) {
            return "redirect:/dev";
        }
        if (name.endsWith(".jsp")) {
            name = name.substring(0, name.length() - 4);
        }
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionUser") == null) {
            return "redirect:/dev/login";
        }
        // These JSPs read sessionUser/roleId via their navbars, and a page owned by another
        // login is blocked here so the dev tool cannot be used to sidestep the real guards.
        String viewName = folder + "/" + name;
        if (!canOpen(viewName, session.getAttribute("roleId"))) {
            return "redirect:/dev?error=denied&page=" + java.net.URLEncoder.encode(viewName,
                    java.nio.charset.StandardCharsets.UTF_8);
        }
        return viewName;
    }
}
