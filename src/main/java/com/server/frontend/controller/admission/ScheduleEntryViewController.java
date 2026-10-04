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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

/**
 * Schedule Entry (DISTLOGIN -&gt; Admissions -&gt; Schedule Entry) two-screen flow.
 * Same legacy UI as the Admission Counseling pages (gen.jpg banner,
 * pale-green menu-bar, dark-blue footer).
 * Page: GET /ScheduleEntryView -&gt; admission/scheduleEntryView.jsp (Screen 1
 * selection + Screen 2 details). A dedicated route is used so the existing
 * /ScheduleEntry (checkmeritschedule module) keeps working untouched.
 * API: GET /admission/schedule-entry?qualification=&amp;caste=&amp;phase=&amp;year=
 * -&gt; array of Schedule_Entry_DTO
 * {itiCode, minqul, meritFrom, meritTo, calDate, calTime, distCode, caste,
 * trno, tempPk, phase, year}.
 */
@Controller
@RequestMapping("/ScheduleEntryView")
public class ScheduleEntryViewController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    /** Screen 1 - Qualification + Reservation + Phase + Year selection form. */
    @GetMapping({ "", "/", "/Interface" })
    public String scheduleEntryView() {
        return "admission/scheduleEntryView";
    }

    /**
     * Same-origin proxy so the JSP/JS never hits CORS issues.
     * Forwards to the real backend API and returns the raw array (or an empty
     * array when the backend is unreachable) so the UI can render the
     * empty / error states instead of breaking.
     */
    @GetMapping("/api/schedule-entry")
    @ResponseBody
    public ResponseEntity<Object> scheduleEntry(@RequestParam("qualification") String qualification,
            @RequestParam("caste") String caste,
            @RequestParam("phase") String phase,
            @RequestParam("year") String year) {
        String url = UriComponentsBuilder.fromUriString(backendBaseUrl + "/admission/schedule-entry")
                .queryParam("qualification", qualification)
                .queryParam("caste", caste)
                .queryParam("phase", phase)
                .queryParam("year", year)
                .toUriString();
        try {
            ResponseEntity<Object> resp = rest.exchange(url, HttpMethod.GET, null,
                    new ParameterizedTypeReference<Object>() {
                    });
            return ResponseEntity.status(resp.getStatusCode()).body(resp.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }
}
