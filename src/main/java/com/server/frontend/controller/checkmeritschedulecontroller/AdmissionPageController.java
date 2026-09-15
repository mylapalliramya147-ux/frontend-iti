package com.server.frontend.controller.checkmeritschedulecontroller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdmissionPageController {

    // Page view endpoint - accessed via /ScheduleEntry link in navbar
    @GetMapping("/ScheduleEntry")
    public String scheduleEntry() {
        return "checkmeritschedule/ScheduleEntry";
    }

    // API endpoint for creating schedule entry
    @PostMapping("/admission-timings/schedule-entry/create")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> createScheduleEntry(
            @RequestBody(required = false) Map<String, Object> request) {
        Map<String, Object> body = new HashMap<>();
        body.put("success", true);
        body.put("message", "Schedule initialized");
        body.put("data", request == null ? new HashMap<String, Object>() : request);
        return ResponseEntity.ok(body);
    }

    // API endpoint for saving timings
    @PutMapping("/admission-timings/timings")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveTimings(
            @RequestBody(required = false) Map<String, Object> request) {
        Map<String, Object> body = new HashMap<>();
        body.put("success", true);
        body.put("message", "Timings saved successfully");
        body.put("data", request == null ? new HashMap<String, Object>() : request);
        return ResponseEntity.ok(body);
    }
}
