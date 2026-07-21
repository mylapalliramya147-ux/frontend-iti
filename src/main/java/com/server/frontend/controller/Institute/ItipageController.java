
package com.server.frontend.controller.Institute;

import com.server.frontend.config.BackendApiConfig;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ItipageController {

    private final BackendApiConfig backendApiConfig;

    public ItipageController(BackendApiConfig backendApiConfig) {
        this.backendApiConfig = backendApiConfig;
    }
    
    @GetMapping("/itiList")
    public String getItiList() {
        return "reports/ItiList";
    }
 

    @GetMapping("/iti-details")
    public String itiDetails(Model model) {

        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullitiUrl()
        );

        return "reports/ItiDetails";
    }
}