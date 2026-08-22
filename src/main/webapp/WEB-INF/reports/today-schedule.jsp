<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <title>:: ITI ::</title>
    <link rel="shortcut icon" type="image/ico" href="iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <style>
        #menu-bar {
            width: 100%;
            margin: 0px 0px 0px 0px;
            padding: 0px 0px 0px 0px;
            height: 30px;
            line-height: 100%;
            border-radius: 0px;
            -webkit-border-radius: 24px;
            -moz-border-radius: 24px;
            box-shadow: 2px 2px 2px #666666;
            -webkit-box-shadow: 2px 2px 2px #666666;
            -moz-box-shadow: 2px 2px 2px #666666;
            background: #e4eeb9;
            position: relative;
            z-index: 999;
        }
        #menu-bar li {
            margin: 0px 0px 6px 0px;
            padding: 0px 6px 0px 6px;
            float: left;
            position: relative;
            list-style: none;
        }
        #menu-bar a {
            font-weight: bold;
            font-family: verdana;
            font-size: 14px;
            color: #000000;
            background: #e4eeb9;
            text-decoration: none;
            display: block;
            padding: 6px 20px 6px 20px;
            margin: 0;
            margin-bottom: 6px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
        }
        #menu-bar li ul li a {
            margin: 0;
        }
        #menu-bar .active a, #menu-bar li:hover > a {
            background: blue;
            background: lightblue;
            background: -ms-linear-gradient(top, #EB4954, #A19197);
            background: -webkit-gradient(linear, left top, left bottom, from(#EB4954), to(#A19197));
            background: -moz-linear-gradient(top, #EB4954, #A19197);
            color: white;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
            -moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
        }
        #menu-bar ul li:hover a, #menu-bar li:hover li a {
            background: lightgoldenrodyellow;
            color: #000000;
            -box-shadow: none;
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
        }
        #menu-bar ul a:hover {
            background: lightblue !important;
            color: black !important;
            border-radius: 0;
            -webkit-border-radius: 0;
            -moz-border-radius: 0;
        }
        #menu-bar li:hover > ul {
            display: block;
        }
        #menu-bar ul {
            background: block;
            background: linear-gradient(top, #FFD21C, #CF7688);
            background: -ms-linear-gradient(top, #FFD21C, #CF7688);
            background: -webkit-gradient(linear, left top, left bottom, from(#FFD21C), to(#CF7688));
            background: -moz-linear-gradient(top, #FFD21C, #CF7688);
            display: none;
            margin: 0;
            padding: 0;
            width: 300px;
            position: absolute;
            top: 30px;
            left: 0;
            border-radius: 0px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            -webkit-box-shadow: 2px 2px 3px #222222;
            -moz-box-shadow: 2px 2px 3px #222222;
            box-shadow: 2px 2px 3px #222222;
        }
        #menu-bar ul li {
            float: none;
            margin: 0;
            padding: 0;
        }
        #menu-bar ul a {
            padding: 10px 0px 10px 15px;
            background: gold;
            color: grey;
            font-size: 13px;
            font-style: normal;
            font-family: verdana;
            font-weight: normal;
            text-shadow: 2px 2px 3px #FFFFFF;
        }
        #menu-bar ul li:first-child > a {
            border-top-left-radius: 10px;
            -webkit-border-top-left-radius: 10px;
            -moz-border-radius-topleft: 10px;
            border-top-right-radius: 10px;
            -webkit-border-top-right-radius: 10px;
            -moz-border-radius-topright: 10px;
        }
        #menu-bar ul li:last-child > a {
            border-bottom-left-radius: 10px;
            -webkit-border-bottom-left-radius: 10px;
            -moz-border-radius-bottomleft: 10px;
            border-bottom-right-radius: 10px;
            -webkit-border-bottom-right-radius: 10px;
            -moz-border-radius-bottomright: 10px;
        }
        #menu-bar:after {
            content: ".";
            display: block;
            clear: both;
            visibility: hidden;
            line-height: 0;
            height: 0;
        }
        #menu-bar {
            display: inline-block;
        }
        html[xmlns] #menu-bar {
            display: block;
        }
        * html #menu-bar {
            height: 1%;
        }
        .report-table th {
            font-size: 12px;
            padding: 12px 5px;
            background: #0f2c4e !important;
            color: white !important;
            text-transform: uppercase;
        }
        .report-table td {
            font-size: 13px;
            padding: 10px 5px;
            border-bottom: 1px solid #f0f0f0;
            font-weight: 500;
            color: #1e293b;
        }
        .loader-spinner {
            display: none;
            text-align: center;
            padding: 40px;
            color: #003366;
        }
        .num {
            text-align: center;
            font-weight: 700 !important;
        }
        #footer {
            position: fixed;
            bottom: 0px;
            width: 100%;
            height: 25px;
            padding-top: 8px;
            text-align: center;
            background-color: #0E4878;
            border-top: 1px #000000 solid;
            font-size: 12px;
            font-family: arial, verdana;
            color: #ffffff;
        }
    </style>
</head>
<body>
    <c:set var="hideNavbar" value="true" scope="request" />
    <%@ include file="header.jsp" %>

    <br>
    <div align="center">
        <font size="4" color="blue" id="pageTitle">Today Admission Schedule ITI's</font>
    </div>
    <br>

    <div class="loader-spinner" id="loader">
        <i class="fas fa-spinner fa-spin fa-3x"></i>
        <p class="mt-3 fw-bold">Loading today's schedule...</p>
    </div>

    <div class="container-fluid px-4 py-4" id="reportView" style="display: none;">
        <div class="shadow" style="background-color: #fff; border-radius: 8px; overflow: hidden; border: 1px solid #e0e0e0;">
            <div style="overflow-y: auto; max-height: 600px;">
                <table class="table table-bordered mb-0 table-hover text-center report-table" id="tot" style="min-width: 1000px;">
                    <thead>
                        <tr bgcolor="lightblue">
                            <th>S.No</th>
                            <th>District Name</th>
                            <th>ITI Name</th>
                            <th>Merit From</th>
                            <th>Merit To</th>
                            <th>Call Date</th>
                            <th>Call Time</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script>
        function formatDate(date) {
            const d = new Date(date);
            const day = String(d.getDate()).padStart(2, '0');
            const month = String(d.getMonth() + 1).padStart(2, '0');
            const year = d.getFullYear();
            return day + '-' + month + '-' + year;
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('pageTitle').innerText = 'Today Admission Schedule ITI\'s (' + formatDate(new Date()) + ')';
            loadReport();
        });

        function loadReport() {
            document.getElementById('loader').style.display = 'block';
            document.getElementById('reportView').style.display = 'none';

            fetch('${backendApiUrl}/today-schedule', { method: 'GET' })
            .then(response => response.json())
            .then(response => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';

                const tbody = document.getElementById('tableBody');
                tbody.innerHTML = '';

                const data = response.data || [];
                if (data.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="7" style="text-align:center; padding:20px; font-weight: bold;">No schedules for today.</td></tr>';
                    return;
                }

                data.forEach((row, index) => {
                    const tr = document.createElement('tr');
                    tr.innerHTML =
                        '<td>' + (index + 1) + '</td>' +
                        '<td>' + (row.distName || '-') + '</td>' +
                        '<td style="text-align: left;">' + (row.itiName || '-') + '</td>' +
                        '<td class="num">' + (row.meritFrom || '-') + '</td>' +
                        '<td class="num">' + (row.meritTo || '-') + '</td>' +
                        '<td>' + (row.calDate || '-') + '</td>' +
                        '<td>' + (row.calTime || '-') + '</td>';
                    tbody.appendChild(tr);
                });
            })
            .catch(error => {
                document.getElementById('loader').style.display = 'none';
                document.getElementById('reportView').style.display = 'block';
                alert('Error loading data: ' + error.message);
                console.error('Error:', error);
            });
        }
    </script>
</body>
</html>
