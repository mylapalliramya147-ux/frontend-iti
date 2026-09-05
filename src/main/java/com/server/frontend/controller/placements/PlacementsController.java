package com.server.frontend.controller.placements;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import io.swagger.v3.oas.annotations.tags.Tag;

@Tag(name = "placements", description = "Placements UI pages")
@Controller
@RequestMapping("/placements")
public class PlacementsController {

    // ========== PLACEMENTS SCHEDULEWISE (Nodal/State) ==========
    @GetMapping("/schedulewise")
    public String placementsSchedulewise(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_schedulewise";
    }

    // ========== PLACEMENTS SCHEDULE DATEWISE (Nodal/State) ==========
    @GetMapping("/scheduledatewise")
    public String placementsScheduleDatewise(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_schedule_datewise";
    }

    // ========== PLACEMENTS STATE REPORT (Nodal/State) ==========
    @GetMapping("/statereport")
    public String placementsStateReport(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_state_report";
    }

    // ========== PLACEMENTS YEARWISE REPORT (Nodal/State) ==========
    @GetMapping("/yearwisereport")
    public String placementsYearwiseReport(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_yearwise_report";
    }

    // ========== STATE SKILL DEVELOPMENT PLAN REPORT (Nodal/State) ==========
    @GetMapping("/ssdpreport")
    public String placementsSsdpReport(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return "redirect:/placements?error=session";
        }
        return "placements/placements_ssdp_report";
    }

    // ========== PLACEMENT DATA DETAILS REPORT (Nodal/State) ==========
    @GetMapping("/datadetails")
    public String placementsDataDetails(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
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
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = request.getSession().getAttribute("roleId");
        return roleId != null && "3".equals(String.valueOf(roleId));
    }
}