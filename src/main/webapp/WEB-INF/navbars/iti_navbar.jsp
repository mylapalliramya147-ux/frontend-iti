<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- ===================================================================
     ITI dashboard navbar (roleId 4, index-style #menu-bar).

     Included by (2 files):
       - reports/header.jsp            (roleId 4 branch, served inside every
                                        role-aware reports/* page)
       - jsp/authHome_iti.jsp          (ITI dashboard home)

     NOTE: the "c" taglib above is declared but currently unused in this
     file - the same markup was copied verbatim from the matching
     authHome_*.jsp. Keep or drop as you prefer; it is harmless.
     =================================================================== --%>
<ul id="menu-bar">
    <li><a href="${pageContext.request.contextPath}/authHome">Home</a></li>

    <li><a href="#">ITI Services</a>
        <ul></ul>
    </li>

            <li><a href="#">ITI Reports</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/reports/api-dashboard-iti">API Dashboard (ITI)</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/applicant-report">Applicant Report</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/admission-report">Admission Report</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/dsc-list">DSC List</a></li>
        </ul>
    </li>

            <li><a href="#">Admissions</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/MeritList">MeritList with GPA</a></li>
            <li><a href="${pageContext.request.contextPath}/#">Schedule Entry</a></li>
        </ul>
    </li>

    <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>

    <c:if test="${not empty sessionScope.username}"><li class="welcome-tag">
        Welcome, ${username}<br>
        ${itiName}
    </li></c:if>
</ul>
