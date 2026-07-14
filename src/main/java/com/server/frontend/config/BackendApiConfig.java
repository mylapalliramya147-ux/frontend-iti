package com.server.frontend.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "backend.api")
public class BackendApiConfig {
    private String baseUrl;
    private String reportsPath;

    public String getBaseUrl() {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }

    public String getReportsPath() {
        return reportsPath;
    }

    public void setReportsPath(String reportsPath) {
        this.reportsPath = reportsPath;
    }

    public String getFullReportsUrl() {
        return baseUrl + reportsPath;
    }
}