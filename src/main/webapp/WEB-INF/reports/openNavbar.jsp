<nav class="navbar navbar-expand-lg custom-navbar">
    <div class="container-fluid">

        <!-- Toggle Button (Mobile) -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Items -->
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav nav-menu mx-auto">

                <li class="nav-item">
                    <a class="nav-link active" href="./">Home</a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="aboutDropdown" role="button"
                        data-bs-toggle="dropdown">
                        About
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AboutUs">About Us</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/AboutStrive">About
                                STRIVE</a></li>
                    </ul>
                </li>


                <!-- Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="atcDropdown" role="button"
                        data-bs-toggle="dropdown">
                        ATC's/ITI's
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/ItiList">ATC's/ITI's
                                Details</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/SeatsOpen">Seats Open</a>
                        </li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/AtcItiPhone">ATC-ITI Phone Nos.</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="./Course">Courses</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Syllabus</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#">Prospectus</a>
                </li>
                <!-- ANNEXURE -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="annexDropdown" role="button"
                        data-bs-toggle="dropdown">
                        Annexure
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">Annexure-I</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-II</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-III (Payment Fee in Govt ITI's)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-IV (PWD Category)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-V (Options Form)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-VI (Caste Certificate)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-VII (Medical Certificate)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-VIII (Ex-Serviceman)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-IX (Residence Certificate)</a></li>
                        <li><a class="dropdown-item" href="#">Annexure-X (Income Certificate)</a></li>

                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Help Desk</a>
                </li>

                <!-- E-Learning Dropdown -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="eLearnDropdown" role="button"
                        data-bs-toggle="dropdown">
                        E-Learning
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">E-Books</a></li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Login">Login</a>
                </li>

                <!-- SCHEMES -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="schemeDropdown" role="button"
                        data-bs-toggle="dropdown">
                        Schemes
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="#">STRIVE</a></li>
                        <li><a class="dropdown-item" href="#">PPP</a></li>
                        <li><a class="dropdown-item" href="#">VTIP</a></li>
                        <li><a class="dropdown-item" href="#">DST</a></li>
                        <li><a class="dropdown-item" href="#">Useful Links</a></li>
                    </ul>
                </li>


            </ul>
        </div>
    </div>
</nav>