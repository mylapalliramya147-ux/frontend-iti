package com.server.frontend.config;

import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class BackendApiConfig {

    private final Environment environment;

    public BackendApiConfig(Environment environment) {
        this.environment = environment;
    }

    public String getBaseUrl(String group) {
        return environment.getProperty("backend.api." + group + ".base-url");
    }

    public String getPath(String group) {
        return environment.getProperty("backend.api." + group + ".path");
    }

    public String getFullUrl(String group) {
        String baseUrl = getBaseUrl(group);
        String path = getPath(group);
        if (baseUrl != null && path != null) {
            return baseUrl + path;
        }
        return null;
    }
}