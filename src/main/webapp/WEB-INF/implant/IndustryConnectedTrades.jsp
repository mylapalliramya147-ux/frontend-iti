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

    <title>Industry Connected Trades Report</title>

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

    <!-- Page JavaScript -->
    <script
        src="${pageContext.request.contextPath}/js/IndustryConnectedTradesJs.js">
    </script>


    <script>

        var username = '<c:out value="${sessionScope.username}" default="" />';
        var insCode  = '<c:out value="${sessionScope.insCode}" default="" />';
        var jwtToken = '';
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

        /* ==========================================================
           Industry Connected Trades Report - page-specific styles.
           Every selector is scoped under .industry-connected-trades-page
           so no other page/module is affected.
           ========================================================== */

        body.industry-connected-trades-page {
            background-color: #ffffff;
        }

        /* Centered white report container */
        .industry-connected-trades-page .report-container {
            width: 92.5%;
            max-width: 1500px;
            margin: 20px auto 30px auto;
            padding: 15px 12px 20px 12px;
            background-color: #ffffff;
            border: 1px solid #e3e6ea;
            border-radius: 4px;
            box-shadow: 0 1px 5px rgba(0, 0, 0, 0.08);
        }

        /* Report title */
        .industry-connected-trades-page .report-title {
            margin: 0 0 6px 0;
            padding-bottom: 4px;
            text-align: center;
            text-decoration: underline;
            color: fuchsia;
            font-size: 17px;
            font-weight: 400;
        }

        /* Spinner */
        .industry-connected-trades-page #spinnerdiv {
            margin: 8px 0 10px 0;
        }

        /* Download Excel button row (top-right of report content) */
        .industry-connected-trades-page .report-actions {
            display: flex;
            justify-content: flex-end;
            margin: 2px 0 12px 0;
        }

        .industry-connected-trades-page .download-excel-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background-color: #198754;
            border: 1px solid #198754;
            color: #ffffff;
            border-radius: 6px;
            font-size: 15px;
            padding: 6px 16px;
            cursor: pointer;
        }

        .industry-connected-trades-page .download-excel-btn:hover {
            background-color: #157347;
            border-color: #146c43;
            color: #ffffff;
        }

        .industry-connected-trades-page .download-excel-btn:focus {
            color: #ffffff;
            box-shadow: 0 0 0 3px rgba(25, 135, 84, 0.25);
        }

        /* Report table */
        .industry-connected-trades-page .report-table {
            width: 100%;
            table-layout: fixed;
            margin-bottom: 0;
            font-size: 15px;
        }

        .industry-connected-trades-page .report-table th,
        .industry-connected-trades-page .report-table td {
            border: 1px solid #b8c4d8;
            color: #000000;
            vertical-align: middle;
            padding: 8px 10px;
            line-height: 1.4;
            overflow-wrap: break-word;
            word-wrap: break-word;
        }

        /* Light blue header, dark text, left-aligned and bottom-anchored:
           single-line headers (District, Trade...) line up with the second
           line of wrapped headers (ITI Code, Total Trainees), exactly as
           in the reference */
        .industry-connected-trades-page .report-table thead th {
            background-color: #cfe0f7;
            color: #1a1a1a;
            font-weight: 700;
            text-align: left;
            vertical-align: bottom;
            position: sticky;
            top: 0;
            z-index: 2;
        }

        /* Very light alternating gray rows - 1st/3rd/5th rows shaded,
           exactly as in the reference */
        .industry-connected-trades-page .report-table tbody tr:nth-child(odd) {
            background-color: #f2f2f2;
        }

        /* Column widths matching the reference proportions
           (S.No 4.5 | District 11 | ITI Code 5 | ITI Name 20.5 |
            Trade 18 | Total Trainees 7 | Industry Name 34) */
        .industry-connected-trades-page .col-sno      { width: 4.5%; }
        .industry-connected-trades-page .col-district { width: 11%; }
        .industry-connected-trades-page .col-iticode  { width: 5%; }
        .industry-connected-trades-page .col-itiname  { width: 20.5%; }
        .industry-connected-trades-page .col-trade    { width: 18%; }
        .industry-connected-trades-page .col-trainees { width: 7%; }
        .industry-connected-trades-page .col-industry { width: 34%; }

        /* Small screens: keep the table usable without changing desktop */
        @media (max-width: 767.98px) {
            .industry-connected-trades-page .report-container {
                margin: 12px;
                padding: 12px;
            }
        }

    </style>

</head>


<body class="industry-connected-trades-page">

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

    <!-- Industry Connected Trades Report -->
    <div class="industry-connected-trades-page">

        <!-- Report Container -->
        <div class="report-container">

            <!-- Title -->
            <div class="report-title">
                Industry Connected Trades Report
            </div>


            <!-- Spinner -->
            <div
                class="text-center"
                id="spinnerdiv"
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


            <!-- Controls : Download Excel (top-right) -->
            <div class="report-actions">

                <button
                    type="button"
                    onclick="return fnExcelReport();"
                    class="download-excel-btn"
                >
                    <i class="fas fa-file-excel"></i>
                    Download Excel
                </button>

            </div>


            <!-- Report Table -->
            <div class="table-responsive-lg">

                <table
                    class="table report-table"
                    id="reporttable"
                >

                    <colgroup>
                        <col class="col-sno">
                        <col class="col-district">
                        <col class="col-iticode">
                        <col class="col-itiname">
                        <col class="col-trade">
                        <col class="col-trainees">
                        <col class="col-industry">
                    </colgroup>

                    <thead>

                        <tr>

                            <th scope="col" class="col-sno">
                                S.No
                            </th>

                            <th scope="col" class="col-district">
                                District
                            </th>

                            <th scope="col" class="col-iticode">
                                ITI Code
                            </th>

                            <th scope="col" class="col-itiname">
                                ITI Name
                            </th>

                            <th scope="col" class="col-trade">
                                Trade
                            </th>

                            <th scope="col" class="col-trainees">
                                Total Trainees
                            </th>

                            <th scope="col" class="col-industry">
                                Industry Name
                            </th>

                        </tr>

                    </thead>

                    <tbody id="tablebody"></tbody>

                </table>

            </div>

        </div>

    </div>

</body>

</html>