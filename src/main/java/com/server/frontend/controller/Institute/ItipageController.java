
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
    public String getItiList(Model model) {
        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("reports")
        );
        return "Institute/ItiList";
    }
  

    @GetMapping("/iti-details")
    public String itiDetails(Model model) {

        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("reports")
        );

        return "Institute/ItiDetails";
    }
    @GetMapping("/iti-create")
    public String itiCreate(Model model) {

        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("reports")
        );

        model.addAttribute(
                "districtApiUrl",
                backendApiConfig.getFullUrl("districts")
        );

        model.addAttribute(
                "designationApiUrl",
                backendApiConfig.getFullUrl("designations")
        );

        return "Institute/ItiCreate";
    }

    @GetMapping("/iti-trade-selection")
    public String itiTradeSelection(Model model) {
        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("reports")
        );
        model.addAttribute(
                "backendApiBaseUrl",
                backendApiConfig.getBaseUrl("reports")
        );
        return "Institute/ItiTradeSelection";
    }
}
