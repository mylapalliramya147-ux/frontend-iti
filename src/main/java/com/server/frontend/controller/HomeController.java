package com.server.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/authHome")
    public String authHome() {
        return "checkmeritschedule/ScheduleEntry";
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
}