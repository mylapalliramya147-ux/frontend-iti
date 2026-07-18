package com.server.frontend.controller.Institute;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class ItipageController {
    @GetMapping("itiList")
    public String getItiList() {
        return "reports/ItiList";
    }
}
