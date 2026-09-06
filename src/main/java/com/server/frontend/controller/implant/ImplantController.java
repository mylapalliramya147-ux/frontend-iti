package com.server.frontend.controller.implant;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "implant", description = "In-Plant Training UI pages")
@Controller
@RequestMapping("/implant")
public class ImplantController {

    // ========== IN-PLANT DISTRICT REPORT (District only) ==========
    @GetMapping("/distreport")
    public String implantDistReport(HttpServletRequest request) {
        if (!isDistrictRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/implant_dist_report";
    }

    // ========== IN-PLANT TRAINING ENTRY (ITI only) ==========
    @GetMapping("/entry")
    public String implantEntry(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/implant_entry";
    }

    // ========== IN-PLANT REPORT (ITI only) ==========
    @GetMapping("/report")
    public String implantReport(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/implant_report";
    }

    /** District users have roleId == 3; requires a valid session. */
    private boolean isDistrictRole(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = request.getSession().getAttribute("roleId");
        return roleId != null && "3".equals(String.valueOf(roleId));
    }

    /** ITI users have roleId == 4; requires a valid session. */
    private boolean isItiRole(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = request.getSession().getAttribute("roleId");
        return roleId != null && "4".equals(String.valueOf(roleId));
    }
}
