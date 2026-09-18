package com.server.frontend.controller.labs;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "labs", description = "Labs UI pages")
@Controller
@RequestMapping("/labs")
public class LabsController {

    // ========== LAB ENTRY (ITI only) ==========
    @GetMapping("/entry")
    public String labEntry(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "labs/labs_entry";
    }

    // ========== LAB REPORT (ITI only) ==========
    @GetMapping("/report")
    public String labReport(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "labs/labs_report";
    }

    /** ITI users have roleId == 4; requires a valid session. */
    private boolean isItiRole(HttpServletRequest request) {
        HttpSession itiSession = request.getSession(false);
        if (itiSession == null || itiSession.getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = itiSession.getAttribute("roleId");
        return roleId != null && "4".equals(String.valueOf(roleId));
    }
}
