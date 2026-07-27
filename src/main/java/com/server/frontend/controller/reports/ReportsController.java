package com.server.frontend.controller.reports;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

<<<<<<< HEAD
@Controller
@RequestMapping("/reports")
public class ReportsController {

    @GetMapping("/unified-reports")
    public String unifiedReports() {
        return "reports/unified_reports";
=======
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
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/admission-report")
    public String admissionReport() {
<<<<<<< HEAD
        return "reports/admission_report";
=======
        return "admission_report";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/district-dsc-full")
    public String districtDscFull() {
<<<<<<< HEAD
        return "reports/district-dsc-full-view";
=======
        return "district-dsc-full-view";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/district-applicant-report")
    public String districtApplicantReport() {
<<<<<<< HEAD
        return "reports/district-applicant-report-view";
=======
        return "district-applicant-report-view";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/district-caste-wise")
    public String districtCasteWise() {
<<<<<<< HEAD
        return "reports/district-caste-wise-view";
    }

    @GetMapping("/district-iti-wise-year")
    public String districtItiWiseYear() {
        return "reports/district-iti-wise-year-view";
=======
        return "district-caste-wise-view";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/district-permitted-shift")
    public String districtPermittedShift() {
<<<<<<< HEAD
        return "reports/district-permitted-shift-view";
=======
        return "district-permitted-shift-view";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/district-verified-count")
    public String districtVerifiedCount() {
<<<<<<< HEAD
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
=======
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
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }

    @GetMapping("/api-docs")
    public String apiDocs() {
<<<<<<< HEAD
        return "reports/swagger";
=======
        return "swagger";
    }

    @GetMapping("/about-strive")
    public String aboutStrive() {
        return "aboutstrive";
    }

    @GetMapping("/disclosure-management")
    public String disclosureManagement() {
        return "disclosuremanagement";
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
    }
}
