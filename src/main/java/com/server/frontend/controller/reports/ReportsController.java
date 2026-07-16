package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReportsController {

    @GetMapping("/")
    public String dashboard() {
        return "reports";
    }

    @GetMapping("/reports/admission-report")
    public String admissionReport() {
        return "admission_report";
    }

    @GetMapping("/reports/district-dsc-full")
    public String districtDscFull() {
        return "district-dsc-full-view";
    }

    @GetMapping("/reports/district-applicant-report")
    public String districtApplicantReport() {
        return "district-applicant-report-view";
    }

    @GetMapping("/reports/district-caste-wise")
    public String districtCasteWise() {
        return "district-caste-wise-view";
    }

    @GetMapping("/reports/district-iti-wise-year")
    public String districtItiWiseYear() {
        return "district-iti-wise-year-view";
    }

    @GetMapping("/reports/district-permitted-shift")
    public String districtPermittedShift() {
        return "district-permitted-shift-view";
    }

    @GetMapping("/reports/district-verified-count")
    public String districtVerifiedCount() {
        return "district-verified-count-view";
    }

    @GetMapping("/reports/iti-wise-status-view")
    public String itiWiseStatusView() {
        return "iti-wise-status-view";
    }

    @GetMapping("/reports/iti-student-list-view")
    public String itiStudentListView() {
        return "iti-student-list-view";
    }

    @GetMapping("/reports/api-docs")
    public String apiDocs() {
        return "swagger";
    }
}
