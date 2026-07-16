package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reports")
public class ReportsController {

    @GetMapping("/unified-reports")
    public String unifiedReports() {
        return "reports/unified_reports";
    }

    @GetMapping("/admission-report")
    public String admissionReport() {
        return "reports/admission_report";
    }

    @GetMapping("/district-dsc-full")
    public String districtDscFull() {
        return "reports/district-dsc-full-view";
    }

    @GetMapping("/district-applicant-report")
    public String districtApplicantReport() {
        return "reports/district-applicant-report-view";
    }

    @GetMapping("/district-caste-wise")
    public String districtCasteWise() {
        return "reports/district-caste-wise-view";
    }

    @GetMapping("/district-iti-wise-year")
    public String districtItiWiseYear() {
        return "reports/district-iti-wise-year-view";
    }

    @GetMapping("/district-permitted-shift")
    public String districtPermittedShift() {
        return "reports/district-permitted-shift-view";
    }

    @GetMapping("/district-verified-count")
    public String districtVerifiedCount() {
        return "reports/district-verified-count-view";
    }

    @GetMapping("/iti-wise-status-view")
    public String itiWiseStatusView() {
        return "reports/iti-wise-status-view";
    }

    @GetMapping("/iti-student-list-view")
    public String itiStudentListView() {
        return "reports/iti-student-list-view";
    }

    @GetMapping("/reports")
    public String reportsDashboard() {
        return "reports/reports";
    }

    @GetMapping("/api-docs")
    public String apiDocs() {
        return "reports/swagger";
    }
}
