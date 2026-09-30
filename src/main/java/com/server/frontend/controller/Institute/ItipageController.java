package com.server.frontend.controller.Institute;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ItipageController {

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    // The ITI list/detail/create pages read the ITI master, whose endpoint is
    // /api/itis. (This used to point at /api/reports, which has no bare route
    // and returned 404, so every ITI dropdown/table failed to load.)
    private static final String ITIS_PATH = "/api/itis";
    private static final String DISTRICTS_PATH = "/api/districts";
    private static final String DESIGNATIONS_PATH = "/api/designations";
    private static final String SHIFT_UNIT_PATH = "/api/shift-unit-permitted";

    @GetMapping("/itiList")
    public String getItiList(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + ITIS_PATH);
        return "Institute/ItiList";
    }

    @GetMapping("/iti-details")
    public String itiDetails(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + ITIS_PATH);
        return "Institute/ItiDetails";
    }

    @GetMapping("/iti-create")
    public String itiCreate(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + ITIS_PATH);
        model.addAttribute("districtApiUrl", backendBaseUrl + DISTRICTS_PATH);
        model.addAttribute("designationApiUrl", backendBaseUrl + DESIGNATIONS_PATH);
        // Form submission target (POST /api/itis); previously unset, so the
        // create form posted to "" (the page itself) and always failed.
        model.addAttribute("itiRegistrationApiUrl", backendBaseUrl + ITIS_PATH);
        return "Institute/ItiCreate";
    }

    @GetMapping("/iti-trade-selection")
    public String itiTradeSelection(Model model) {
        model.addAttribute("itiApiUrl", backendBaseUrl + ITIS_PATH);
        model.addAttribute("backendApiBaseUrl", backendBaseUrl);
        // The JSP loads the trade master list from here; without this attribute
        // it rendered const itiTradesApiUrl = "" and fetched the page itself.
        model.addAttribute("itiTradesApiUrl", backendBaseUrl + "/api/trades");
        return "Institute/ItiTradeSelection";
    }

    @GetMapping("/shift-unit-permitted")
    public String shiftUnitPermitted(Model model) {
        model.addAttribute("backendApiBaseUrl", backendBaseUrl);
        // GET ?itiCode&tradeCode to read, PUT to save; previously unset, so the
        // page fetched "" (itself) for both operations.
        model.addAttribute("shiftUnitApiUrl", backendBaseUrl + SHIFT_UNIT_PATH);
        return "Institute/ShiftUnitPermitted";
    }
}
