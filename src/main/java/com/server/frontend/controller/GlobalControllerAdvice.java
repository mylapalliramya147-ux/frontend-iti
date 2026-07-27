package com.server.frontend.controller;

import com.server.frontend.config.BackendApiConfig;
<<<<<<< HEAD
=======
import org.springframework.beans.factory.annotation.Autowired;
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

<<<<<<< HEAD
    private final BackendApiConfig backendApiConfig;

    public GlobalControllerAdvice(BackendApiConfig backendApiConfig) {
        this.backendApiConfig = backendApiConfig;
    }
=======
    @Autowired
    private BackendApiConfig backendApiConfig;
>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a

    @ModelAttribute("backendApiUrl")
    public String getBackendApiUrl() {
        return backendApiConfig.getFullReportsUrl();
    }

    @ModelAttribute("backendBaseUrl")
    public String getBackendBaseUrl() {
        return backendApiConfig.getBaseUrl();
    }
}