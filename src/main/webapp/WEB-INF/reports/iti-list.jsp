<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <title>ITI List</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
         
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>:: ITI  ::</title>
<link rel="shortcut icon" type="image/ico" href="iti.png" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal-theme.css?v=2">
</head>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/expe1011.css">

<style>

/* ================= MENU CSS (Your Existing) ================= */






/* ================= POPUP CSS ================= */

.popup-overlay {
    display: none;
    position: fixed;
    z-index: 99999;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.7);
}

.popup-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #fff;
    padding: 8px;
    border-radius: 10px;
}

.popup-img {
    width: 500px;
    max-width: 90%;
    height: auto;
    cursor: pointer;
}

.close-btn {
    position: absolute;
    top: 5px;
    right: 12px;
    font-size: 30px;
    color: red;
    cursor: pointer;
}

</style>
</head>

<body>

<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>

<br><br>

<!-- ================= MENU BAR ================= -->

<%@ include file="../index_navbar.jsp" %>

<br><br>

<!-- ================= MARQUEE ================= -->

<marquee onmouseover="this.stop();"
          onmouseout="this.start();"
          scrolldelay="100">

<b>
<font color="blue" size="5">

<a href=""
   target="_blank">

 ITI Admissions 2026 Phase -3 registrations, applications and verifications available in  all GovtPvts ITIs on 15-08-2026 and 19-08-2026. 

</a>

</font>
</b>

</marquee>

<br><br>

<!-- ================= ITI LIST FORM ================= -->

<form id="itiListForm">
    <p>&nbsp;</p>
<h2 align="center" class="style1">
    <strong>List of Government and Private ITIs</strong>
</h2>

<div style="width:90%; margin:auto; text-align:right; margin-bottom:10px;">
    <input type="button" value="Download Excel" onclick="exportToExcel();">
</div>

<table width="50%" align="center" bgcolor="#cbd6b2" cellpadding="8" cellspacing="0">
    <tr bgcolor="#4ab131">
        <td colspan="3" align="center" style="color:white;font-weight:bold;">
            ITI List
        </td>
    </tr>

<tr>
    <td align="right" width="35%">
        <b>Select ITI Type :</b>
    </td>

    <td align="left" width="35%">
        <select id="govtType" style="width:180px;" onchange="loadItiList()">
            <option value="">-- Select --</option>
              <option value="A" selected>
                All
            </option>
            <option value="G" >
                Government
            </option>
            <option value="P" >
                Private
            </option>
        </select>
    </td>

    <td align="left" width="30%">
        <input type="button" value="Proceed" onclick="loadItiList()">
    </td>
</tr>

</table>

</form>

<br>

<!-- ================= ITI LIST TABLE ================= -->

<div id="loader" style="display: none; text-align: center; padding: 20px;">
    <img src="${pageContext.request.contextPath}/images/loading.gif" alt="Loading..." style="width: 40px; height: 40px;" />
    <p>Loading ITI data...</p>
</div>

<style>
    #itiListTableWrap {
        display: none;
        text-align: center;
    }
    #itiListTable {
        border-collapse: collapse;
        width: 98%;
        margin: 0 auto;
    }
    #itiListTable th,
    #itiListTable td {
        border: 1px solid #2f7d1f;
        padding: 8px;
        text-align: left;
    }
    #itiListTable tbody tr:nth-child(even) {
        background-color: #f2f8ec;
    }
    #itiListTable tbody tr:hover {
        background-color: #dceecb;
    }
</style>

<div id="itiListTableWrap">
<table border="0" cellpadding="6" cellspacing="0" width="98%" align="center" id="itiListTable" style="border-collapse: collapse; margin-left: auto; margin-right: auto;">

<tr bgcolor="#4ab131" style="color:white;">

<th style="border: 1px solid #2f7d1f; padding: 8px;">SL.No</th>
<th style="border: 1px solid #2f7d1f; padding: 8px;">District Name</th>
<th style="border: 1px solid #2f7d1f; padding: 8px;">NIC ITI Code</th>
<th style="border: 1px solid #2f7d1f; padding: 8px;">NCVT Code</th>
<th style="border: 1px solid #2f7d1f; padding: 8px;">ITI Name</th>

</tr>

<tbody id="itiTableBody">
</tbody>

</table>
</div>

<br><br>

<style>
    #footer{
        position:fixed;
        bottom:0px;
        width:100%;
        height:25px;
        padding-top: 8px;
        text-align: center;
        background-color: #0E4878;
        border-top: 1px #000000 solid;
        font-size: 12px;
        font-family: arial, verdana;
        color: #ffffff;
    }
</style>

<br><br>
<br><br>

<div id="footer">
    2013 @ All Rights Reserved &nbsp;&nbsp; Designed by &nbsp; National Informatics Center
    <font color="white"><a href="http://www.ap.nic.in" title="">National Informatics Center </a></font>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="white"><a href="disclaimer.jsp">Disclaimer</a></font>
</div>

<script>
let itiDataCache = [];

function loadItiList() {
    const govtType = document.getElementById('govtType').value;
    const loader = document.getElementById('loader');
    const wrap = document.getElementById('itiListTableWrap');
    const tbody = document.getElementById('itiTableBody');
    
    loader.style.display = 'block';
    wrap.style.display = 'none';
    tbody.innerHTML = '';

    let url = '${backendApiUrl}/trade-display/iti-list';
    if (govtType && govtType !== '') {
        url += '?type=' + encodeURIComponent(govtType);
    }

    fetch(url, { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            loader.style.display = 'none';
            
            if (!data.data || data.data.length === 0) {
                itiDataCache = [];
                tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; padding: 20px; font-weight: bold;">No ITIs found.</td></tr>';
                wrap.style.display = 'block';
                return;
            }

            itiDataCache = data.data;
            let rows = '';
            data.data.forEach((item, index) => {
                rows += '<tr>' +
                               '<td>' + (index + 1) + '</td>' +
                               '<td>' + (item.districtName || '') + '</td>' +
                               '<td>' + (item.nicItiCode || '') + '</td>' +
                               '<td>' + (item.ncvtCode || '') + '</td>' +
                               '<td>' + (item.itiName || '') + '</td>' +
                               '</tr>';
            });

            tbody.innerHTML = rows;
            wrap.style.display = 'block';
        })
        .catch(error => {
            loader.style.display = 'none';
            itiDataCache = [];
            tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; padding: 20px; font-weight: bold; color: red;">Error loading ITI data. Please try again.</td></tr>';
            wrap.style.display = 'block';
            console.error('Error:', error);
        });
}

// Export the currently-loaded data as an Excel (.xls HTML table) file
function exportToExcel() {
    if (!itiDataCache || itiDataCache.length === 0) {
        alert('No data available to download. Please load the ITI list first.');
        return;
    }

    let csv = '\ufeffSL.No,District Name,NIC ITI Code,NCVT Code,ITI Name\n';
    itiDataCache.forEach((item, index) => {
        const escape = (val) => {
            const s = (val || '').toString();
            return '"' + s.replace(/"/g, '""') + '"';
        };
        csv += (index + 1) + ',' +
               escape(item.districtName) + ',' +
               escape(item.nicItiCode) + ',' +
               escape(item.ncvtCode) + ',' +
               escape(item.itiName) + '\n';
    });

    const blob = new Blob([csv], { type: 'application/vnd.ms-excel;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'ITI_List.xls';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
}

document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const govtType = urlParams.get('type');
    if (govtType) {
        document.getElementById('govtType').value = govtType;
    }
    // Table stays hidden until the user picks an ITI type and clicks Proceed
});
</script>

</body>
</html>