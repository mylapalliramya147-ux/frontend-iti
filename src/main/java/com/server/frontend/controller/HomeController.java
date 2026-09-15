package com.server.frontend.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/authHome")
    public String authHome(HttpServletRequest request) {
        HttpSession authSession = request.getSession(false);
        if (authSession == null || authSession.getAttribute("sessionUser") == null) {
            return "redirect:/?error=session";
        }
        // role 4 = ITI user -> ITI landing page; other roles get the generic welcome page for now
        Object roleId = authSession.getAttribute("roleId");
        if (roleId != null && "4".equals(String.valueOf(roleId))) {
            return "jsp/authHome_iti";
        }
        return "jsp/authHome";
    }

    @GetMapping("/MeritList")
    public String meritList() {
        return "checkmeritschedule/MeritList";
    }

    @GetMapping("/MeritResults")
    public String meritResults() {
        return "checkmeritschedule/MeritResults";
    }

    @GetMapping("/AdmissionPhase")
    public String admissionPhase() {
        return "checkmeritschedule/AdmissionPhase";
    }

    @GetMapping("/AdmissionPhase1")
    public String admissionPhase1() {
        return "checkmeritschedule/admissionPhase1";
    }

    @GetMapping("/DgtPermittedShift")
    public String dgtPermittedShift() {
        return "checkmeritschedule/DscList";
    }

    @GetMapping("/VerificationReport")
    public String verificationReport() {
        return "checkmeritschedule/distVerification";
    }

    @GetMapping("/PrintAdmissionSlip")
    public String printAdmissionSlip() {
        return "checkmeritschedule/admissionIntialization";
    }

    @GetMapping("/district-dsc-full")
    public String districtDscFull() {
        return "reports/district-dsc-full-view";
    }

    @GetMapping("/applicant-report-by-phase")
    public String applicantReportByPhase() {
        return "reports/district-applicant-report-view";
    }

    @GetMapping("/nodal-report/dashboard")
    public String nodalReportDashboard() {
        return "reports/state-dashboard";
    }

    @GetMapping("/placements")
    public String placements(HttpServletRequest request) {
        request.setAttribute("captchaText", CaptchaController.current(request));
        return "jsp/placements";
    }

    /**
     * Authenticated ITI placements dashboard (the page shown to ITI users after a
     * successful placements login). Session is required; otherwise the request is
     * bounced back to the placements login form.
     */
    @GetMapping("/placements/loginSuccess")
    public String placementsLoginSuccess(HttpServletRequest request) {
        HttpSession placementSession = request.getSession(false);
        if (placementSession == null
                || placementSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "jsp/placementDashboard";
    }

    @GetMapping("/")
    public String home() {
        return "jsp/index";
    }
}