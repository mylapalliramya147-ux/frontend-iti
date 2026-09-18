package com.server.frontend.controller;

import com.server.frontend.config.BackendApiConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

    private final BackendApiConfig backendApiConfig;

    @Value("${backend.api.base-url:http://localhost:5050}")
    private String backendBaseUrl;

    public GlobalControllerAdvice(BackendApiConfig backendApiConfig) {
        this.backendApiConfig = backendApiConfig;
    }

    @ModelAttribute("backendApiUrl")
    public String getBackendApiUrl() {
        return backendApiConfig.getFullUrl("reports");
    }

    @ModelAttribute("backendBaseUrl")
    public String getBackendBaseUrl() {
        return backendBaseUrl;
    }
}