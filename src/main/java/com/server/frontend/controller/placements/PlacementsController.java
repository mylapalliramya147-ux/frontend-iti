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
}