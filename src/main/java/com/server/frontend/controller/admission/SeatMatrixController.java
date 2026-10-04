package com.server.frontend.controller.admission;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/**
 * Seat Matrix (DISTLOGIN -&gt; Admissions -&gt; seatmatrix) flow.
 * Same legacy UI as the Admission Counseling pages (gen.jpg banner,
 * pale-green menu-bar, dark-blue footer).
 * Page: GET /SeatMatrix -&gt; admission/seatMatrix.jsp (Screen 1 form +
 * screens 2/3/4 result section). Year is display-only: the backend
 * GET /admission/vacant-seats/{itiCode}/{tradeShort} has no year param.
 */
@Controller
@RequestMapping("/SeatMatrix")
public class SeatMatrixController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - ITI + Trade + Year selection form. */
    @GetMapping({ "", "/", "/Interface" })
    public String seatMatrix() {
        return "admission/seatMatrix";
    }

    /** Proxy: GET /admission/vacant-seats/{itiCode}/{tradeShort}. */
    @GetMapping("/api/vacant-seats/{itiCode}/{tradeShort}")
    @ResponseBody
    public ResponseEntity<Object> vacantSeats(@PathVariable("itiCode") String itiCode,
            @PathVariable("tradeShort") String tradeShort) {
        String url = backendBaseUrl + "/admission/vacant-seats/"
                + itiCode.trim() + "/" + tradeShort.trim();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Proxy: GET /admission/district/{distCode}/itis - {itiCode, itiName, govt}. */
    @GetMapping("/api/district/{distCode}/itis")
    @ResponseBody
    public ResponseEntity<Object> itisByDistrict(@PathVariable("distCode") String distCode) {
        String url = backendBaseUrl + "/admission/district/" + distCode.trim() + "/itis";
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Proxy: GET /admission/itis/{distCode} - plain ITI name list. */
    @GetMapping("/api/itis/{distCode}")
    @ResponseBody
    public ResponseEntity<Object> itiNames(@PathVariable("distCode") String distCode) {
        String url = backendBaseUrl + "/admission/itis/" + distCode.trim();
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Proxy: GET /admission/iti/{itiCode}/trades - trades for one ITI. */
    @GetMapping("/api/iti/{itiCode}/trades")
    @ResponseBody
    public ResponseEntity<Object> tradesByIti(@PathVariable("itiCode") String itiCode) {
        String url = backendBaseUrl + "/admission/iti/" + itiCode.trim() + "/trades";
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }
}
