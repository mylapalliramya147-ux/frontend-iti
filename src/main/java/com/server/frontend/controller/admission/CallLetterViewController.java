package com.server.frontend.controller.admission;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Call Letter (DISTLOGIN -&gt; Admissions -&gt; Call Letter) two-screen flow.
 * Same legacy UI as the Schedule Entry / Counseling pages (gen.jpg banner,
 * pale-green menu-bar, dark-blue footer).
 * Page: GET /CallLetterView -&gt; admission/callLetterView.jsp (Screen 1
 * From Rank + To Rank + Caste form + Screen 2 results table).
 *
 * <p>Real backend (port 5050, Call_Letter_Controller):
 * {@code GET /admission/call-letter?rank=&caste=} -&gt; array of
 * Call_Letter_DTO {rank, caste, regid, itiCode, qualification, tempPk, phase,
 * trno, year, name}. The backend serves ONE rank per call, so a From..To range
 * is honoured by calling it once per rank here (server-side aggregation) and
 * returning the combined array. No backend change, no mock data, no new API.
 */
@Controller
@RequestMapping("/CallLetterView")
public class CallLetterViewController {

    private final RestTemplate rest = new RestTemplate();

    /** Safety cap so a huge range cannot hammer the backend. */
    private static final int MAX_RANGE = 100;

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - From Rank + To Rank + Caste selection form. */
    @GetMapping({ "", "/", "/Interface" })
    public String callLetterView() {
        return "admission/callLetterView";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Validates fromRank/toRank/caste, fans out to the real single-rank backend
     * endpoint once per rank, merges every returned record into one array.
     * Empty merged array means "no records" (backend reachable, nothing for that
     * range/caste). HTTP 5xx with {error} means the backend call itself failed.
     */
    @GetMapping("/api/call-letter")
    @ResponseBody
    public ResponseEntity<Object> callLetter(@RequestParam("fromRank") String fromRank,
            @RequestParam("toRank") String toRank,
            @RequestParam("caste") String caste) {
        int from;
        int to;
        try {
            from = Integer.parseInt(fromRank == null ? "" : fromRank.trim());
            to = Integer.parseInt(toRank == null ? "" : toRank.trim());
        } catch (NumberFormatException nfe) {
            return ResponseEntity.badRequest().body(Map.of("error", "From Rank and To Rank must be numeric."));
        }
        if (from <= 0 || to <= 0) {
            return ResponseEntity.badRequest().body(Map.of("error", "From Rank and To Rank must be positive numbers."));
        }
        if (from > to) {
            return ResponseEntity.badRequest().body(Map.of("error", "From Rank must not be greater than To Rank."));
        }
        if (to - from + 1 > MAX_RANGE) {
            return ResponseEntity.badRequest()
                    .body(Map.of("error", "Rank range too large. Please select at most " + MAX_RANGE + " ranks."));
        }
        String casteValue = caste == null ? "" : caste.trim();
        if (casteValue.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("error", "Caste is required."));
        }

        List<Object> merged = new ArrayList<>();
        int okCalls = 0;
        int failCalls = 0;
        for (int rank = from; rank <= to; rank++) {
            String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/call-letter")
                    .queryParam("rank", rank)
                    .queryParam("caste", casteValue)
                    .toUriString();
            try {
                ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                        new ParameterizedTypeReference<Object>() {
                        });
                okCalls++;
                merged.addAll(toList(resp.getBody()));
            } catch (Exception e) {
                failCalls++;
            }
        }
        if (okCalls == 0 && failCalls > 0) {
            Map<String, Object> err = new LinkedHashMap<>();
            err.put("error", "Backend unavailable. Please try again later.");
            return ResponseEntity.status(502).body(err);
        }
        return ResponseEntity.ok(merged);
    }

    private static List<Object> toList(Object body) {
        if (body instanceof List<?> list) {
            return new ArrayList<>(list);
        }
        if (body instanceof Map<?, ?> map) {
            Object data = map.get("data");
            if (data instanceof List<?> dataList) {
                return new ArrayList<>(dataList);
            }
        }
        return new ArrayList<>();
    }
}
