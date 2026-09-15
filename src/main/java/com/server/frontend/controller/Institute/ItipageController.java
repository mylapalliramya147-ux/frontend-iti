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
<<<<<<< HEAD
        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("iti")
        );
=======
        model.addAttribute("itiApiUrl", backendApiConfig.getFullUrl("reports"));
>>>>>>> 372fda391e99b28f6728fb85f5459c1c3632db7c
        return "Institute/ItiList";
    }

    @GetMapping("/iti-details")
    public String itiDetails(Model model) {
<<<<<<< HEAD

        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("iti")
        );

=======
        model.addAttribute("itiApiUrl", backendApiConfig.getFullUrl("reports"));
>>>>>>> 372fda391e99b28f6728fb85f5459c1c3632db7c
        return "Institute/ItiDetails";
    }

    @GetMapping("/iti-create")
    public String itiCreate(Model model) {
<<<<<<< HEAD

        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("iti")
        );

        model.addAttribute(
                "districtApiUrl",
                backendApiConfig.getFullUrl("districts")
        );

        model.addAttribute(
                "designationApiUrl",
                backendApiConfig.getFullUrl("designations")
        );

        model.addAttribute(
                "itiRegistrationApiUrl",
                backendApiConfig.getFullUrl("iti-create")
        );

=======
        model.addAttribute("itiApiUrl", backendApiConfig.getFullUrl("reports"));
        model.addAttribute("districtApiUrl", backendApiConfig.getFullUrl("districts"));
        model.addAttribute("designationApiUrl", backendApiConfig.getFullUrl("designations"));
>>>>>>> 372fda391e99b28f6728fb85f5459c1c3632db7c
        return "Institute/ItiCreate";
    }

    @GetMapping("/iti-trade-selection")
    public String itiTradeSelection(Model model) {
<<<<<<< HEAD
        model.addAttribute(
                "itiApiUrl",
                backendApiConfig.getFullUrl("iti")
        );
        model.addAttribute(
                "backendApiBaseUrl",
                backendApiConfig.getBaseUrl("iti")
        );
        model.addAttribute(
                "itiTradesApiUrl",
                backendApiConfig.getFullUrl("iti-trades")
        );
=======
        model.addAttribute("itiApiUrl", backendApiConfig.getFullUrl("reports"));
        model.addAttribute("backendApiBaseUrl", backendApiConfig.getBaseUrl("reports"));
>>>>>>> 372fda391e99b28f6728fb85f5459c1c3632db7c
        return "Institute/ItiTradeSelection";
    }

    @GetMapping("/shift-unit-permitted")
    public String shiftUnitPermitted(Model model) {
<<<<<<< HEAD
        model.addAttribute(
                "shiftUnitApiUrl",
                backendApiConfig.getFullUrl("shift-unit")
        );
=======
        model.addAttribute("backendApiBaseUrl", backendApiConfig.getBaseUrl("reports"));
>>>>>>> 372fda391e99b28f6728fb85f5459c1c3632db7c
        return "Institute/ShiftUnitPermitted";
    }
}
