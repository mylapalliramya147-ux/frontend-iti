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

    @GetMapping("/getDashboardreport_iti")
    public String getDashboardreport_iti() {
        return "reports/getDashboardreport_iti";
    }

    @GetMapping("/Applicant_Report")
    public String Applicant_Report() {
        return "reports/Applicant_Report";
    }

    @GetMapping("/api_report")
    public String api_report() {
        return "reports/api_report";
    }

    @GetMapping("/DSC_List_secondphase")
    public String DSC_List_secondphase() {
        return "reports/DSC_List_secondphase";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/statewidecastewiseabstractinter")
    public String statewidecastewiseabstractinter() {
        return "reports/statewidecastewiseabstractinter";
    }

    @GetMapping("/Applicant_mobile_addr")
    public String Applicant_mobile_addr() {
        return "reports/Applicant_mobile_addr";
    }

    @GetMapping("/getDashboardreport_dist")
    public String getDashboardreport_dist() {
        return "reports/getDashboardreport_dist";
    }

    @GetMapping("/District_Wise_Application_count")
    public String District_Wise_Application_count() {
        return "reports/District_Wise_Application_count";
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

    @GetMapping("/admissiongenderwise")
    public String admissionGenderWise() {
        return "reports/admissiongenderwise";
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

    @GetMapping("/district-iti-wise-year-view")
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

    @GetMapping("/district-permitted-shift-view")
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

    @GetMapping("/admission_report")
    public String admissionReport() {
        return "reports/admission_report";
    }

    @GetMapping("/trade-vacant-positions")
    public String tradeWiseVacantPositions() {
        return "reports/trade-vacant-positions";
    }

    // ========== PUBLIC PAGES ==========

    @GetMapping("/aboutstrive")
    public String aboutStrive() {
        return "reports/aboutstrive";
    }

    @GetMapping("/disclosuremanagement")
    public String disclosureManagement() {
        return "reports/disclosuremanagement";
    }

    // ========== UTILITY ==========

    @GetMapping("/swagger")
    public String apiDocs() {
        return "reports/swagger";
    }
}
