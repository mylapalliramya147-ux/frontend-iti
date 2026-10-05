package com.server.frontend.controller.admission;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Application Reprint (DISTLOGIN -&gt; Admissions -&gt; Application Reprint).
 * Same legacy UI as the Discharge Admission / Call Letter pages (gen.jpg
 * banner, pale-green menu-bar, dark-blue footer).
 * Page: GET /admissions/application-reprint -&gt; admission/applicationReprint.jsp
 * (Screen 1 Registration Id form + Screen 2 result).
 *
 * <p>Real backend (port 5050, Application_Reprint_Controller):
 * {@code GET /admission/application-reprint?registrationId=} -&gt;
 * Application_Reprint_DTO (HTTP 200) or HTTP 404
 * ("Application not found for the given Registration Id").
 * The Registration Id is kept as a String end-to-end (never parsed to a
 * JavaScript Number / Java int) so large Java Long ids keep full precision.
 */
@Controller
@RequestMapping("/admissions/application-reprint")
public class ApplicationReprintController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Registration Id form. */
    @GetMapping({ "", "/" })
    public String applicationReprintView() {
        return "admission/applicationReprint";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Validates the Registration Id (required, digits only), forwards it as a
     * String to the real backend API and returns the raw backend body with its
     * status code. Backend 400/404 messages are mapped to user-friendly text;
     * backend 5xx / unreachable backend map to 502 with a friendly message.
     */
    @GetMapping("/api/application-reprint")
    @ResponseBody
    public ResponseEntity<Object> applicationReprint(
            @RequestParam(value = "registrationId", required = false) String registrationId) {
        String reg = registrationId == null ? "" : registrationId.trim();
        if (reg.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter Registration Id."));
        }
        if (!reg.matches("\\d{1,19}")) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter a valid Registration Id."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/application-reprint")
                .queryParam("registrationId", reg)
                .toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (HttpStatusCodeException e) {
            int code = e.getStatusCode().value();
            if (code == 400) {
                return ResponseEntity.status(400)
                        .body(java.util.Map.of("error", "Please enter a valid Registration Id."));
            }
            if (code == 404) {
                return ResponseEntity.status(404)
                        .body(java.util.Map.of("error", "Application not found for the given Registration Id."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to retrieve application details. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to connect to the server. Please make sure the backend is running."));
        }
    }
}
