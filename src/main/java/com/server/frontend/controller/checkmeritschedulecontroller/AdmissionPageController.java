package com.server.frontend.controller.checkmeritschedulecontroller;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
@Controller
public class AdmissionPageController {

    // Page view endpoint - accessed via /ScheduleEntry link in navbar
    @GetMapping("/ScheduleEntry")
    public String scheduleEntry() {
        return "checkmeritschedule/ScheduleEntry";
    }

    // API endpoint for creating schedule entry
    @PostMapping("/admission-timings/schedule-entry/create")
    public ResponseEntity<?> createScheduleEntry(@RequestBody ScheduleEntryRequest request) {
        // Placeholder for schedule entry creation logic
        return ResponseEntity.ok(new ApiResponse(true, "Schedule initialized"));
    }

    // API endpoint for saving timings
    @PutMapping("/admission-timings/timings")
    public ResponseEntity<?> saveTimings(@RequestBody TimingRequest request) {
        // Placeholder for saving timings logic
        return ResponseEntity.ok(new ApiResponse(true, "Timings saved successfully"));
    }

    // Inner classes for request/response DTOs
    static class ScheduleEntryRequest {
        private String reservation;
        private String minqul;

        public String getReservation() { return reservation; }
        public void setReservation(String reservation) { this.reservation = reservation; }
        public String getMinqul() { return minqul; }
        public void setMinqul(String minqul) { this.minqul = minqul; }
    }

    static class TimingRequest {
        private String reservation;
        private String minqul;
        private String merit_from;
        private String merit_to;
        private String cal_date;
        private String cal_time;

        public String getReservation() { return reservation; }
        public void setReservation(String reservation) { this.reservation = reservation; }
        public String getMinqul() { return minqul; }
        public void setMinqul(String minqul) { this.minqul = minqul; }
        public String getMerit_from() { return merit_from; }
        public void setMerit_from(String merit_from) { this.merit_from = merit_from; }
        public String getMerit_to() { return merit_to; }
        public void setMerit_to(String merit_to) { this.merit_to = merit_to; }
        public String getCal_date() { return cal_date; }
        public void setCal_date(String cal_date) { this.cal_date = cal_date; }
        public String getCal_time() { return cal_time; }
        public void setCal_time(String cal_time) { this.cal_time = cal_time; }
    }

    static class ApiResponse {
        private boolean success;
        private String message;
        private Object data;
        private String error;

        public ApiResponse(boolean success, String message) {
            this.success = success;
            this.message = message;
        }

        public ApiResponse(boolean success, Object data) {
            this.success = success;
            this.data = data;
        }

        public boolean isSuccess() { return success; }
        public void setSuccess(boolean success) { this.success = success; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
        public Object getData() { return data; }
        public void setData(Object data) { this.data = data; }
        public String getError() { return error; }
        public void setError(String error) { this.error = error; }
    }
}