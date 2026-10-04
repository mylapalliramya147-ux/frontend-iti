package com.server.frontend.controller.admission;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Admission Counseling (DCP seat-allotment) flow.
 *
 * <p>Rebuilds documentation screens 2-4 in the SAME legacy UI as the live
 * site (screenshot 1: gen.jpg banner + pale-green #menu-bar + dark-blue
 * footer):
 *
 * <ol>
 *   <li>GET /AdmissionCounseling/Start - "Start Admission Process - Select
 *       all the following" (Caste, Qualification, Admission Timings, Phase,
 *       Year) - docs screen 2/3 first form
 *       (old startAdmission_ConvvinerLevel.jsp).</li>
 *   <li>GET /AdmissionCounseling/Counseling - "Admission Counseling" rank
 *       entry + candidate info + district ITI/trade seat matrix + "Take
 *       Admission" memo - docs screens 3/4
 *       (old itiAdmissionEntry.do).</li>
 * </ol>
 *
 * <p>Backend (port 5050, per swagger tag "admissions",
 * operationId "getCandidatesByRank"):
 * {@code GET /admission/candidate?rank=&phase=&year=}
 * -&gt; array of CandidateResponseDTO
 * {regid, rank, qual, dist_code, iti_code, phase, year, app_status}.
 * The same-origin /api/counseling/* proxies below forward to it so the
 * JSP/JS never hits CORS issues.
 */
@Controller
@RequestMapping("/AdmissionCounseling")
public class AdmissionCounselingController {

    private final RestTemplate rest = new RestTemplate();

    /** Timeout + small result cache so repeat rank lookups feel instant. */
    private static final long RESOLVE_TIMEOUT_MS = 25000L;
    private static final Map<String, Object> RESOLVE_CACHE = new ConcurrentHashMap<>();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    // ========== PAGES (legacy UI, same chrome as live site) ==========

    /** Docs screen 2/3 - Start Admission Process form. */
    @GetMapping("/Start")
    public String start() {
        return "admission/counselingStart";
    }

    /** Docs screens 3/4 - Rank entry, candidate + ITI matrix, Take Admission memo. */
    @GetMapping("/Counseling")
    public String counseling() {
        return "admission/counselingRank";
    }

    // ========== SAME-ORIGIN PROXIES (JS calls these, not the backend directly) ==========

    /**
     * Proxy for the user's backend API:
     * {@code GET /admission/candidate?rank=1&phase=1&year=2025}.
     * Returns the raw backend array (or empty array when the backend 500s /
     * has no row for that rank/phase/year) so the UI can render the
     * "no record" state instead of breaking.
     */
    @GetMapping("/api/candidate")
    @ResponseBody
    public ResponseEntity<Object> candidate(@RequestParam("rank") String rank,
                                            @RequestParam("phase") String phase,
                                            @RequestParam("year") String year) {
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/candidate")
                .queryParam("rank", rank)
                .queryParam("phase", phase)
                .queryParam("year", year)
                .toUriString();
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url,
                    Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            // Backend currently 500s for unknown rank/phase/year combos;
            // surface an empty list so the page shows "no candidate found".
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Proxy: GET /admission/itis/{distCode} - ITI names in the district. */
    @GetMapping({"/api/itis", "/api/itis/{distCode}"})
    @ResponseBody
    public ResponseEntity<Object> itis(
            @RequestParam(value = "distCode", required = false) String distCodeParam,
            @org.springframework.web.bind.annotation.PathVariable(value = "distCode", required = false) String distCodePath) {
        String distCode = distCodePath != null ? distCodePath : distCodeParam;
        if (distCode == null || distCode.isBlank()) {
            return ResponseEntity.badRequest().body(Map.of("error", "distCode is required"));
        }
        String url = backendBaseUrl + "/admission/itis/" + distCode;
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }

    /** Proxy: GET /admission/master-data - {itiNames[], tradeNames[]}. */
    @GetMapping("/api/master-data")
    @ResponseBody
    public ResponseEntity<Object> masterData() {
        try {
            ResponseEntity<Object> resp = rest.getForEntity(
                    backendBaseUrl + "/admission/master-data", Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("itiNames", new Object[0], "tradeNames", new Object[0]));
        }
    }

    /** Proxy: GET /api/reports/student-details?regid= - full student record (fallback rank lookup). */
    @GetMapping("/api/student-details")
    @ResponseBody
    public ResponseEntity<Object> studentDetails(@RequestParam("regid") String regid) {
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/api/reports/student-details")
                .queryParam("regid", regid)
                .toUriString();
        try {
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("registration", null));
        }
    }

    /** Proxy: GET /api/reports/students-not-admitted?year=&phase= - rank->regid fallback list. */
    @GetMapping("/api/students-not-admitted")
    @ResponseBody
    public ResponseEntity<Object> studentsNotAdmitted(@RequestParam("year") String year,
                                                      @RequestParam(value = "phase", required = false) String phase) {
        UriComponentsBuilder b = UriComponentsBuilder
                .fromUriString(backendBaseUrl + "/api/reports/students-not-admitted")
                .queryParam("year", year);
        if (phase != null && !phase.isBlank()) b.queryParam("phase", phase);
        try {
            ResponseEntity<Object> resp = rest.getForEntity(b.toUriString(), Object.class);
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("data", new Object[0], "success", false));
        }
    }

    /** Resolve a counseling candidate from a Rank number (primary + fallback chain). */
    @GetMapping("/api/candidate-resolve")
    @ResponseBody
    public ResponseEntity<Object> candidateResolve(@RequestParam("rank") String rank,
                                                   @RequestParam("phase") String phase,
                                                   @RequestParam("year") String year) {
        String key = rank + "|" + phase + "|" + year;
        if (RESOLVE_CACHE.containsKey(key)) return ResponseEntity.ok(RESOLVE_CACHE.get(key));
        // 1) primary API: GET /admission/candidate?rank=&phase=&year=
        try {
            String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/candidate")
                    .queryParam("rank", rank)
                    .queryParam("phase", phase)
                    .queryParam("year", year)
                    .toUriString();
            ResponseEntity<Object> resp = rest.getForEntity(url, Object.class);
            List<Object> rows = toList(resp.getBody());
            if (!rows.isEmpty()) {
                Map<String, Object> out = new LinkedHashMap<>();
                out.put("source", "candidate-api");
                out.put("rank", rank);
                out.put("phase", phase);
                out.put("year", year);
                out.put("candidate", rows.get(0));
                RESOLVE_CACHE.put(key, out);
                return ResponseEntity.ok(out);
            }
        } catch (Exception ignored) {
        }
        // 2) fallback scan below (parallel student-details merit match, bounded)
        Map<String, Object> fb = fallbackByMerit(rank, phase, year);
        if (fb != null) {
            RESOLVE_CACHE.put(key, fb);
            return ResponseEntity.ok(fb);
        }
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("source", "none");
        out.put("rank", rank);
        out.put("phase", phase);
        out.put("year", year);
        out.put("candidate", null);
        return ResponseEntity.ok(out);
    }

    /** Paged fallback: parallel meritList[].rank+phase match. Bounded by timeout. */
    private Map<String, Object> fallbackByMerit(String rank, String phase, String year) {
        ExecutorService pool = Executors.newFixedThreadPool(10);
        long deadline = System.currentTimeMillis() + RESOLVE_TIMEOUT_MS;
        try {
            int size = 200;
            for (int page = 0; page < 5; page++) {
                String listUrl = UriComponentsBuilder
                        .fromUriString(backendBaseUrl + "/api/reports/students-not-admitted")
                        .queryParam("year", year).queryParam("phase", phase)
                        .queryParam("page", page).queryParam("size", size).toUriString();
                Map<String, Object> listResp = rest.exchange(listUrl,
                        org.springframework.http.HttpMethod.GET, null,
                        new ParameterizedTypeReference<Map<String, Object>>() {
                        }).getBody();
                if (listResp == null) break;
                List<Object> rows = toList(listResp.get("data"));
                if (rows.isEmpty()) break;
                Map<String, Object> hit = scanPageParallel(pool, rows, rank, phase, year, deadline);
                if (hit != null) return hit;
                Number count = (Number) listResp.get("count");
                if (count != null && (page + 1) * size >= count.intValue()) break;
                if (System.currentTimeMillis() > deadline) break;
            }
        } catch (Exception ignored) {
        } finally {
            pool.shutdownNow();
        }
        return null;
    }

    /** Scan one page of not-admitted rows in parallel for a merit match. */
    private Map<String, Object> scanPageParallel(ExecutorService pool, List<Object> rows,
                                                 String rank, String phase, String year,
                                                 long deadline) {
        List<Future<Map<String, Object>>> futures = new ArrayList<>();
        for (Object r : rows) {
            Map<String, Object> row0 = asMap(r);
            if (row0 == null) continue;
            Object regid = row0.get("regid");
            if (regid == null) continue;
            String rid = String.valueOf(regid);
            Callable<Map<String, Object>> task = () -> {
                Map<String, Object> sd = fetchDetails(rid);
                if (sd == null) return null;
                return matchMerit(sd, row0, rank, phase, year);
            };
            futures.add(pool.submit(task));
        }
        for (Future<Map<String, Object>> f : futures) {
            long left = deadline - System.currentTimeMillis();
            if (left <= 0) break;
            try {
                Map<String, Object> hit = f.get(Math.min(left, 4000L), TimeUnit.MILLISECONDS);
                if (hit != null) {
                    for (Future<Map<String, Object>> o : futures) o.cancel(true);
                    return hit;
                }
            } catch (Exception ignored) {
            }
        }
        return null;
    }

    /** Fetch one student-details record by regid (null on error). */
    private Map<String, Object> fetchDetails(String regid) {
        try {
            String sdUrl = UriComponentsBuilder
                    .fromUriString(backendBaseUrl + "/api/reports/student-details")
                    .queryParam("regid", regid).toUriString();
            ResponseEntity<Map<String, Object>> resp = rest.exchange(sdUrl,
                    org.springframework.http.HttpMethod.GET, null,
                    new ParameterizedTypeReference<Map<String, Object>>() {
                    });
            return resp.getBody();
        } catch (Exception ignored) {
            return null;
        }
    }

    /** Build unified candidate when a merit entry matches rank+phase. */
    private Map<String, Object> matchMerit(Map<String, Object> sd, Map<String, Object> row0,
                                           String rank, String phase, String year) {
        for (Object m : toList(sd.get("meritList"))) {
            Map<String, Object> mm = asMap(m);
            if (mm == null) continue;
            boolean ok = String.valueOf(mm.get("rank")).equals(String.valueOf(rank))
                    && String.valueOf(mm.get("phase")).equals(String.valueOf(phase));
            if (!ok) continue;
            return buildCandidate(sd, row0, mm, rank, phase, year);
        }
        return null;
    }

    /** Assemble the unified candidate payload from registration + merit + list row. */
    private Map<String, Object> buildCandidate(Map<String, Object> sd, Map<String, Object> row0,
                                              Map<String, Object> mm,
                                              String rank, String phase, String year) {
        Map<String, Object> reg = asMapOrEmpty(sd.get("registration"));
        Map<String, Object> cand = new LinkedHashMap<>();
        cand.put("regid", reg.getOrDefault("registrationId", row0.getOrDefault("regid", "")));
        cand.put("rank", rank);
        cand.put("phase", phase);
        cand.put("year", year);
        cand.put("name", reg.getOrDefault("name", row0.getOrDefault("name", "")));
        cand.put("fatherName", reg.getOrDefault("fatherName", row0.getOrDefault("fname", "")));
        cand.put("dist_code", mm.getOrDefault("distName", ""));
        cand.put("distName", mm.getOrDefault("distName", ""));
        cand.put("iti_code", mm.getOrDefault("itiName", ""));
        cand.put("qual", mm.getOrDefault("qualification", "all"));
        cand.put("app_status", row0.getOrDefault("appStatus", "A"));
        cand.put("gender", reg.getOrDefault("gender", row0.getOrDefault("gender", "")));
        cand.put("caste", reg.getOrDefault("caste", row0.getOrDefault("caste", "")));
        cand.put("phoneNo", reg.getOrDefault("phoneNo", row0.getOrDefault("phno", "")));
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("source", "student-details");
        out.put("rank", rank);
        out.put("phase", phase);
        out.put("year", year);
        out.put("candidate", cand);
        return out;
    }

    private static List<Object> toList(Object body) {
        if (body instanceof List<?> list) {
            return new ArrayList<>(list);
        }
        if (body instanceof Map<?, ?> map) {
            Object d = map.get("data");
            if (d instanceof List<?> dataList) {
                return new ArrayList<>(dataList);
            }
        }
        return new ArrayList<>();
    }

    /** Type-safe view of a decoded JSON object without unchecked casts. */
    private static Map<String, Object> asMap(Object value) {
        if (!(value instanceof Map<?, ?> map)) {
            return null;
        }
        Map<String, Object> out = new LinkedHashMap<>();
        for (Map.Entry<?, ?> e : map.entrySet()) {
            out.put(String.valueOf(e.getKey()), e.getValue());
        }
        return out;
    }

    private static Map<String, Object> asMapOrEmpty(Object value) {
        Map<String, Object> m = asMap(value);
        return m != null ? m : Map.of();
    }

    /** Proxy open-seats. */
    @GetMapping("/api/open-seats")
    @ResponseBody
    public ResponseEntity<Object> openSeats(@RequestParam("year") String year) {
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/api/reports/open-seats")
                .queryParam("year", year)
                .toUriString();
        try {
            ResponseEntity<Map<String, Object>> resp = rest.exchange(url,
                    org.springframework.http.HttpMethod.GET, null,
                    new ParameterizedTypeReference<Map<String, Object>>() {
                    });
            return ResponseEntity.ok((Object) resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("data", new Object[0], "success", false));
        }
    }
}
