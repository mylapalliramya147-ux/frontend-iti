<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ include file="../bannernew.jsp" %>
    <c:choose>
        <%-- logged-in: show the dashboard navbar matching the session role (same as authHome_*.jsp) --%>
        <c:when test="${not empty sessionScope.roleId}">
            <c:choose>
                <c:when test="${sessionScope.roleId eq 4 or sessionScope.roleId eq '4'}">
                    <%@ include file="../iti_navbar.jsp" %>
                </c:when>
                <c:when test="${sessionScope.roleId eq 3 or sessionScope.roleId eq '3'}">
                    <%@ include file="../district_navbar.jsp" %>
                </c:when>
                <c:when test="${sessionScope.roleId eq 10 or sessionScope.roleId eq '10'}">
                    <%@ include file="../nodal_navbar.jsp" %>
                </c:when>
                <%-- roleId 2 = Admin/State, and any other role falls back here --%>
                <c:otherwise>
                    <%@ include file="../state_navbar.jsp" %>
                </c:otherwise>
            </c:choose>
        </c:when>
        <%-- anonymous: public navigation + marquee --%>
        <c:otherwise>
            <c:if test="${empty hideNavbar or hideNavbar.toString() == 'false' or hideNavbar.toString() == '0'}">
                <%@ include file="../openNavbar.jsp" %>
                <marquee onmouseover="this.stop();" onmouseout="this.start();" scrolldelay="100">
                    <b>
                        <font color="blue" size="4">
                            Welcome to AP ITI Admission Portal&nbsp;&nbsp;|&nbsp;&nbsp;AP ITI అడ్మిషన్ పోర్టల్ కు స్వాగతం..
                        </font>
                    </b>
                </marquee>
            </c:if>
        </c:otherwise>
    </c:choose>
