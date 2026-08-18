package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reports")
public class ReportsController {

    // ========== DASHBOARD ==========
    @GetMapping("/")
    public String reportsDashboard() {
        return "reports/reports";
    }


    // ========== ITI LEVEL REPORTS (Role 4) ==========

    @GetMapping("/iti-wise-status")
    public String itiWiseStatus() {
        return "reports/iti-wise-status-view";
    }

    @GetMapping("/applicant-report-by-phase")
    public String applicantReportByPhase() {
        return "reports/district-applicant-report-view";
    }

    @GetMapping("/admission-report-iti")
    public String admissionReportIti() {
        return "reports/admission-report-iti";
    }

    @GetMapping("/dsc-full")
    public String dscFull() {
        return "reports/district-dsc-full-view";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/caste-wise-admissions")
    public String casteWiseAdmissions() {
        return "reports/district-caste-wise-view";
    }

    @GetMapping("/applicant-mobile-address")
    public String applicantMobileAddress() {
        return "reports/applicant-mobile-address";
    }

    @GetMapping("/api-dashboard")
    public String apiDashboard() {
        return "reports/api-dashboard";
    }

    @GetMapping("/verified-application-count")
    public String verifiedApplicationCount() {
        return "reports/district-verified-count-view";
    }

    // ========== NODAL LEVEL REPORTS (Role 10) ==========

    @GetMapping("/state-dashboard")
    public String stateDashboard() {
        return "reports/state-dashboard";
    }

    @GetMapping("/phase-wise")
    public String phaseWise() {
        return "reports/phase-wise";
    }

    @GetMapping("/today-schedule")
    public String todaySchedule() {
        return "reports/today-schedule";
    }

    @GetMapping("/trade-wise-report")
    public String tradeWiseReport() {
        return "reports/trade-wise-report";
    }

    @GetMapping("/applicant-report-state-wise")
    public String applicantReportStateWise() {
        return "reports/applicant-report-state-wise";
    }

    @GetMapping("/open-seats")
    public String openSeats() {
        return "reports/open-seats";
    }

    @GetMapping("/trade-duration-seats")
    public String tradeDurationSeats() {
        return "reports/trade-duration-seats";
    }

    @GetMapping("/govt-pvt-seats")
    public String govtPvtSeats() {
        return "reports/govt-pvt-seats";
    }

    @GetMapping("/student-details")
    public String studentDetails() {
        return "reports/student-details";
    }

    @GetMapping("/district-wise-application-count")
    public String districtWiseApplicationCount() {
        return "reports/district-wise-application-count";
    }

    // ========== STATE LEVEL REPORTS (Role 1) ==========

    @GetMapping("/district-iti-wise-year")
    public String districtItiWiseYear() {
        return "reports/district-iti-wise-year-view";
    }

    @GetMapping("/itiprofile")
    public String itiProfile() {
        return "reports/itiprofile";
    }

    @GetMapping("/district-schedule")
    public String districtSchedule() {
        return "reports/district-schedule";
    }

    @GetMapping("/shift-unit-report")
    public String shiftUnitReport() {
        return "reports/district-permitted-shift-view";
    }

    @GetMapping("/iti-admissions")
    public String itiAdmissions() {
        return "reports/iti-admissions";
    }

    @GetMapping("/all-resource-roles")
    public String allResourceRoles() {
        return "reports/all-resource-roles";
    }

    @GetMapping("/strength-filled-seats")
    public String strengthFilledSeats() {
        return "reports/strength-filled-seats";
    }

    @GetMapping("/admission-report")
    public String admissionReport() {
        return "reports/admission_report";
    }

    @GetMapping("/trade-vacant-positions")
    public String tradeWiseVacantPositions() {
        return "reports/trade-vacant-positions";
    }

    // ========== PUBLIC PAGES ==========

    @GetMapping("/about-strive")
    public String aboutStrive() {
        return "reports/aboutstrive";
    }

    @GetMapping("/disclosure-management")
    public String disclosureManagement() {
        return "reports/disclosuremanagement";
    }

    // ========== UTILITY ==========

    @GetMapping("/api-docs")
    public String apiDocs() {
        return "reports/swagger";
    }
}
