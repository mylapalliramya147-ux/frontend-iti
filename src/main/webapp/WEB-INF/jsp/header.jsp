<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <header class="fixed-top-header">
        <%@ include file="bannernew.jsp" %>
    </header>
    <c:if test="${empty hideNavbar or hideNavbar.toString() == 'false' or hideNavbar.toString() == '0'}">
    <%@ include file="openNavbar.jsp" %>
        <div class="news-marquee">
            <div class="marquee-content">
                <img src="${pageContext.request.contextPath}/images/new.gif" alt="new" style="height: 20px;">
                <span style="color: white;"> Welcome to AP ITI Admission Portal </span>
                <span class="mx-3 text-white">|</span>
                <img src="${pageContext.request.contextPath}/images/new.gif" alt="new" style="height: 20px;">
                <span style="color: white;"> AP ITI అడ్మిషన్ పోర్టల్ కు స్వాగతం.. </span>
            </div>
        </div>
    </c:if>