package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ReportsController {

    @GetMapping("/")
    public String dashboard() {
        return "redirect:/reports/test-all";
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

    @GetMapping("/reports/phase-wise-report")
    public String phaseWiseReport() {
        return "phase-wise-report";
    }

    @GetMapping("/reports/open-seats-report")
    public String openSeatsReport() {
        return "open-seats-report";
    }

    @GetMapping("/reports/trade-duration-seats")
    public String tradeDurationSeats() {
        return "trade-duration-seats";
    }

    @GetMapping("/reports/govt-pvt-seats")
    public String govtPvtSeats() {
        return "govt-pvt-seats";
    }

    @GetMapping("/reports/iti-admissions-report")
    public String itiAdmissionsReport() {
        return "iti-admissions-report";
    }

    @GetMapping("/reports/student-registration-details")
    public String studentRegistrationDetails() {
        return "student-registration-details";
    }

    @GetMapping("/reports/applicant-report-state-wise")
    public String applicantReportStateWise() {
        return "applicant-report-state-wise";
    }

    @GetMapping("/reports/open-seats-abstract")
    public String openSeatsAbstract() {
        return "open-seats-abstract";
    }

    @GetMapping("/reports/district-wise-application-count")
    public String districtWiseApplicationCount() {
        return "district-wise-application-count";
    }

    @GetMapping("/reports/verification-report")
    public String verificationReport() {
        return "verification-report";
    }

    @GetMapping("/reports/state-dashboard")
    public String stateDashboard() {
        return "state-dashboard";
    }

    @GetMapping("/reports/api-dashboard")
    public String apiDashboard() {
        return "api-dashboard";
    }

    @GetMapping("/reports/test-all")
    public String testAllReports() {
        return "reports-test";
    }

    @GetMapping("/reports/api-docs")
    public String apiDocs() {
        return "swagger";
    }
}
