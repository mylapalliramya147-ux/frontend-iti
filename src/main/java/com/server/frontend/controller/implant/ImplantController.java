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

    // ========== ITI - INDUSTRY MAPPING ENTRY (ITI only) ==========
    @GetMapping("/mapping")
    public String implantMapping(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/implant_mapping";
    }

    // ========== EDIT INDUSTRY MAPPING (ITI only) ==========
    @GetMapping("/mapping/edit")
    public String implantMappingEdit(HttpServletRequest request) {
        if (!isItiRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/implant_mapping_edit";
    }

    // ========== INDUSTRY MASTER PREVIEW (Nodal only) ==========
    @GetMapping("/industrymaster")
    public String industryMasterPreview(HttpServletRequest request) {
        if (!isNodalRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/industry_master_preview";
    }

    // ========== EDIT INDUSTRY MASTER (Nodal only) ==========
    @GetMapping("/industrymaster/edit")
    public String industryMasterEdit(HttpServletRequest request) {
        if (!isNodalRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/industry_master_edit";
    }

    // ========== INDUSTRY MASTER ENTRY (Nodal only) ==========
    @GetMapping("/industrymaster/entry")
    public String industryMasterEntry(HttpServletRequest request) {
        if (!isNodalRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/industry_master_entry";
    }

    // ========== ITI - INDUSTRY MAPPING ENTRY (Nodal only) ==========
    @GetMapping("/mapping-nodal")
    public String industryMappingNodal(HttpServletRequest request) {
        if (!isNodalRole(request)) {
            return "redirect:/placements?error=session";
        }
        return "implant/industry_mapping_nodal";
    }

    /** Nodal users have roleId == 10; requires a valid session. */
    private boolean isNodalRole(HttpServletRequest request) {
        if (request.getSession(false) == null
                || request.getSession().getAttribute("sessionUser") == null) {
            return false;
        }
        Object roleId = request.getSession().getAttribute("roleId");
        return roleId != null && "10".equals(String.valueOf(roleId));
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
