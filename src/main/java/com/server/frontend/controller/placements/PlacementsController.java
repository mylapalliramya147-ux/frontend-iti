package com.server.frontend.controller.placements;

import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "placements", description = "Placements UI pages")
@Controller
@RequestMapping("/placements")
public class PlacementsController {

    // ========== PLACEMENTS SCHEDULEWISE (Nodal/State) ==========
    @GetMapping("/schedulewise")
    public String placementsSchedulewise(HttpServletRequest request) {
        HttpSession scheduleSession = request.getSession(false);
        if (scheduleSession == null || scheduleSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_schedulewise";
    }

    // ========== PLACEMENTS SCHEDULE DATEWISE (Nodal/State) ==========
    @GetMapping("/scheduledatewise")
    public String placementsScheduleDatewise(HttpServletRequest request) {
        HttpSession datewiseSession = request.getSession(false);
        if (datewiseSession == null || datewiseSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_schedule_datewise";
    }

    // ========== PLACEMENTS STATE REPORT (Nodal/State) ==========
    @GetMapping("/statereport")
    public String placementsStateReport(HttpServletRequest request) {
        HttpSession stateSession = request.getSession(false);
        if (stateSession == null || stateSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_state_report";
    }

    // ========== PLACEMENTS YEARWISE REPORT (Nodal/State) ==========
    @GetMapping("/yearwisereport")
    public String placementsYearwiseReport(HttpServletRequest request) {
        HttpSession yearwiseSession = request.getSession(false);
        if (yearwiseSession == null || yearwiseSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_yearwise_report";
    }

    // ========== STATE SKILL DEVELOPMENT PLAN REPORT (Nodal/State) ==========
    @GetMapping("/ssdpreport")
    public String placementsSsdpReport(HttpServletRequest request) {
        HttpSession ssdpSession = request.getSession(false);
        if (ssdpSession == null || ssdpSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_ssdp_report";
    }

    // ========== PLACEMENT DATA DETAILS REPORT (Nodal/State) ==========
    @GetMapping("/datadetails")
    public String placementsDataDetails(HttpServletRequest request) {
        HttpSession detailsSession = request.getSession(false);
        if (detailsSession == null || detailsSession.getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_data_details";
    }

    // ========== PLACEMENT SCHEDULE ENTRY (District only) ==========
    @GetMapping("/scheduleentry")
    public String placementsScheduleEntry(HttpServletRequest request) {
        if (!isDistrictRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_schedule_entry";
    }

    // ========== PLACEMENT DIST REPORT (District only) ==========
    @GetMapping("/distreport")
    public String placementsDistReport(HttpServletRequest request) {
        if (!isDistrictRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_dist_report";
    }

    /** District users have roleId == 3; requires a valid session. */
    private boolean isDistrictRole(HttpServletRequest request) {
        HttpSession roleSession = request.getSession(false);
        if (roleSession == null || roleSession.getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = roleSession.getAttribute("roleId");
        return roleId != null && "3".equals(String.valueOf(roleId));
    }

    // ========== PLACEMENTS ENTRY (ITI only) ==========
    @GetMapping("/placemententry")
    public String placementsEntry(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_entry";
    }

    // ========== PLACEMENTS ITI REPORT (ITI only) ==========
    @GetMapping("/itireport")
    public String placementsItiReport(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_iti_report";
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