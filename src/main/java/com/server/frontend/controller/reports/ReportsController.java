package com.server.frontend.controller.reports;

import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "reports", description = "Reports UI pages and documentation endpoints")
@Controller
@RequestMapping("/reports")
public class ReportsController {

    // ========== STUDENTS NOT ADMITTED (Nodal + Admin) ==========

    @GetMapping("/students_not_admitted")
    public String studentsNotAdmitted() {
        return "reports/students_not_admitted";
    }

    // ========== DASHBOARD ==========
    @GetMapping("/")
    public String reportsDashboard() {
        return "reports/reports";
    }

    // ========== ITI LEVEL REPORTS (Role 4) ==========

    @GetMapping("/getDashboardreport_iti")
    public String getDashboardReportIti() {
        return "reports/getDashboardreport_iti";
    }

    @GetMapping("/Applicant_Report")
    public String applicantReport() {
        return "reports/Applicant_Report";
    }

    @GetMapping("/api_report")
    public String apiReport() {
        return "reports/api_report";
    }

    @GetMapping("/DSC_List_secondphase")
    public String dscListSecondphase() {
        return "reports/DSC_List_secondphase";
    }

    // ========== DISTRICT LEVEL REPORTS (Role 3) ==========

    @GetMapping("/statewidecastewiseabstractinter")
    public String statewideCastewiseAbstractInter() {
        return "reports/statewidecastewiseabstractinter";
    }

    @GetMapping("/Applicant_mobile_addr")
    public String applicantMobileAddr() {
        return "reports/Applicant_mobile_addr";
    }

    @GetMapping("/getDashboardreport_dist")
    public String getDashboardReportDist() {
        return "reports/getDashboardreport_dist";
    }

    @GetMapping("/District_Wise_Application_count")
    public String districtWiseApplicationCount() {
        return "reports/District_Wise_Application_count";
    }

    // ========== NODAL LEVEL REPORTS (Role 10) ==========

    @GetMapping("/Jdgetdasboardreport")
    public String jdGetDashboardReport() {
        return "reports/Jdgetdasboardreport";
    }

    @GetMapping("/PhaseWiseAdmissionReport")
    public String phaseWiseAdmissionReport() {
        return "reports/PhaseWiseAdmissionReport";
    }

    @GetMapping("/AdmissionScheduleITI")
    public String admissionScheduleIti() {
        return "reports/AdmissionScheduleITI";
    }

    @GetMapping("/admissiongenderwise")
    public String admissionGenderWise() {
        return "reports/admissiongenderwise";
    }

    @GetMapping("/Applicant_Report_StateWise")
    public String applicantReportStateWise() {
        return "reports/Applicant_Report_StateWise";
    }

    @GetMapping("/Dist_wise_open_seats")
    public String distWiseOpenSeats() {
        return "reports/Dist_wise_open_seats";
    }

    @GetMapping("/trade_seats_abstract_duration_wise")
    public String tradeSeatsAbstractDurationWise() {
        return "reports/trade_seats_abstract_duration_wise";
    }

    @GetMapping("/govt_pvt_dist_seats_abstract")
    public String govtPvtDistSeatsAbstract() {
        return "reports/govt_pvt_dist_seats_abstract";
    }

    @GetMapping("/std_reg_details_report")
    public String stdRegDetailsReport() {
        return "reports/std_reg_details_report";
    }

    // ========== STATE LEVEL REPORTS (Role 1) ==========

    @GetMapping("/district-iti-wise-year-view")
    public String districtItiWiseYear() {
        return "reports/district-iti-wise-year-view";
    }

    @GetMapping("/itiprofile")
    public String itiProfile() {
        return "reports/itiprofile";
    }

    @GetMapping({"/trade_display1", "/trade-display1"})
    public String tradeDisplay1() {
        // trade_display1.jsp does not exist; the actual ITI Profile page is /reports/itiprofile
        return "redirect:/reports/itiprofile";
    }

    @GetMapping("/itilist")
    public String itiList() {
        return "reports/itilist";
    }

    @GetMapping({"/trade_display2", "/trade-display2"})
    public String tradeDisplay2() {
        return "reports/trade_display2";
    }

    @GetMapping("/district_schedule")
    public String districtSchedule() {
        return "reports/district_schedule";
    }

    @GetMapping("/Shift_Unit_Report")
    public String shiftUnitReport() {
        return "reports/Shift_Unit_Report";
    }

    @GetMapping("/Govt_Pvt_admitted_seats_abstract")
    public String govtPvtAdmittedSeatsAbstract() {
        return "reports/Govt_Pvt_admitted_seats_abstract";
    }

    @GetMapping("/RolesReport")
    public String rolesReport() {
        return "reports/RolesReport";
    }

    @GetMapping("/Seats_Abstract_Strength_filled_Interface")
    public String seatsAbstractStrengthFilledInterface() {
        return "reports/Seats_Abstract_Strength_filled_Interface";
    }

    @GetMapping("/tradewise_admission_report")
    public String tradewiseAdmissionReport() {
        return "reports/tradewise_admission_report";
    }

    @GetMapping("/tradewise_vacant_position")
    public String tradewiseVacantPosition() {
        return "reports/tradewise_vacant_position";
    }

    // ========== PUBLIC PAGES ==========

    @GetMapping("/aboutstrive")
    public String aboutStrive() {
        return "reports/aboutstrive";
    }

    @GetMapping("/disclosuremanagement")
    public String disclosureManagement() {
        return "reports/disclosuremanagement";
    }

    // ========== UTILITY ==========

    @GetMapping("/swagger")
    public String apiDocs() {
        return "reports/swagger";
    }
}
