package com.server.frontend.controller.reports;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "reports", description = "Reports UI pages and documentation endpoints")
@Controller
@RequestMapping("/reports")
public class ReportsController {

    private boolean hasRole(jakarta.servlet.http.HttpServletRequest request, String... allowedRoles) {
        jakarta.servlet.http.HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = session.getAttribute("roleId");
        if (roleId == null) return false;
        String roleStr = String.valueOf(roleId);
        for (String role : allowedRoles) {
            if (role.equals(roleStr)) return true;
        }
        return false;
    }

    // ========== STUDENTS NOT ADMITTED (Nodal + Admin) ==========

    @GetMapping("/students-not-admitted")
    public String studentsNotAdmitted(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/students-not-admitted";
    }

    // ========== DASHBOARD ==========
    @GetMapping("/")
    public String reportsDashboard() {
        return "reports/reports";
    }

    // ========== ITI LEVEL REPORTS (Role 4) ==========

    @GetMapping("/api-dashboard-iti")
    public String getDashboardReportIti(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/api-dashboard-iti";
    }

    @GetMapping("/applicant-report")
    public String applicantReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/applicant-report";
    }

    @GetMapping("/admission-report")
    public String apiReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "4")) return "redirect:/?error=session";
        return "reports/admission-report";
    }

    @GetMapping("/dsc-list")
    public String dscListSecondphase(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "4", "3", "1", "9", "10")) return "redirect:/?error=session";
        return "reports/dsc-list";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/caste-wise-admissions-abstract")
    public String statewideCastewiseAbstractInter(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "3", "1", "9")) return "redirect:/?error=session";
        return "reports/caste-wise-admissions-abstract";
    }

    @GetMapping("/applicant-address-with-mobile")
    public String applicantMobileAddr(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "3")) return "redirect:/?error=session";
        return "reports/applicant-address-with-mobile";
    }

    @GetMapping("/api-dashboard-district")
    public String getDashboardReportDist(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "3")) return "redirect:/?error=session";
        return "reports/api-dashboard-district";
    }

    @GetMapping("/verification-report")
    public String districtWiseApplicationCount(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "3", "10", "1", "9")) return "redirect:/?error=session";
        return "reports/verification-report";
    }

    // ========== NODAL LEVEL REPORTS (Role 10) ==========

    @GetMapping("/api-dashboard-state")
    public String jdGetDashboardReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/api-dashboard-state";
    }

    @GetMapping("/phase-wise-admissions-details")
    public String phaseWiseAdmissionReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/phase-wise-admissions-details";
    }

    @GetMapping("/today-schedule-itis")
    public String admissionScheduleIti(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/today-schedule-itis";
    }

    @GetMapping("/trade-wise-report")
    public String admissionGenderWise(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/trade-wise-report";
    }

    @GetMapping("/applicant-report-dist-wise")
    public String applicantReportStateWise(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
        return "reports/applicant-report-dist-wise";
    }

    @GetMapping("/dist-iti-trade-wise-seats-abstract")
    public String distWiseOpenSeats(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/dist-iti-trade-wise-seats-abstract";
    }

    @GetMapping("/duration-wise-trade-seats-abstract")
    public String tradeSeatsAbstractDurationWise(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/duration-wise-trade-seats-abstract";
    }

    @GetMapping("/govt-or-pvt-dist-wise-seats-abstract")
    public String govtPvtDistSeatsAbstract(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10", "1", "9")) return "redirect:/?error=session";
        return "reports/govt-or-pvt-dist-wise-seats-abstract";
    }

    @GetMapping("/student-reg-details")
    public String stdRegDetailsReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "10")) return "redirect:/?error=session";
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

    @GetMapping("/district-schedule")
    public String districtSchedule(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/district-schedule";
    }

    @GetMapping("/shift-unit-report")
    public String shiftUnitReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/shift-unit-report";
    }

    @GetMapping("/admitted-seats-abstract")
    public String govtPvtAdmittedSeatsAbstract(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/admitted-seats-abstract";
    }

    @GetMapping("/all-resource-role")
    public String rolesReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/all-resource-role";
    }

    @GetMapping("/distwise-admitted-seats-abstract")
    public String seatsAbstractStrengthFilledInterface(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/distwise-admitted-seats-abstract";
    }

    @GetMapping("/trade-dist-wise-admission-report")
    public String tradewiseAdmissionReport(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
        return "reports/trade-dist-wise-admission-report";
    }

    @GetMapping("/tradewise-vacant-position")
    public String tradewiseVacantPosition(jakarta.servlet.http.HttpServletRequest request) {
        if (!hasRole(request, "1", "9")) return "redirect:/?error=session";
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
