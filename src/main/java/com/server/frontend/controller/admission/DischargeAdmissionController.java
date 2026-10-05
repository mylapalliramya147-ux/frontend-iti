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
 * Discharge Admission (DISTLOGIN -&gt; Admissions -&gt; Discharge Admission).
 * Same legacy UI as the Print Admission Slip / Schedule Entry pages (gen.jpg
 * banner, pale-green menu-bar, dark-blue footer).
 * Page: GET /admissions/discharge-admission -&gt; admission/dischargeAdmission.jsp
 * (Screen 1 Admission Number + Year form + Screen 2 result).
 *
 * <p>Real backend (port 5050, Discharge_Admission_Controller):
 * {@code GET /admission/discharge-admission?admissionNumber=&year=} -&gt;
 * Discharge_Admission_DTO {admissionNumber, year} (HTTP 200) or HTTP 404
 * ("Admission number not found for the given year").
 */
@Controller
@RequestMapping("/admissions/discharge-admission")
public class DischargeAdmissionController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Admission Number + Year form. */
    @GetMapping({ "", "/" })
    public String dischargeAdmissionView() {
        return "admission/dischargeAdmission";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Validates both fields, forwards to the real backend API and returns the
     * raw backend body with its status code. 404 maps to the backend's
     * "not found for the given year" message; other failures map to 502.
     */
    @GetMapping("/api/discharge-admission")
    @ResponseBody
    public ResponseEntity<Object> dischargeAdmission(
            @RequestParam(value = "admissionNumber", required = false) String admissionNumber,
            @RequestParam(value = "year", required = false) String year) {
        String adm = admissionNumber == null ? "" : admissionNumber.trim();
        String yr = year == null ? "" : year.trim();
        if (adm.isEmpty() || yr.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(java.util.Map.of("error", "Please enter Admission Number and Year."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/discharge-admission")
                .queryParam("admissionNumber", adm)
                .queryParam("year", yr)
                .toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (HttpStatusCodeException e) {
            int code = e.getStatusCode().value();
            if (code == 404) {
                return ResponseEntity.status(404)
                        .body(java.util.Map.of("error", "Admission number not found for the given year."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to fetch discharge admission details. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to fetch discharge admission details. Please try again."));
        }
    }
}
