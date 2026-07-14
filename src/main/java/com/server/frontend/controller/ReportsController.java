package com.server.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reports")
public class ReportsController {

    @GetMapping("/unified-reports")
    public String unifiedReports() {
        return "nodal_report/unified_reports";
    }

    @GetMapping("/admission-report")
    public String admissionReport() {
        return "nodal_report/admission_report";
    }

    @GetMapping("/district-dsc-full")
    public String districtDscFull() {
        return "district/district-dsc-full-view";
    }

    @GetMapping("/district-applicant-report")
    public String districtApplicantReport() {
        return "district/district-applicant-report-view";
    }

    @GetMapping("/district-caste-wise")
    public String districtCasteWise() {
        return "district/district-caste-wise-view";
    }

    @GetMapping("/district-iti-wise-year")
    public String districtItiWiseYear() {
        return "district/district-iti-wise-year-view";
    }

    @GetMapping("/district-permitted-shift")
    public String districtPermittedShift() {
        return "district/district-permitted-shift-view";
    }

    @GetMapping("/district-verified-count")
    public String districtVerifiedCount() {
        return "district/district-verified-count-view";
    }

    @GetMapping("/iti-wise-status-view")
    public String itiWiseStatusView() {
        return "iti/iti-wise-status-view";
    }

    @GetMapping("/iti-student-list-view")
    public String itiStudentListView() {
        return "iti/iti-student-list-view";
    }
}
