<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>:: ITI - Disclaimer ::</title>
    <link rel="shortcut icon" type="image/ico" href="${pageContext.request.contextPath}/images/iti.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
    <style>
        body { margin: 0; font-family: Verdana, Arial, sans-serif; background: #fff; }
        .disclaimer-card {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: #ffffcc;
            border: 2px solid #006600;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.15);
        }
        .disclaimer-card h2 {
            color: #0E4878;
            margin-top: 0;
            border-bottom: 2px solid #006600;
            padding-bottom: 10px;
        }
        .disclaimer-card p {
            font-size: 13px;
            line-height: 1.6;
            color: #333;
        }
    </style>
</head>
<body>
    <center><img src="${pageContext.request.contextPath}/images/gen.jpg" width="100%" alt="Banner" /></center>
    <div class="disclaimer-card">
        <h2>Disclaimer</h2>
        <p>
            The information provided on this portal is published and managed by the
            Department of Employment and Training, Government of Andhra Pradesh, in technical collaboration with National Informatics Centre (NIC).
        </p>
        <p>
            While every effort has been made to ensure the accuracy and currency of the content on this website,
            the Department does not accept any responsibility or liability for any errors, omissions, or the consequences of any action taken based on the information provided herein.
        </p>
        <p>
            Users are advised to verify details with official admission notifications, brochures, and respective ITI institutions before making decisions.
        </p>
        <div style="text-align: center; margin-top: 25px;">
            <a href="javascript:history.back()" style="display: inline-block; padding: 6px 18px; background: #0E4878; color: #fff; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px;">« Go Back</a>
        </div>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
