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
 * Admission Image Upload - first screen only (ITI Login -&gt; Admissions -&gt; Admission Image Upload).
 * Same legacy UI as the Admission Update / Discharge Admission pages (gen.jpg
 * banner, pale-green menu-bar, dark-blue footer).
 * Page: GET /admissions/admission-image-upload -&gt; admission/admissionImageUpload.jsp
 * (Screen 1 Admission Number + SSC Hallticket Number verify form + inline result).
 *
 * <p>Real backend (port 5050, Admission_Image_Upload_Controller):
 * {@code GET /admission/admission-image-upload?admissionNumber=&sscHallticketNumber=} -&gt;
 * Admission_Image_Upload_DTO {admissionNumber, sscHallticketNumber, registrationId, name}
 * (HTTP 200) or HTTP 404 ("Admission Number and SSC Hallticket Number do not match").
 * First screen only - no image upload controls invented.
 */
@Controller
@RequestMapping("/admissions/admission-image-upload")
public class AdmissionImageUploadController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Admission Number + SSC Hallticket Number form. */
    @GetMapping({ "", "/" })
    public String admissionImageUploadView() {
        return "admission/admissionImageUpload";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Trims both values (kept as String, never converted to Number), forwards to
     * the real backend API and returns the raw backend body with its status code.
     */
    @GetMapping("/api/admission-image-upload")
    @ResponseBody
    public ResponseEntity<Object> admissionImageUpload(
            @RequestParam(value = "admissionNumber", required = false) String admissionNumber,
            @RequestParam(value = "sscHallticketNumber", required = false) String sscHallticketNumber) {
        String adm = admissionNumber == null ? "" : admissionNumber.trim();
        String ssc = sscHallticketNumber == null ? "" : sscHallticketNumber.trim();
        if (adm.isEmpty() && ssc.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter Admission Number and SSC Hallticket Number."));
        }
        if (adm.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter Admission Number."));
        }
        if (ssc.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter SSC Hallticket Number."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/admission-image-upload")
                .queryParam("admissionNumber", adm)
                .queryParam("sscHallticketNumber", ssc)
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
                        .body(java.util.Map.of("error", "Please enter valid admission details."));
            }
            if (code == 404) {
                return ResponseEntity.status(404)
                        .body(java.util.Map.of("error", "Admission Number and SSC Hallticket Number do not match."));
            }
            if (code == 500) {
                return ResponseEntity.status(500)
                        .body(java.util.Map.of("error", "Unable to verify admission details. Please try again."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to verify admission details. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to connect to the server. Please make sure the backend is running."));
        }
    }
}
