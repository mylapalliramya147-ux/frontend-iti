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
 * Admission Update lookup (ITI Login -&gt; Admissions -&gt; Admission Update).
 * Same legacy UI as the Discharge Admission page (gen.jpg banner,
 * pale-green menu-bar, dark-blue footer).
 * Page: GET /admissions/admission-update -&gt; admission/admissionUpdate.jsp
 * (Screen 1 Admission Number form + Screen 2 result).
 *
 * <p>Real backend (port 5050, Admission_Update_Controller):
 * {@code GET /admission/admission-update?admissionNumber=} -&gt;
 * Admission_Update_DTO (HTTP 200) or HTTP 404 ("Admission number not found").
 * Lookup only - no editable fields, no PUT/POST invented.
 */
@Controller
@RequestMapping("/admissions/admission-update")
public class AdmissionUpdateController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Admission Number form. */
    @GetMapping({ "", "/" })
    public String admissionUpdateView() {
        return "admission/admissionUpdate";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Validates the Admission Number (required), forwards to the real backend
     * API and returns the raw backend body with its status code.
     */
    @GetMapping("/api/admission-update")
    @ResponseBody
    public ResponseEntity<Object> admissionUpdate(
            @RequestParam(value = "admissionNumber", required = false) String admissionNumber) {
        String adm = admissionNumber == null ? "" : admissionNumber.trim();
        if (adm.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter Admission Number."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/admission-update")
                .queryParam("admissionNumber", adm)
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
                        .body(java.util.Map.of("error", "Please enter a valid Admission Number."));
            }
            if (code == 404) {
                return ResponseEntity.status(404)
                        .body(java.util.Map.of("error", "Admission number not found."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to retrieve admission details. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to connect to the server. Please make sure the backend is running."));
        }
    }
}
