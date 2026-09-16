<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ include file="../bannernew.jsp" %>
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