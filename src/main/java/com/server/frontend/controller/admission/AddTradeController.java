package com.server.frontend.controller.admission;

import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/** Add Trade (DISTLOGIN - Admissions - Add Trade). Same legacy UI as SeatMatrix. */
@Controller
@RequestMapping("/AddTrade")
public class AddTradeController {

    private final RestTemplate rest = new RestTemplate();

    @Value("${backend.api.base-url}")
    private String backendBaseUrl;

    @GetMapping({ "", "/", "/Interface" })
    public String addTrade() {
        return "admission/addTrade";
    }

    @GetMapping("/api/district/{distCode}/itis")
    @ResponseBody
    public ResponseEntity<Object> itis(@PathVariable("distCode") String d) {
        return proxy(backendBaseUrl + "/admission/district/" + d.trim() + "/itis");
    }

    @GetMapping("/api/itis/{distCode}")
    @ResponseBody
    public ResponseEntity<Object> names(@PathVariable("distCode") String d) {
        return proxy(backendBaseUrl + "/admission/itis/" + d.trim());
    }

    @GetMapping("/api/iti/{itiCode}/trades")
    @ResponseBody
    public ResponseEntity<Object> trades(@PathVariable("itiCode") String c) {
        return proxy(backendBaseUrl + "/admission/iti/" + c.trim() + "/trades");
    }

    @GetMapping("/api/iti/{itiCode}/seat-details")
    @ResponseBody
    public ResponseEntity<Object> seats(@PathVariable("itiCode") String c) {
        return proxy(backendBaseUrl + "/admission/iti/" + c.trim() + "/seat-details");
    }

    @GetMapping("/api/trade/{tradeShort}")
    @ResponseBody
    public ResponseEntity<Object> trade(@PathVariable("tradeShort") String t) {
        return proxy(backendBaseUrl + "/admission/trade/" + t.trim());
    }

    @GetMapping("/api/trades")
    @ResponseBody
    public ResponseEntity<Object> allTrades() {
        return proxy(backendBaseUrl + "/api/trades");
    }

    @PostMapping("/api/iti/{itiCode}/trades")
    @ResponseBody
    public ResponseEntity<Object> add(@PathVariable("itiCode") String c,
            @RequestBody(required = false) Map<String, Object> b) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(Map.of("success", false,
                "error", "Add Trade unavailable: no backend write endpoint for ITI " + c));
    }

    @PutMapping("/api/iti/{itiCode}/approve-all")
    @ResponseBody
    public ResponseEntity<Object> approve(@PathVariable("itiCode") String c) {
        return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).body(Map.of("success", false,
                "error", "Approve All unavailable: no backend approval endpoint for ITI " + c));
    }

    private ResponseEntity<Object> proxy(String url) {
        try {
            ResponseEntity<Object> r = rest.getForEntity(url, Object.class);
            return ResponseEntity.status(r.getStatusCode()).body(r.getBody());
        } catch (Exception e) {
            return ResponseEntity.ok(new Object[0]);
        }
    }
}
