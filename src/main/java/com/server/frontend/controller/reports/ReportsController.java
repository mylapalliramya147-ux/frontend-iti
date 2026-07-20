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

    @GetMapping("/reports/applicant-report-by-phase")
    public String applicantReportByPhase() {
        return "applicant-report-by-phase";
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

    @GetMapping("/reports/district-permitted-shift")
    public String districtPermittedShift() {
        return "district-permitted-shift-view";
    }

    @GetMapping("/reports/district-verified-count")
    public String districtVerifiedCount() {
        return "district-verified-count-view";
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

    @GetMapping("/reports/student-registration-details")
    public String studentRegistrationDetails() {
        return "student-registration-details";
    }

    @GetMapping("/reports/applicant-report-state-wise")
    public String applicantReportStateWise() {
        return "applicant-report-state-wise";
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

    @GetMapping("/reports/today-schedule")
    public String todaySchedule() {
        return "today-schedule";
    }

    @GetMapping("/reports/trade-wise-report")
    public String tradeWiseReport() {
        return "trade-wise-report";
    }

    @GetMapping("/reports/district-schedule")
    public String districtSchedule() {
        return "district-schedule";
    }

    @GetMapping("/reports/all-resource-roles")
    public String allResourceRoles() {
        return "all-resource-roles";
    }

    @GetMapping("/reports/strength-filled-seats")
    public String strengthFilledSeats() {
        return "strength-filled-seats";
    }

    @GetMapping("/reports/open-seats")
    public String openSeats() {
        return "open-seats";
    }

    @GetMapping("/reports/trade-vacant-positions")
    public String tradeVacantPositions() {
        return "trade-vacant-positions";
    }

    @GetMapping("/reports/trade-display/districts")
    public String tradeDisplayDistricts() {
        return "trade-display-districts";
    }

    @GetMapping("/reports/test-all")
    public String testAllReports() {
        return "reports-test";
    }

    @GetMapping("/reports/api-docs")
    public String apiDocs() {
        return "swagger";
    }

    @GetMapping("/reports/about-strive")
    public String aboutStrive() {
        return "aboutstrive";
    }

    @GetMapping("/reports/disclosure-management")
    public String disclosureManagement() {
        return "disclosuremanagement";
    }
}
