package com.server.frontend.controller.reports;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "reports", description = "Reports UI pages and documentation endpoints")
@Controller
@RequestMapping("/reports")
public class ReportsController {

    private boolean hasRole(HttpServletRequest request, String... allowedRoles) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionUser") == null) {
            return false;
        }
        return true;
    }

    // ========== STUDENTS NOT ADMITTED (Nodal + Admin + State) ==========

    @GetMapping("/students-not-admitted")
    public String studentsNotAdmitted(HttpServletRequest request) {
        if (!hasRole(request, "10", "3", "4")) return "redirect:/?error=session";
        return "reports/students-not-admitted";
    }

    // ========== DASHBOARD ==========
    @GetMapping("/")
    public String reportsDashboard() {
        return "reports/reports";
    }

    // ========== ITI LEVEL REPORTS (Role 4) ==========

    @GetMapping("/api-dashboard-iti")
    public String getDashboardReportIti(HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/api-dashboard-iti";
    }

    @GetMapping("/applicant-report")
    public String applicantReport(HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/applicant-report";
    }

    @GetMapping("/admission-report")
    public String apiReport(HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/admission-report";
    }

    @GetMapping("/dsc-list")
    public String dscListSecondphase(HttpServletRequest request) {
        if (!hasRole(request, "4", "3", "10")) return "redirect:/?error=session";
        return "reports/dsc-list";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/caste-wise-admissions-abstract")
    public String statewideCastewiseAbstractInter(HttpServletRequest request) {
        if (!hasRole(request, "3", "10")) return "redirect:/?error=session";
        return "reports/caste-wise-admissions-abstract";
    }

    @GetMapping("/applicant-address-with-mobile")
    public String applicantMobileAddr(HttpServletRequest request) {
        if (!hasRole(request, "3")) return "redirect:/?error=session";
        return "reports/applicant-address-with-mobile";
    }

    @GetMapping("/api-dashboard-district")
    public String getDashboardReportDist(HttpServletRequest request) {
        if (!hasRole(request, "3")) return "redirect:/?error=session";
        return "reports/api-dashboard-district";
    }

    @GetMapping("/verification-report")
    public String districtWiseApplicationCount(HttpServletRequest request) {
        if (!hasRole(request, "3", "10")) return "redirect:/?error=session";
        return "reports/verification-report";
    }

    // ========== NODAL LEVEL REPORTS (Role 10) ==========

    @GetMapping("/api-dashboard-state")
    public String jdGetDashboardReport(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/api-dashboard-state";
    }

    @GetMapping("/phase-wise-admissions-details")
    public String phaseWiseAdmissionReport(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/phase-wise-admissions-details";
    }

    @GetMapping("/today-schedule-itis")
    public String admissionScheduleIti(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/today-schedule-itis";
    }

    @GetMapping("/trade-wise-report")
    public String admissionGenderWise(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/trade-wise-report";
    }

    @GetMapping("/applicant-report-dist-wise")
    public String applicantReportStateWise(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/applicant-report-dist-wise";
    }

    @GetMapping("/dist-iti-trade-wise-seats-abstract")
    public String distWiseOpenSeats(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/dist-iti-trade-wise-seats-abstract";
    }

    @GetMapping("/duration-wise-trade-seats-abstract")
    public String tradeSeatsAbstractDurationWise(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/duration-wise-trade-seats-abstract";
    }

    @GetMapping("/govt-or-pvt-dist-wise-seats-abstract")
    public String govtPvtDistSeatsAbstract(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/govt-or-pvt-dist-wise-seats-abstract";
    }

    @GetMapping("/student-reg-details")
    public String stdRegDetailsReport(HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/student-reg-details";
    }

    // ========== STATE / ADMIN LEVEL REPORTS ==========

    @GetMapping("/district-schedule")
    public String districtSchedule(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/district-schedule";
    }

    @GetMapping({"/shift-unit-report", "/permitted_shift_unit_report"})
    public String shiftUnitReport(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/shift-unit-report";
    }

    @GetMapping("/admitted-seats-abstract")
    public String govtPvtAdmittedSeatsAbstract(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/admitted-seats-abstract";
    }

    @GetMapping("/all-resource-role")
    public String rolesReport(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/all-resource-role";
    }

    @GetMapping("/distwise-admitted-seats-abstract")
    public String seatsAbstractStrengthFilledInterface(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/distwise-admitted-seats-abstract";
    }

    @GetMapping("/trade-dist-wise-admission-report")
    public String tradewiseAdmissionReport(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/trade-dist-wise-admission-report";
    }

    @GetMapping("/tradewise-vacant-position")
    public String tradewiseVacantPosition(HttpServletRequest request) {
        if (!hasRole(request)) return "redirect:/?error=session";
        return "reports/tradewise-vacant-position";
    }

    // ========== ITI PROFILE & TRADE DISPLAY ==========

    @GetMapping("/iti-profile")
    public String itiProfile() {
        return "reports/iti-profile";
    }

    @GetMapping("/trade-display1")
    public String tradeDisplay1() {
        return "redirect:/reports/iti-profile";
    }

    @RequestMapping(value = {"/trade-display2", "/trade_display2.jsp"})
    public String tradeDisplay2() {
        return "reports/trade-display2";
    }

    // ========== PUBLIC PAGES ==========

    @GetMapping("/iti-list")
    public String itiList() {
        return "reports/iti-list";
    }

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
