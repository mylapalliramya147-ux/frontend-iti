package com.server.frontend.controller.Institute;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ItipageController {

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    private static final String REPORTS_PATH = "/api/reports";
    private static final String DISTRICTS_PATH = "/api/districts";
    private static final String DESIGNATIONS_PATH = "/api/designations";

    @GetMapping("/itiList")
    public String getItiList(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + REPORTS_PATH);
        return "Institute/ItiList";
    }

    @GetMapping("/iti-details")
    public String itiDetails(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + REPORTS_PATH);
        return "Institute/ItiDetails";
    }

    @GetMapping("/iti-create")
    public String itiCreate(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + REPORTS_PATH);
        model.addAttribute("districtApiUrl", backendBaseUrl + DISTRICTS_PATH);
        model.addAttribute("designationApiUrl", backendBaseUrl + DESIGNATIONS_PATH);
        return "Institute/ItiCreate";
    }

    @GetMapping("/iti-trade-selection")
    public String itiTradeSelection(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + REPORTS_PATH);
        model.addAttribute("backendApiBaseUrl", backendBaseUrl);
        return "Institute/ItiTradeSelection";
    }

    @GetMapping("/shift-unit-permitted")
    public String shiftUnitPermitted(Model model) {
        model.addAttribute("backendApiBaseUrl", backendBaseUrl);
        return "Institute/ShiftUnitPermitted";
    }
}
