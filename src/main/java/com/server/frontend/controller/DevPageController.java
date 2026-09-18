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
            "labs", "navbars", "placements", "reports");

    /** view name -> real controller URL; others fall back to /dev/view. */
    private static final Map<String, String> REAL_ROUTES = buildRoutes();

    private static Map<String, String> buildRoutes() {
        Map<String, String> m = new LinkedHashMap<>();
        m.put("jsp/index", "/");
        m.put("jsp/authHome", "/authHome");
        m.put("jsp/authHome_admin", "/authHome/admin");
        m.put("jsp/authHome_district", "/authHome/district");
        m.put("jsp/authHome_iti", "/authHome/iti");
        m.put("jsp/authHome_nodal", "/authHome/nodal");
        m.put("jsp/placementDashboard", "/placementDashboard");
        m.put("jsp/placements", "/placements");
        m.put("reports/reports", "/reports/");
        m.put("reports/district-dsc-full-view", "/authHome/district-dsc-full");
        m.put("reports/district-applicant-report-view", "/authHome/applicant-report-by-phase");
        m.put("reports/state-dashboard", "/authHome/nodal-report/dashboard");
        m.put("checkmeritschedule/MeritList", "/authHome/MeritList");
        m.put("checkmeritschedule/MeritResults", "/authHome/MeritResults");
        m.put("checkmeritschedule/AdmissionPhase", "/authHome/AdmissionPhase");
        m.put("checkmeritschedule/admissionPhase1", "/authHome/AdmissionPhase1");
        m.put("checkmeritschedule/DscList", "/authHome/DgtPermittedShift");
        m.put("checkmeritschedule/distVerification", "/authHome/VerificationReport");
        m.put("checkmeritschedule/admissionIntialization", "/authHome/PrintAdmissionSlip");
        m.put("checkmeritschedule/ScheduleEntry", "/ScheduleEntry/ScheduleEntry");
        String rep = "reports/";
        String[] reportViews = {"students-not-admitted", "api-dashboard-iti", "applicant-report",
                "admission-report", "dsc-list", "caste-wise-admissions-abstract",
                "applicant-address-with-mobile", "api-dashboard-district", "verification-report",
                "api-dashboard-state", "phase-wise-admissions-details", "today-schedule-itis",
                "trade-wise-report", "applicant-report-dist-wise", "dist-iti-trade-wise-seats-abstract",
                "duration-wise-trade-seats-abstract", "govt-or-pvt-dist-wise-seats-abstract",
                "student-reg-details", "iti-profile", "iti-list", "trade-display2",
                "district-schedule", "shift-unit-report", "admitted-seats-abstract",
                "all-resource-role", "distwise-admitted-seats-abstract",
                "trade-dist-wise-admission-report", "tradewise-vacant-position", "about-strive",
                "disclosure-management", "api-documentation"};
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
        return "jsp/dev";
    }

    /** Passthrough so WIP pages with no route can still be opened while developing. */
    @GetMapping("/dev/view/{folder}/{name}")
    public String devView(@PathVariable String folder, @PathVariable String name) {
        if (!FOLDERS.contains(folder) || !name.matches("[A-Za-z0-9_-]+")) {
            return "redirect:/dev";
        }
        return folder + "/" + name;
    }
}
