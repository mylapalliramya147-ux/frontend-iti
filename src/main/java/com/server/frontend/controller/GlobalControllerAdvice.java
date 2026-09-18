package com.server.frontend.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    private static final String REPORTS_PATH = "/api/reports";

    @ModelAttribute("backendApiUrl")
    public String getBackendApiUrl() {
        return backendBaseUrl + REPORTS_PATH;
    }

    @ModelAttribute("backendBaseUrl")
    public String getBackendBaseUrl() {
        return backendBaseUrl;
    }
}