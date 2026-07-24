package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/reports")
@Controller
public class ReportsController {

    @GetMapping("/")
    public String testAllReports() {
        return "reports-test";
    }

    @GetMapping("/applicant-report-by-phase")
    public String applicantReportByPhase() {
        return "applicant-report-by-phase";
    }

    @GetMapping("/admission-report")
    public String admissionReport() {
        return "admission_report";
    }

    @GetMapping("/district-dsc-full")
    public String districtDscFull() {
        return "district-dsc-full-view";
    }

    @GetMapping("/district-applicant-report")
    public String districtApplicantReport() {
        return "district-applicant-report-view";
    }

    @GetMapping("/district-caste-wise")
    public String districtCasteWise() {
        return "district-caste-wise-view";
    }

    @GetMapping("/district-permitted-shift")
    public String districtPermittedShift() {
        return "district-permitted-shift-view";
    }

    @GetMapping("/district-verified-count")
    public String districtVerifiedCount() {
        return "district-verified-count-view";
    }

    @GetMapping("/phase-wise-report")
    public String phaseWiseReport() {
        return "phase-wise-report";
    }

    @GetMapping("/open-seats-report")
    public String openSeatsReport() {
        return "open-seats-report";
    }

    @GetMapping("/trade-duration-seats")
    public String tradeDurationSeats() {
        return "trade-duration-seats";
    }

    @GetMapping("/govt-pvt-seats")
    public String govtPvtSeats() {
        return "govt-pvt-seats";
    }

    @GetMapping("/student-registration-details")
    public String studentRegistrationDetails() {
        return "student-registration-details";
    }

    @GetMapping("/applicant-report-state-wise")
    public String applicantReportStateWise() {
        return "applicant-report-state-wise";
    }

    @GetMapping("/district-wise-application-count")
    public String districtWiseApplicationCount() {
        return "district-wise-application-count";
    }

    @GetMapping("/verification-report")
    public String verificationReport() {
        return "verification-report";
    }

    @GetMapping("/state-dashboard")
    public String stateDashboard() {
        return "state-dashboard";
    }

    @GetMapping("/api-dashboard")
    public String apiDashboard() {
        return "api-dashboard";
    }

    @GetMapping("/today-schedule")
    public String todaySchedule() {
        return "today-schedule";
    }

    @GetMapping("/trade-wise-report")
    public String tradeWiseReport() {
        return "trade-wise-report";
    }

    @GetMapping("/district-schedule")
    public String districtSchedule() {
        return "district-schedule";
    }

    @GetMapping("/all-resource-roles")
    public String allResourceRoles() {
        return "all-resource-roles";
    }

    @GetMapping("/strength-filled-seats")
    public String strengthFilledSeats() {
        return "strength-filled-seats";
    }

    @GetMapping("/open-seats")
    public String openSeats() {
        return "open-seats";
    }

    @GetMapping("/trade-vacant-positions")
    public String tradeVacantPositions() {
        return "trade-vacant-positions";
    }

    @GetMapping("/trade-display/districts")
    public String tradeDisplayDistricts() {
        return "trade-display-districts";
    }

    @GetMapping("/api-docs")
    public String apiDocs() {
        return "swagger";
    }

    @GetMapping("/about-strive")
    public String aboutStrive() {
        return "aboutstrive";
    }

    @GetMapping("/disclosure-management")
    public String disclosureManagement() {
        return "disclosuremanagement";
    }
}
