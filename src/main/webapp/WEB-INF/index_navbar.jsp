<%@ page language="java" pageEncoding="UTF-8" %>
<%-- ===================================================================
     Shared PUBLIC navbar (the short, index-style #menu-bar).

     Used by the home page and by the public informational pages
     (ITI List, ITI Profile, About STRIVE, Disclosure Management,
     Trade Display) which each used to inline their own copy.

     Include it with:  <%@ include file="../index_navbar.jsp" %>

     This is the PUBLIC (anonymous) navigation. The role-based dashboard
     navigation lives in district_navbar.jsp / iti_navbar.jsp /
     nodal_navbar.jsp / state_navbar.jsp and is dispatched by
     reports/header.jsp.
     =================================================================== --%>
<ul id="menu-bar">

<li>
    <a href="${pageContext.request.contextPath}/">
        Home
    </a>
</li>

<li class="dropdown">
    <a href="javascript:void(0)">ITI Profile</a>
    <div class="dropdown-content">
        <a href="${pageContext.request.contextPath}/reports/iti-profile">
            ITI Profile
        </a>
        <a href="${pageContext.request.contextPath}/reports/iti-list">ITI LIST</a>
    </div>
</li>

<li>
<a>STRIVE</a>
<ul>
<li><a href="${pageContext.request.contextPath}/reports/about-strive">ABOUT STRIVE</a></li>
<li><a href="${pageContext.request.contextPath}/reports/disclosure-management">Disclosure Management</a></li>
</ul>
</li>

<li>
<a href="${pageContext.request.contextPath}/placements">PLACEMENTS / IN-PLANT TRAINING</a>
</li>

</ul>