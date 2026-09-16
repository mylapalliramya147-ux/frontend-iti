<%-- ===================================================================
     Shared navbar for the portal modules (placements / implant / placement dashboard).
     Every page in those modules used to inline its own copy of this markup.
     Include it with:  <%@ include file="../portal_navbar.jsp" %>
     - #userinfo is populated by each page's own script.
     - Logout points at the real /logout mapping in LoginController.
     =================================================================== --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">

        <!-- Home -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/placements/loginSuccess">
            <i class="fas fa-home"></i> Home
        </a>

        <!-- Welcome User Info -->
        <div class="text-white fw-bold">
            Welcome :
            <span id="userinfo"></span>
        </div>

        <!-- Logout -->
        <div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

    </div>
</nav>