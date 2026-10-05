package com.server.frontend.controller.admission;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Controller
@RequestMapping("/PrintAdmissionSlip")
public class PrintAdmissionSlipController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    @GetMapping({ "", "/", "/Interface" })
    public String admissionSlipView() {
        return "admission/PrintAdmissionSlip";
    }

    @GetMapping("/api/admission-slip")
    @ResponseBody
    public ResponseEntity<Object> admissionSlip(
            @RequestParam(value = "admissionNumber", required = false) String admissionNumber) {
        String adm = admissionNumber == null ? "" : admissionNumber.trim();
        if (adm.isEmpty()) {
            return ResponseEntity.badRequest().body(java.util.Map.of("error", "Please enter Admission Number."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/admission-slip")
                .queryParam("admissionNumber", adm).toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (HttpStatusCodeException e) {
            int code = e.getStatusCode().value();
            if (code == 404) {
                return ResponseEntity.status(404).body(java.util.Map.of("error", "Admission number not found."));
            }
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to fetch admission slip. Please try again."));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(java.util.Map.of("error", "Unable to fetch admission slip. Please try again."));
        }
    }

    /** Reusable master-data proxy: GET /admission/master-data - {itiNames[], tradeNames[]}. */
    @GetMapping("/api/master-data")
    @ResponseBody
    public ResponseEntity<Object> masterData() {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(backendBaseUrl + "/admission/master-data", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(java.util.Map.of("itiNames", new Object[0], "tradeNames", new Object[0]));
        }
    }

    /** Reusable proxy: GET /admission/district/{distCode}/itis - {itiCode, itiName, govt}. */
    @GetMapping("/api/district/{distCode}/itis")
    @ResponseBody
    public ResponseEntity<Object> itisByDistrict(@PathVariable("distCode") String distCode) {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(
                    backendBaseUrl + "/admission/district/" + distCode.trim() + "/itis", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Reusable proxy: GET /admission/iti/{itiCode}/trades - trades for one ITI. */
    @GetMapping("/api/iti/{itiCode}/trades")
    @ResponseBody
    public ResponseEntity<Object> tradesByIti(@PathVariable("itiCode") String itiCode) {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(
                    backendBaseUrl + "/admission/iti/" + itiCode.trim() + "/trades", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }
}
