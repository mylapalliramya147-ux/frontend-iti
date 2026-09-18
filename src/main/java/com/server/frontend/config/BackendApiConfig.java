package com.server.frontend.config;

import org.springframework.stereotype.Component;

/**
 * Read-only facade over {@link BackendApiProperties} so existing callers
 * ({@code getBaseUrl(group)}, {@code getPath(group)}, {@code getFullUrl(group)})
 * keep working unchanged, while property resolution is now type-safe
 * (no more "unknown property" warnings in the IDE).
 */
@Component
public class BackendApiConfig {

    private final BackendApiProperties properties;

    public BackendApiConfig(BackendApiProperties properties) {
        this.properties = properties;
    }

    public String getBaseUrl(String group) {
        BackendApiProperties.ApiGroup apiGroup = properties.getApi().get(group);
        return apiGroup != null ? apiGroup.getBaseUrl() : null;
    }

    public String getPath(String group) {
        BackendApiProperties.ApiGroup apiGroup = properties.getApi().get(group);
        return apiGroup != null ? apiGroup.getPath() : null;
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
