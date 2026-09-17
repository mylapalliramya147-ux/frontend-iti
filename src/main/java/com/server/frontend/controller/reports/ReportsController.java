package com.server.frontend.controller.reports;

import java.util.Locale;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "reports", description = "Reports UI pages and documentation endpoints")
@Controller
@RequestMapping("/reports")
public class ReportsController {

    // ========== STUDENTS NOT ADMITTED (Nodal + Admin) ==========

    @GetMapping("/students-not-admitted")
    public String studentsNotAdmitted() {
        return "reports/students-not-admitted";
    }

    // ========== DASHBOARD ==========
    @GetMapping("/")
    public String reportsDashboard() {
        return "reports/reports";
    }

    // ========== ITI LEVEL REPORTS (Role 4) ==========

    @GetMapping("/api-dashboard-iti")
    public String getDashboardReportIti() {
        return "reports/api-dashboard-iti";
    }

    @GetMapping("/applicant-report")
    public String applicantReport() {
        return "reports/applicant-report";
    }

    @GetMapping("/admission-report")
    public String apiReport() {
        return "reports/admission-report";
    }

    @GetMapping("/dsc-list")
    public String dscListSecondphase() {
        return "reports/dsc-list";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/caste-wise-admissions-abstract")
    public String statewideCastewiseAbstractInter() {
        return "reports/caste-wise-admissions-abstract";
    }

    @GetMapping("/applicant-address-with-mobile")
    public String applicantMobileAddr() {
        return "reports/applicant-address-with-mobile";
    }

    @GetMapping("/api-dashboard-district")
    public String getDashboardReportDist() {
        return "reports/api-dashboard-district";
    }

    @GetMapping("/verification-report")
    public String districtWiseApplicationCount() {
        return "reports/verification-report";
    }

    // ========== NODAL LEVEL REPORTS (Role 10) ==========

    @GetMapping("/api-dashboard-state")
    public String jdGetDashboardReport() {
        return "reports/api-dashboard-state";
    }

    @GetMapping("/phase-wise-admissions-details")
    public String phaseWiseAdmissionReport() {
        return "reports/phase-wise-admissions-details";
    }

    @GetMapping("/today-schedule-itis")
    public String admissionScheduleIti() {
        return "reports/today-schedule-itis";
    }

    @GetMapping("/trade-wise-report")
    public String admissionGenderWise() {
        return "reports/trade-wise-report";
    }

    @GetMapping("/applicant-report-dist-wise")
    public String applicantReportStateWise() {
        return "reports/applicant-report-dist-wise";
    }

    @GetMapping("/dist-iti-trade-wise-seats-abstract")
    public String distWiseOpenSeats() {
        return "reports/dist-iti-trade-wise-seats-abstract";
    }

    @GetMapping("/duration-wise-trade-seats-abstract")
    public String tradeSeatsAbstractDurationWise() {
        return "reports/duration-wise-trade-seats-abstract";
    }

    @GetMapping("/govt-or-pvt-dist-wise-seats-abstract")
    public String govtPvtDistSeatsAbstract() {
        return "reports/govt-or-pvt-dist-wise-seats-abstract";
    }

    @GetMapping("/student-reg-details")
    public String stdRegDetailsReport() {
        return "reports/student-reg-details";
    }

    // ========== STATE LEVEL REPORTS (Role 1) ==========

    @GetMapping("/iti-profile")
    public String itiProfile() {
        return "reports/iti-profile";
    }

    @GetMapping("/trade-display1")
    public String tradeDisplay1() {
        // No JSP exists for this legacy route; the actual ITI Profile page is /reports/iti-profile
        return "redirect:/reports/iti-profile";
    }

    @GetMapping("/iti-list")
    public String itiList() {
        return "reports/iti-list";
    }

    @GetMapping("/trade-display2")
    public String tradeDisplay2() {
        return "reports/trade-display2";
    }

    @GetMapping("/district-schedule")
    public String districtSchedule() {
        return "reports/district-schedule";
    }

    @GetMapping("/shift-unit-report")
    public String shiftUnitReport() {
        return "reports/shift-unit-report";
    }

    @GetMapping("/admitted-seats-abstract")
    public String govtPvtAdmittedSeatsAbstract() {
        return "reports/admitted-seats-abstract";
    }

    @GetMapping("/all-resource-role")
    public String rolesReport() {
        return "reports/all-resource-role";
    }

    @GetMapping("/distwise-admitted-seats-abstract")
    public String seatsAbstractStrengthFilledInterface() {
        return "reports/distwise-admitted-seats-abstract";
    }

    @GetMapping("/trade-dist-wise-admission-report")
    public String tradewiseAdmissionReport() {
        return "reports/trade-dist-wise-admission-report";
    }

    @GetMapping("/tradewise-vacant-position")
    public String tradewiseVacantPosition() {
        return "reports/tradewise-vacant-position";
    }

    // ========== PUBLIC PAGES ==========

    @GetMapping("/about-strive")
    public String aboutStrive() {
        return "reports/about-strive";
    }

    @GetMapping("/disclosure-management")
    public String disclosureManagement() {
        return "reports/disclosure-management";
    }

    // ========== UTILITY ==========

    @GetMapping("/api-documentation")
    public String apiDocs() {
        return "reports/api-documentation";
    }
}
