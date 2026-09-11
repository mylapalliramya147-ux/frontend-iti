<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set
    var="backendBaseUrl"
    value="${not empty backendUrl ? backendUrl : 'http://localhost:5050'}"
    scope="page"
/>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <title>IN-PLANT Datewise Report</title>

    <!-- Bootstrap -->
    <link
        href="${pageContext.request.contextPath}/css/bootstrap.min.css"
        rel="stylesheet"
    >

    <!-- Font Awesome -->
    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/fontawesome.all.min.css"
    >

    <!-- jQuery -->
    <script
        src="${pageContext.request.contextPath}/js/jquery.min.js">
    </script>

    <!-- Bootstrap JS -->
    <script
        src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js">
    </script>

    <!-- XLSX -->
    <script
        src="${pageContext.request.contextPath}/js/xlsx.full.min.js">
    </script>


    <script>

        var username = '<c:out value="${sessionScope.username}" default="" />';
        var insCode  = '<c:out value="${sessionScope.insCode}" default="" />';
        var baseUrl  = '${backendBaseUrl}/';


        $(document).ready(function () {

            document.getElementById("userinfo").innerHTML =
                "<i class='fas fa-user'></i> " +
                username +
                " | " +
                "<i class='fas fa-id-badge'></i> " +
                insCode;

        });

    </script>


    <style>

        #reporttable th,
        #reporttable td {
            vertical-align: middle;
        }

        #reporttable thead th,
        #reporttable thead td {
            position: sticky;
            top: 0;
            background-color: black;
            color: white;
            z-index: 2;
        }

        #reporttable {
            width: 100%;
        }

    </style>

</head>


<body>

    <!-- Banner -->
    <img
        alt="banner"
        src="${pageContext.request.contextPath}/images/gen.jpg"
        style="
            border: 1px solid black;
            width: 100%;
            border-radius: 2px;
        "
    >


    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">

        <div class="container-fluid">

            <a
                class="navbar-brand"
                href="${pageContext.request.contextPath}/placements/loginSuccess"
            >
                <i class="fas fa-home"></i>
                Home
            </a>


            <div class="text-white fw-bold">
                Welcome :
                <span id="userinfo"></span>
            </div>


            <div>

                <a
                    href="${pageContext.request.contextPath}/logout"
                    class="btn btn-danger"
                >
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>

            </div>

        </div>

    </nav>


    <br>


    <!-- Date Selection -->
    <div
        class="container border p-2 mt-2 shadow-lg"
        id="formdiv"
    >

        <div
            class="text-center"
            style="text-decoration: underline; color: fuchsia;"
        >
            Inplant Datewise Data
        </div>


        <div class="row">

            <!-- From Date -->
            <div class="col-md-3">

                <label for="from_date">
                    From Date
                </label>

                <input
                    type="date"
                    id="from_date"
                    class="form-control"
                >

            </div>


            <!-- To Date -->
            <div class="col-md-3">

                <label for="to_date">
                    To Date
                </label>

                <input
                    type="date"
                    id="to_date"
                    class="form-control"
                >

            </div>


            <!-- Get Data -->
            <div class="col-md-3">

                <button
                    type="button"
                    class="btn btn-sm btn-success mt-4"
                    onclick="return getData();"
                >
                    GET DATA
                </button>

            </div>

        </div>

    </div>


    <!-- Report Container -->
    <div
        class="container-fluid border p-2 mt-2 shadow-lg"
    >

        <div
            class="text-center"
            style="text-decoration: underline; color: fuchsia;"
        >
            IN-PLANT DATEWISE REPORT
        </div>


        <!-- Loading Spinner -->
        <div
            class="text-center"
            id="spinnerdiv"
            style="display: none;"
        >

            <span>
                Data is Loading...
            </span>

            <div
                class="spinner-border"
                role="status"
            >
            </div>

        </div>


        <!-- Empty Data Message -->
        <div
            class="text-center"
            id="emptydatamsg"
            style="
                display: none;
                color: red;
                font-weight: bold;
            "
        >
            --- NO DATA FOUND FOR SHOWING ---
        </div>


        <!-- Filters -->
        <div
            class="row mb-1"
            id="filterrow"
            style="display: none;"
        >

            <!-- District -->
            <div class="col-2">

                <label for="distcode">
                    District
                </label>

                <select
                    id="distcode"
                    class="form-control"
                    onchange="filterData();"
                >
                </select>

            </div>


            <!-- ITI -->
            <div class="col-3">

                <label for="iticode">
                    ITI
                </label>

                <select
                    id="iticode"
                    class="form-control"
                    onchange="filterData();"
                >
                </select>

            </div>


            <!-- Industry -->
            <div class="col-3">

                <label for="industryId">
                    INDUSTRY
                </label>

                <select
                    id="industryId"
                    class="form-control"
                    onchange="filterData();"
                >
                </select>

            </div>


            <div class="col-2"></div>


            <!-- Excel -->
            <div class="col-2">

                <button
                    type="button"
                    onclick="return fnExcelReport();"
                    class="btn btn-info btn-sm mt-4"
                >
                    DOWNLOAD EXCEL
                </button>

            </div>

        </div>


        <!-- Report Table -->
        <div class="table-responsive">

            <table
                class="table table-bordered"
                id="reporttable"
                style="display: none;"
            >

                <thead>

                    <!-- First Header Row -->
                    <tr>

                        <td
                            rowspan="2"
                            style="background-color: black; color: white;"
                        >
                            S.NO
                        </td>


                        <td
                            rowspan="2"
                            style="background-color: black; color: white;"
                        >
                            DISTRICT
                        </td>


                        <td
                            rowspan="2"
                            style="background-color: black; color: white;"
                        >
                            ITI
                        </td>


                        <td
                            colspan="14"
                            align="center"
                            style="background-color: black; color: white;"
                        >
                            IN-PLANT RELATED INFORMATION
                        </td>

                    </tr>


                    <!-- Second Header Row -->
                    <tr>

                        <td style="background-color: black; color: white;">
                            IN-PLANT ID
                        </td>

                        <td style="background-color: black; color: white;">
                            INDUSTRY NAME
                        </td>

                        <td style="background-color: black; color: white;">
                            FACULTY NAME
                        </td>

                        <td style="background-color: black; color: white;">
                            IN-PLANT TRADE
                        </td>

                        <td style="background-color: black; color: white;">
                            INDUSTRY ADDRESS
                        </td>

                        <td style="background-color: black; color: white;">
                            HR CONTACT NUMBER
                        </td>

                        <td style="background-color: black; color: white;">
                            FROM DATE(DD-MM-YYYY)
                        </td>

                        <td style="background-color: black; color: white;">
                            TO DATE(DD-MM-YYYY)
                        </td>

                        <td style="background-color: black; color: white;">
                            NO OF DAYS
                        </td>

                        <td style="background-color: black; color: white;">
                            NO OF STUDENT U.T
                        </td>

                        <td style="background-color: black; color: white;">
                            IN-PLANT STATE
                        </td>

                        <td style="background-color: black; color: white;">
                            IN-PLANT DISTRICT
                        </td>

                        <td style="background-color: black; color: white;">
                            LOCATION
                        </td>

                        <td style="background-color: black; color: white;">
                            DESCRIPTION
                        </td>

                    </tr>

                </thead>


                <tbody id="tablebody">
                </tbody>

            </table>

        </div>

    </div>


    <script>

        var allRows = [];
        var filteredRows = [];


        /*
         * Escape HTML values before inserting
         * them into the table.
         */
        function esc(value) {

            if (value === null || value === undefined) {
                return '';
            }

            return $('<div/>')
                .text(String(value))
                .html();

        }


        /*
         * Load report data.
         */
        function getData() {

            var fromDate = $("#from_date").val();
            var toDate   = $("#to_date").val();


            // Validate dates
            if (!fromDate || !toDate) {

                alert(
                    "Please select both From and To dates."
                );

                return false;

            }


            // Validate date range
            if (toDate < fromDate) {

                alert(
                    "To Date must be >= From Date."
                );

                return false;

            }


            // Show spinner
            $("#spinnerdiv").show();


            // Hide previous results
            $("#reporttable").hide();
            $("#filterrow").hide();
            $("#emptydatamsg").hide();


            console.log(
                "Loading datewise report:",
                fromDate,
                "to",
                toDate
            );


            $.ajax({

                type: "GET",

                url:
                    baseUrl +
                    "api/implant/datewise-report" +
                    "?fromDate=" +
                    encodeURIComponent(fromDate) +
                    "&toDate=" +
                    encodeURIComponent(toDate),

                cache: false,

                timeout: 600000,


                success: function (rows) {

                    console.log(
                        "Loaded rows:",
                        rows ? rows.length : 0
                    );


                    allRows = rows || [];


                    // Hide spinner
                    $("#spinnerdiv").hide();


                    // No data
                    if (!allRows.length) {

                        $("#emptydatamsg").show();

                        return;

                    }


                    // Build dropdown filters
                    buildFilters();


                    // Apply filters
                    filterData();


                    // Show report
                    $("#reporttable").show();
                    $("#filterrow").show();

                },


                error: function (xhr) {

                    $("#spinnerdiv").hide();


                    var msg = "Failed to load data";


                    try {

                        if (
                            xhr.responseJSON &&
                            xhr.responseJSON.message
                        ) {

                            msg = xhr.responseJSON.message;

                        }

                    } catch (e) {

                        console.error(
                            "Unable to parse error response.",
                            e
                        );

                    }


                    console.error(
                        "AJAX error:",
                        xhr.status,
                        msg
                    );


                    alert(
                        "Error " +
                        xhr.status +
                        ": " +
                        msg
                    );

                }

            });


            return false;

        }


        /*
         * Build dropdown filters from
         * the returned data.
         */
        function buildFilters() {

            var dists = {};
            var itis = {};
            var industries = {};


            allRows.forEach(function (row) {

                if (row.districtName) {

                    dists[row.districtName] = true;

                }


                if (row.itiName) {

                    itis[row.itiName] = true;

                }


                if (row.industryName) {

                    industries[row.industryName] = true;

                }

            });


            /*
             * Reset dropdowns.
             */
            $("#distcode")
                .empty()
                .append(
                    '<option value="">-ALL-</option>'
                );


            $("#iticode")
                .empty()
                .append(
                    '<option value="">-ALL-</option>'
                );


            $("#industryId")
                .empty()
                .append(
                    '<option value="">-ALL-</option>'
                );


            /*
             * Districts.
             */
            Object.keys(dists)
                .sort()
                .forEach(function (district) {

                    $("#distcode").append(

                        $('<option>', {
                            value: district,
                            text: district
                        })

                    );

                });


            /*
             * ITIs.
             */
            Object.keys(itis)
                .sort()
                .forEach(function (iti) {

                    $("#iticode").append(

                        $('<option>', {
                            value: iti,
                            text: iti
                        })

                    );

                });


            /*
             * Industries.
             */
            Object.keys(industries)
                .sort()
                .forEach(function (industry) {

                    $("#industryId").append(

                        $('<option>', {
                            value: industry,
                            text: industry
                        })

                    );

                });

        }


        /*
         * Filter report data.
         */
        function filterData() {

            var district = $("#distcode").val();
            var iti = $("#iticode").val();
            var industry = $("#industryId").val();


            filteredRows = allRows.filter(function (row) {

                return (

                    (!district ||
                        (row.districtName || "") === district)

                    &&

                    (!iti ||
                        (row.itiName || "") === iti)

                    &&

                    (!industry ||
                        (row.industryName || "") === industry)

                );

            });


            renderTable(filteredRows);

        }


        /*
         * Render table.
         */
        function renderTable(rows) {

            $("#tablebody").empty();


            /*
             * No filtered results.
             */
            if (!rows.length) {

                $("#tablebody").append(

                    '<tr>' +

                        '<td ' +
                        'colspan="17" ' +
                        'style="' +
                        'text-align:center;' +
                        'padding:15px;' +
                        'font-weight:bold;' +
                        '">' +

                            'NO DATA FOUND.' +

                        '</td>' +

                    '</tr>'

                );

                return;

            }


            /*
             * Add rows.
             */
            rows.forEach(function (row, index) {

                var html =

                    '<tr>' +

                        '<td>' +
                            (index + 1) +
                        '</td>' +

                        '<td>' +
                            esc(row.districtName) +
                        '</td>' +

                        '<td>' +
                            esc(row.itiName) +
                        '</td>' +

                        '<td>' +
                            esc(row.implantId) +
                        '</td>' +

                        '<td>' +
                            esc(row.industryName) +
                        '</td>' +

                        '<td>' +
                            esc(row.facultyName) +
                        '</td>' +

                        '<td>' +
                            esc(row.tradeName) +
                        '</td>' +

                        '<td>' +
                            esc(row.industryAddress) +
                        '</td>' +

                        '<td>' +
                            esc(row.hrNo) +
                        '</td>' +

                        '<td>' +
                            esc(row.fromDate) +
                        '</td>' +

                        '<td>' +
                            esc(row.toDate) +
                        '</td>' +

                        '<td>' +
                            esc(row.noOfDays) +
                        '</td>' +

                        '<td>' +
                            esc(row.noOfStudents) +
                        '</td>' +

                        '<td>' +
                            esc(row.stateName) +
                        '</td>' +

                        '<td>' +
                            esc(row.districtName) +
                        '</td>' +

                        '<td>' +
                            esc(row.location) +
                        '</td>' +

                        '<td>' +
                            esc(row.description) +
                        '</td>' +

                    '</tr>';


                $("#tablebody").append(html);

            });

        }


        /*
         * Download report as Excel.
         */
        function fnExcelReport() {

            var table =
                document.getElementById("reporttable");


            var wb =
                XLSX.utils.table_to_book(
                    table,
                    {
                        sheet: "Report"
                    }
                );


            XLSX.writeFile(
                wb,
                "INPLANT_DATEWISE_REPORT.xlsx"
            );


            return false;

        }

    </script>

</body>

</html>