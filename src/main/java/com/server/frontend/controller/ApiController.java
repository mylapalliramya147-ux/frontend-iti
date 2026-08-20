package com.server.frontend.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.*;

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
    @RequestMapping(value = "/**", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
    public ResponseEntity<Map<String, Object>> handleUnknownApi(@PathVariable Map<String, String> pathVars) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("error", "Endpoint not implemented in frontend");
        return ResponseEntity.ok(response);
    }
}