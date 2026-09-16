package com.server.frontend.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {

    /**
     * Get application status including current phase and other configuration
     */
    @PostMapping("/status")
    public ResponseEntity<Map<String, Object>> getStatus() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("phase", 1); // Default phase - adjust as needed
        return ResponseEntity.ok(response);
    }

    /**
     * Get caste/category list for admission schedules
     */
    @GetMapping("/dsc/caste-list")
    public ResponseEntity<Map<String, Object>> getCasteList() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        
        List<Map<String, String>> casteList = new ArrayList<>();
        // Default caste categories - populate from database as needed
        String[] categories = {" OC", " BC-A", " BC-B", " BC-C", " BC-D", " BC-E", " SC", " ST", " EWS", " Minority"};
        
        for (String category : categories) {
            Map<String, String> item = new HashMap<>();
            item.put("caste_code", category);
            item.put("caste_name", category + " Category");
            casteList.add(item);
        }
        
        response.put("data", casteList);
        return ResponseEntity.ok(response);
    }

    /**
     * Handle API error fallback - returns success response for unimplemented endpoints
     */
    @RequestMapping(value = "/**")
    public ResponseEntity<Map<String, Object>> handleUnknownApi() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", "Endpoint not implemented in frontend");
        return ResponseEntity.status(404).body(response);
    }
}