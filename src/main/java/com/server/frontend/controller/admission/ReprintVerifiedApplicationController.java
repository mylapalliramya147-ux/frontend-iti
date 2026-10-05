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
 * Reprint Verified Application (TESTNODAL -&gt; Admissions -&gt; Reprint
 * Verified Application). This is SEPARATE from the DISTLOGIN Application
 * Reprint page and does NOT use {@code /admission/application-reprint}.
 * Same legacy UI as the Discharge Admission / Call Letter pages (gen.jpg
 * banner, pale-green menu-bar, dark-blue footer).
 * Page: GET /admissions/reprint-verified-application -&gt;
 * admission/reprintVerifiedApplication.jsp (Screen 1 Registration Id form +
 * Screen 2 verified-application document).
 *
 * <p>Backend evidence (no dedicated reprint-verified endpoint exists anywhere
 * in the project): the legacy {@code printVeriedApplication.jsp} verification
 * acknowledgment was fed by legacy {@code POST /checkRegOrNot}, which has no
 * backend implementation. The only existing backend API returning the full
 * verified application record from the {@code student_application} table
 * (including verification fields verifiedDate / appStatus / userId plus the
 * document flags) is {@code GET /api/student/{regid}}
 * (StudentApplicationController -&gt; StudentApplicationDto). The DISTLOGIN
 * {@code /admission/application-reprint} DTO is only a subset and omits the
 * verification fields, so it is not reused here.
 */
@Controller
@RequestMapping("/admissions/reprint-verified-application")
public class ReprintVerifiedApplicationController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Registration Id form. */
    @GetMapping({ "", "/" })
    public String reprintVerifiedApplicationView() {
        return "admission/reprintVerifiedApplication";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Validates the Registration Id (required, digits only, kept as a String)
     * and forwards to the existing {@code GET /api/student/{regid}} backend
     * API with no backend changes. Backend 404 ("Student Not Found") maps to
     * "Verified application not found."; other failures map to 502.
     */
    @GetMapping("/api/reprint-verified-application")
    @ResponseBody
    public ResponseEntity<Object> reprintVerifiedApplication(
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
        String url = UriComponentsBuilder
                .fromUriString(backendBaseUrl + "/api/student/" + reg)
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
                        .body(java.util.Map.of("error", "Verified application not found."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to retrieve the verified application. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to connect to the server. Please make sure the backend is running."));
        }
    }
}
