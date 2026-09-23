<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>:: ITI Portal - Service Under Development ::</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/iti-portal.css">
</head>
<body class="portal-page">
    <center>
        <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
    </center>

    <c:choose>
        <c:when test="${not empty sessionScope.roleId}">
            <c:choose>
                <c:when test="${sessionScope.roleId eq 4 or sessionScope.roleId eq '4'}">
                    <%@ include file="../navbars/iti_navbar.jsp" %>
                </c:when>
                <c:when test="${sessionScope.roleId eq 3 or sessionScope.roleId eq '3'}">
                    <%@ include file="../navbars/district_navbar.jsp" %>
                </c:when>
                <c:when test="${sessionScope.roleId eq 10 or sessionScope.roleId eq '10'}">
                    <%@ include file="../navbars/nodal_navbar.jsp" %>
                </c:when>
                <c:otherwise>
                    <%@ include file="../navbars/state_navbar.jsp" %>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <%@ include file="../navbars/index_navbar.jsp" %>
        </c:otherwise>
    </c:choose>

    <div class="container my-5">
        <div class="card shadow-sm border-0 text-center mx-auto" style="max-width: 580px; padding: 35px 25px; border-radius: 12px; background: #ffffff;">
            <div class="mb-3 text-warning">
                <i class="fas fa-tools fa-3x"></i>
            </div>
            <h3 class="fw-bold text-dark mb-2">Service Under Active Development</h3>
            <p class="text-muted mb-4" style="font-size: 0.95rem;">
                This module or administration service is scheduled for release in the upcoming ITI admissions phase. Please check back soon or access available features from your dashboard.
            </p>
            <div>
                <a href="${pageContext.request.contextPath}/authHome" class="btn btn-primary px-4 py-2 fw-semibold">
                    <i class="fas fa-home me-2"></i> Return to Dashboard
                </a>
            </div>
        </div>
    </div>

    <%@ include file="../footer.jsp" %>
</body>
</html>
