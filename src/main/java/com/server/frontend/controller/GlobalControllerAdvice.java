package com.server.frontend.controller;

import com.server.frontend.config.BackendApiConfig;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    private final BackendApiConfig backendApiConfig;

    public GlobalControllerAdvice(BackendApiConfig backendApiConfig) {
        this.backendApiConfig = backendApiConfig;
    }

    @ModelAttribute("backendApiUrl")
    public String getBackendApiUrl() {
        return backendApiConfig.getFullReportsUrl();
    }

    @ModelAttribute("backendBaseUrl")
    public String getBackendBaseUrl() {
        return backendApiConfig.getBaseUrl();
    }
}