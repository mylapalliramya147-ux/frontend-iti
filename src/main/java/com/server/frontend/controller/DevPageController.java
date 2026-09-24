package com.server.frontend.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletContext;
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
            "checkmeritschedule/authNavbar",
            "reports/header"
    );

    /** view name -> real controller URL; others fall back to /dev/view. */
    private static final Map<String, String> REAL_ROUTES = buildRoutes();

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
        m.put("checkmeritschedule/admissionPhase1", "/AdmissionPhase1");
        m.put("checkmeritschedule/DscList", "/DgtPermittedShift");
        m.put("checkmeritschedule/distVerification", "/VerificationReport");
        m.put("checkmeritschedule/admissionIntialization", "/PrintAdmissionSlip");
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

    @GetMapping("/dev")
    public String devIndex(Model model) {
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

    /** Passthrough so WIP pages with no route can still be opened while developing. */
    @GetMapping("/dev/view/{folder}/{name}")
    public String devView(@PathVariable String folder, @PathVariable String name) {
        if (!FOLDERS.contains(folder) || !name.matches("[A-Za-z0-9_\\.-]+")) {
            return "redirect:/dev";
        }
        if (name.endsWith(".jsp")) {
            name = name.substring(0, name.length() - 4);
        }
        return folder + "/" + name;
    }
}
