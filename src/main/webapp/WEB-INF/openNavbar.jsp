<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- Index-style #menu-bar row for public/informational links (pure-CSS dropdowns) --%>
<ul id="menu-bar" class="no-print">
    <li class="dropdown">
        <a href="javascript:void(0)">ATC's/ITI's</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/ItiList">ATC's/ITI's Details</a>
            <a href="${pageContext.request.contextPath}/SeatsOpen">Seats Open</a>
            <a href="${pageContext.request.contextPath}/AtcItiPhone">ATC-ITI Phone Nos.</a>
        </div>
    </li>
    <li><a href="${pageContext.request.contextPath}/Course">Courses</a></li>
    <li><a href="#">Syllabus</a></li>
    <li><a href="#">Prospectus</a></li>
    <li class="dropdown">
        <a href="javascript:void(0)">Annexure</a>
        <div class="dropdown-content">
            <a href="#">Annexure-I</a>
            <a href="#">Annexure-II</a>
            <a href="#">Annexure-III (Payment Fee in Govt ITI's)</a>
            <a href="#">Annexure-IV (PWD Category)</a>
            <a href="#">Annexure-V (Options Form)</a>
            <a href="#">Annexure-VI (Caste Certificate)</a>
            <a href="#">Annexure-VII ( Medical Certificate)</a>
            <a href="#">Annexure-VIII (Ex-Serviceman)</a>
            <a href="#">Annexure-IX (Residence Certificate)</a>
            <a href="#">Annexure-X (Income Certificate)</a>
        </div>
    </li>
    <li><a href="#">Help Desk</a></li>
    <li class="dropdown">
        <a href="javascript:void(0)">E-Learning</a>
        <div class="dropdown-content">
            <a href="#">E-Books</a>
        </div>
    </li>
    <li><a href="${pageContext.request.contextPath}/Login">Login</a></li>
    <li class="dropdown">
        <a href="javascript:void(0)">Schemes</a>
        <div class="dropdown-content">
            <a href="#">STRIVE</a>
            <a href="#">PPP</a>
            <a href="#">VTIP</a>
            <a href="#">DST</a>
            <a href="#">Useful Links</a>
        </div>
    </li>
</ul>