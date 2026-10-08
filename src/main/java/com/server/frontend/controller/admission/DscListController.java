package com.server.frontend.controller.admission;

import java.util.Map;

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

/** DSC List (ITI Login - Admissions - DSC List). Real backend, no mock data. */
@Controller
@RequestMapping("/admissions/dsc-list")
public class DscListController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    @GetMapping({ "", "/" })
    public String dscListView() {
        return "admission/DscList";
    }

    @GetMapping("/api/dsc-list")
    @ResponseBody
    public ResponseEntity<Object> dscList(
            @RequestParam(value = "itiCode", required = false) String itiCode,
            @RequestParam(value = "tradeCode", required = false) String tradeCode,
            @RequestParam(value = "phase", required = false) String phase,
            @RequestParam(value = "year", required = false) String year,
            @RequestParam(value = "admissionLevel", required = false) String admissionLevel) {
        String iti = t(itiCode);
        String trade = t(tradeCode);
        String ph = t(phase);
        String yr = t(year);
        String level = t(admissionLevel);
        if (iti.isEmpty() || trade.isEmpty() || ph.isEmpty() || yr.isEmpty() || level.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error",
                    "Please select ITI Name, Trade, Phase, Year and Admission Performed in Level."));
        }
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/dsc-list")
                .queryParam("itiCode", iti).queryParam("tradeCode", trade)
                .queryParam("phase", ph).queryParam("year", yr)
                .queryParam("admissionLevel", level).toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (HttpStatusCodeException e) {
            String body = e.getResponseBodyAsString();
            if (body != null && !body.isBlank()) {
                return ResponseEntity.status(e.getStatusCode()).body(body);
            }
            return ResponseEntity.status(e.getStatusCode())
                    .body(Map.of("error", msg(e.getStatusCode().value())));
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(Map.of("error", "Unable to fetch DSC list. Please try again."));
        }
    }

    /** Existing backend dsc-options: ITI names/codes + trade names/codes. */
    @GetMapping("/api/dsc-options")
    @ResponseBody
    public ResponseEntity<Object> dscOptions(
            @RequestParam(value = "dist_code", required = false) String distCode,
            @RequestParam(value = "iti_code", required = false) String itiCode) {
        UriComponentsBuilder b = UriComponentsBuilder
                .fromUriString(backendBaseUrl + "/api/reports/dsc-options");
        if (distCode != null && !distCode.isBlank()) {
            b.queryParam("dist_code", distCode.trim());
        }
        if (itiCode != null && !itiCode.isBlank()) {
            b.queryParam("iti_code", itiCode.trim());
        }
        try {
            ResponseEntity<Object> resp = rest.getForEntity(b.toUriString(), Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(Map.of("error", "Unable to load ITI and trade options."));
        }
    }

    /** Existing backend current-admission-phase: defaults Year / Phase. */
    @GetMapping("/api/current-phase")
    @ResponseBody
    public ResponseEntity<Object> currentPhase() {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(
                    backendBaseUrl + "/api/reports/current-admission-phase", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(Map.of("error", "Unable to load current admission phase."));
        }
    }
    /** Existing backend admission phases: drives Phase / Year dropdowns. */
    @GetMapping("/api/phases")
    @ResponseBody
    public ResponseEntity<Object> phases() {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(
                    backendBaseUrl + "/api/admission-phase/all", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(502)
                    .body(Map.of("error", "Unable to load admission phases."));
        }
    }


    private static String msg(int status) {
        if (status == 400) {
            return "Invalid request. Please verify the selected criteria.";
        }
        if (status == 404) {
            return "No records found for the selected criteria.";
        }
        if (status == 500) {
            return "Backend error while generating DSC list. Please try again.";
        }
        return "Unable to fetch DSC list. Please try again.";
    }

    private static String t(String v) {
        return v == null ? "" : v.trim();
    }
}
