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
 * Admission Search (ITI Login -&gt; Admissions -&gt; Search).
 * Same legacy government-portal UI as the other admission pages
 * (banner, pale-green menu-bar, dark-blue footer).
 *
 * <p>Page: GET /admissions/search -&gt; admission/search.jsp
 *
 * <p>Real backend (port 5050, Admission_Search_Controller):
 * {@code GET /admission/search?<criteria>} -&gt; a JSON array of
 * {@code Admission_Search_DTO} records (HTTP 200) or an empty array.
 * The frontend proxies the request same-origin so the JSP/JS never
 * hits CORS issues, forwarding only the query parameters the user
 * actually supplied.
 */
@Controller
@RequestMapping("/admissions/search")
public class SearchController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Search form page. */
    @GetMapping({ "", "/" })
    public String searchView() {
        return "admission/search";
    }

    /**
     * Same-origin proxy to the real backend search endpoint. Each optional
     * parameter is only appended when it is present and non-blank, so no
     * empty strings or unwanted defaults are ever forwarded. Leading zeros
     * are preserved because every parameter is treated as a String.
     */
    @GetMapping("/api/admission-search")
    @ResponseBody
    public ResponseEntity<Object> admissionSearch(
            @RequestParam(value = "admissionNumber", required = false) String admissionNumber,
            @RequestParam(value = "registrationNumber", required = false) String registrationNumber,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "fatherName", required = false) String fatherName,
            @RequestParam(value = "phoneNumber", required = false) String phoneNumber,
            @RequestParam(value = "gender", required = false) String gender,
            @RequestParam(value = "caste", required = false) String caste,
            @RequestParam(value = "reservationCategory", required = false) String reservationCategory,
            @RequestParam(value = "yearOfAdmission", required = false) String yearOfAdmission,
            @RequestParam(value = "dateOfAdmission", required = false) String dateOfAdmission,
            @RequestParam(value = "typeOfAdmission", required = false) String typeOfAdmission,
            @RequestParam(value = "currentSem", required = false) String currentSem,
            @RequestParam(value = "districtCode", required = false) String districtCode,
            @RequestParam(value = "itiCode", required = false) String itiCode,
            @RequestParam(value = "tradeCode", required = false) String tradeCode,
            @RequestParam(value = "phase", required = false) String phase) {

        UriComponentsBuilder builder = UriComponentsBuilder
                .fromUriString(backendBaseUrl + "/admission/search");

        addIfPresent(builder, "admissionNumber", admissionNumber);
        addIfPresent(builder, "registrationNumber", registrationNumber);
        addIfPresent(builder, "name", name);
        addIfPresent(builder, "fatherName", fatherName);
        addIfPresent(builder, "phoneNumber", phoneNumber);
        addIfPresent(builder, "gender", gender);
        addIfPresent(builder, "caste", caste);
        addIfPresent(builder, "reservationCategory", reservationCategory);
        addIfPresent(builder, "yearOfAdmission", yearOfAdmission);
        addIfPresent(builder, "dateOfAdmission", dateOfAdmission);
        addIfPresent(builder, "typeOfAdmission", typeOfAdmission);
        addIfPresent(builder, "currentSem", currentSem);
        addIfPresent(builder, "districtCode", districtCode);
        addIfPresent(builder, "itiCode", itiCode);
        addIfPresent(builder, "tradeCode", tradeCode);
        addIfPresent(builder, "phase", phase);

        String url = builder.toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (HttpStatusCodeException e) {
            int code = e.getStatusCode().value();
            if (code == 400) {
                return ResponseEntity.status(400)
                        .body(java.util.Map.of("error", "Invalid search criteria. Please check your input."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "The admission search service reported an error (HTTP " + code + "). Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error",
                            "Unable to connect to the server. Please make sure the backend is running."));
        }
    }

    private void addIfPresent(UriComponentsBuilder builder, String key, String value) {
        if (value != null && !value.trim().isEmpty()) {
            builder.queryParam(key, value.trim());
        }
    }
}
