package com.server.frontend.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/authHome")
    public String authHome(HttpServletRequest request) {
        if (request.getSession(false) == null || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/?error=session";
        }
        // role 4 = ITI user -> ITI landing page; other roles get the generic welcome page for now
        Object roleId = request.getSession().getAttribute("roleId");
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

    @GetMapping("/")
    public String home() {
        return "jsp/index";
    }
}