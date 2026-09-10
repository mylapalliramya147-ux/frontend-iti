@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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


    <!-- Report Container -->
    <div
        class="container-fluid border p-2 mt-2 shadow-lg"
        style="border-radius: 5px;"
    >

        <!-- Title -->
        <div
            align="center"
            style="text-decoration: underline; color: fuchsia;"
        >
            INDUSTRY CONNECTED TRADES REPORT
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


        <!-- Controls -->
        <div class="row mb-1">

            <div class="col-10"></div>


            <div class="col-2">
                <button
                    onclick="return fnExcelReport();"
                    class="btn btn-info btn-sm mt-4"
                >
                    DOWNLOAD EXCEL
                </button>
            </div>

        </div>


        <!-- Report Table -->
        <table
            class="table table-bordered"
            id="reporttable"
        >

            <thead>

                <tr>

                    <td
                        style="background-color: black; color: white;"
                    >
                        S.NO
                    </td>

                    <td
                        style="background-color: black; color: white;"
                    >
                        DISTRICT
                    </td>

                    <td
                        style="background-color: black; color: white;"
                    >
                        ITI CODE
                    </td>

                    <td
                        style="background-color: black; color: white;"
                    >
                        ITI NAME
                    </td>

                    <td
                        style="background-color: black; color: white;"
                    >
                        TRADE
                    </td>

                    <td
                        style="background-color: black; color: white;"
                                        >
                        TOTAL TRAINEEES
                    </td>

                    <td
                        style="background-color: black; color: white;"
                    >
                        INDUSTRY NAME
                    </td>

                </tr>

            </thead>

            <tbody id="tablebody"></tbody>

        </table>

    </div>

</body>

</html>