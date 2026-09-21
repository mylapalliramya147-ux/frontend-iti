package com.server.frontend.config;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Type-safe binding for all {@code backend.api-groups.<group>.base-url} /
 * {@code backend.api-groups.<group>.path} properties.
 *
 * <p>Using a {@code Map<String, ApiGroup>} under prefix {@code backend.api-groups}
 * lets Spring Boot (and the vscode-spring-boot language server via the
 * annotation processor) see these properties statically, so
 * {@code application.properties} no longer reports
 * "'backend.api-groups.iti.base-url' is an unknown property".
 *
 * <p>NOTE: the prefix used to be plain {@code backend}, which made every
 * {@code backend.api.*} key a map entry of type {@link ApiGroup}. That collided
 * with the single {@code backend.api.base-url} property the Frontend now uses
 * for all modules, causing a fatal
 * {@code ConverterNotFoundException: ... String to ApiGroup} at startup.
 * The map therefore lives under {@code backend.api-groups} and
 * {@code backend.api.base-url} stays a plain property.
 *
 * <p>Hyphenated group names (e.g. {@code iti-application}, {@code shift-unit})
 * work as plain map keys. Relaxed binding maps {@code base-url} to
 * {@code baseUrl} automatically.
 */
@ConfigurationProperties(prefix = "backend.api-groups")
public class BackendApiProperties {

    /**
     * Keyed by API group name: {@code iti}, {@code reports},
     * {@code iti-application}, {@code districts}, {@code designations},
     * {@code shift-unit}, {@code iti-create}, {@code iti-trades}, ...
     */
    private Map<String, ApiGroup> api = new HashMap<>();

    public Map<String, ApiGroup> getApi() {
        return api;
    }

    public void setApi(Map<String, ApiGroup> api) {
        this.api = api;
    }

    public static class ApiGroup {

        /**
         * Base URL (scheme://host:port plus optional context path such as
         * /ItiapInstitute) of the backend service for this API group.
         */
        private String baseUrl;

        /**
         * Context path of this API group (e.g. /api/itis). Appended to
         * {@code baseUrl} by {@code BackendApiConfig#getFullUrl(String)}.
         */
        private String path;

        public String getBaseUrl() {
            return baseUrl;
        }

        public void setBaseUrl(String baseUrl) {
            this.baseUrl = baseUrl;
        }

        public String getPath() {
            return path;
        }

        public void setPath(String path) {
            this.path = path;
        }
    }
}
