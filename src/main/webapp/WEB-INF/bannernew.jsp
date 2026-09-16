<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ===== INDEX-STYLE BANNER IMAGE ===== -->
<center>
    <img src="${pageContext.request.contextPath}/images/gen.jpg" id="banner-id" width="100%" alt="ITI Banner" />
</center>
<br>

<!-- ===== INDEX-STYLE MENU BAR (public navigation) ===== -->
<ul id="menu-bar" class="no-print">
    <li>
        <a href="${pageContext.request.contextPath}/">Home</a>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">ITI Profile</a>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/reports/itiprofile">ITI Profile</a>
            <a href="${pageContext.request.contextPath}/reports/itilist">ITI LIST</a>
        </div>
    </li>
    <li>
        <a>STRIVE</a>
        <ul>
            <li><a href="${pageContext.request.contextPath}/reports/aboutstrive">ABOUT STRIVE</a></li>
            <li><a href="${pageContext.request.contextPath}/reports/disclosuremanagement">Disclosure Management</a></li>
        </ul>
    </li>
    <li>
        <a href="${pageContext.request.contextPath}/placements">PLACEMENTS / IN-PLANT TRAINING</a>
    </li>
</ul>

<br>