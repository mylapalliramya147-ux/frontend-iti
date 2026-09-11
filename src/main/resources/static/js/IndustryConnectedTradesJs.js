/**
 * IndustryConnectedTradesJs.js
 * Report page JavaScript - Industry Connected Trades Report
 *
 * Clones the AJAX / table-rendering pattern used by the other IN-PLANT
 * report pages (inplant_nodal_report, industry_master_report, etc.).
 *
 * Data API : GET /api/industry-connected-trades
 * Excel    : GET /api/industry-connected-trades/download-excel
 */

/*
 * Common utility function used across every IN-PLANT report page.
 * Escapes HTML special characters to prevent XSS when injecting
 * server-side values into the DOM.
 */
function esc(v) {
    if (v === null || v === undefined) return '';
    return $('<div/>').text(String(v)).html();
}

$(document).ready(function () {

    /*
     * Populate the welcome banner with the logged-in user's info.
     * (username / insCode are injected inline by the JSP.)
     */
    document.getElementById("userinfo").innerHTML =
        "<i class='fas fa-user'></i> " + username +
        " | " +
        "<i class='fas fa-id-badge'></i> " + insCode;

    /* Auto-load the report on page load. */
    loadData();

});


/**
 * Fetch Industry Connected Trades data from the backend API.
 * GET /api/industry-connected-trades
 *
 * Shows the spinner while loading, hides it on completion, and
 * delegates rendering to renderTable().
 */
function loadData() {

    $("#spinnerdiv").show();

    $.ajax({
        type: 'get',
        url: baseUrl + 'api/industry-connected-trades',
        cache: false,
        timeout: 600000,
        success: function (rows) {
            $("#spinnerdiv").hide();
            renderTable(rows || []);
        },
        error: function () {
            $("#spinnerdiv").hide();
            $("#tablebody").append(
                '<tr><td colspan="7" style="text-align:center;color:red;padding:15px;">' +
                'Error loading report.' +
                '</td></tr>'
            );
        }
    });

}


/**
 * Render the data rows into the report table.
 *
 * @param {Array} rows - Array of JSON objects with fields:
 *   district, itiCode, itiName, trade, totalTrainees, industryName
 */
function renderTable(rows) {

    $("#tablebody").empty();

    if (!rows.length) {
        $("#tablebody").append(
            '<tr><td colspan="7" style="text-align:center;padding:15px;font-weight:bold;">' +
            'NO DATA FOUND.' +
            '</td></tr>'
        );
        return;
    }

    rows.forEach(function (row, index) {

        /*
         * Backend DTO returns the trade as "tradeName" (older builds
         * used "trade") - read tradeName first with a safe fallback.
         * Serial number comes from the API's "sno" field when present.
         */
        var trade = (row.tradeName !== undefined && row.tradeName !== null)
                ? row.tradeName
                : row.trade;

        var sno = (row.sno !== undefined && row.sno !== null)
                ? row.sno
                : (index + 1);

        var html =
            '<tr>' +

            '<td>' + esc(sno) + '</td>' +
            '<td>' + esc(row.district) + '</td>' +
            '<td>' + esc(row.itiCode) + '</td>' +
            '<td>' + esc(row.itiName) + '</td>' +
            '<td>' + esc(trade) + '</td>' +
            '<td>' + esc(row.totalTrainees) + '</td>' +
            '<td>' + esc(row.industryName) + '</td>' +

            '</tr>';

        $("#tablebody").append(html);

    });

}


/**
 * Download Excel report.
 *
 * Calls the backend endpoint
 * GET /api/industry-connected-trades/download-excel
 * and lets the browser handle the Excel file returned by the server.
 */
function fnExcelReport() {

    window.location.href = baseUrl + 'api/industry-connected-trades/download-excel';

    return false;

}
