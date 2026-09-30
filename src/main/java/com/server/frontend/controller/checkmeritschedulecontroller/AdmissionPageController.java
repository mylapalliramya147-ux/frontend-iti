package com.server.frontend.controller.checkmeritschedulecontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdmissionPageController {

    // Page view endpoint - accessed via /ScheduleEntry link in navbar
    @GetMapping("/ScheduleEntry")
    public String scheduleEntry() {
        return "checkmeritschedule/ScheduleEntry";
    }

    // The schedule-entry and timings APIs are NOT proxied here. They are served by the
    // Backend (AdmissionTimingController on :5050), and the pages reach it directly through
    // window.API_BASE_URL. The two stubs that used to live here shadowed nothing real —
    // they had no callers — but echoing back success without persisting anything was a trap.
}
