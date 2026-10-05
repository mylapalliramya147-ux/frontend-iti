<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dev Login | ITI Admission</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
  <style>
    body { background:#f4f6f9; }
    .dev-header { background:linear-gradient(90deg,#212529,#343a40); color:#fff; border-radius:10px; }
    .dev-login-card { max-width:420px; margin:40px auto; border:2px solid #0d6efd; border-radius:10px; background:#f8fbff; }
  </style>
</head>
<body>
  <div class="container px-4">
    <div class="dev-header p-3 mb-4">
      <h3 class="mb-1">&#128736; DEV - Login</h3>
      <small class="text-white-50">
        Temporary development tool. Pick the login you want to develop as &mdash; after signing in,
        /dev opens and you can browse every page, but only the pages that login owns will open.
      </small>
    </div>

    <div class="dev-login-card p-4 shadow-sm">
      <h5 class="mb-3">&#128274; Sign in</h5>

      <c:if test="${not empty param.error}">
        <div class="alert alert-danger py-2">
          <c:choose>
            <c:when test="${param.error eq 'invalid'}">Invalid username or password.</c:when>
            <c:when test="${param.error eq 'inactive'}">Your account is inactive. Contact administrator.</c:when>
            <c:when test="${param.error eq 'captcha'}">Invalid captcha, please try again.</c:when>
            <c:otherwise>Login service unavailable, please try again later.</c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <form method="post" action="${pageContext.request.contextPath}/iti/login.do" autocomplete="off">
        <input type="hidden" name="dev" value="true"/>
        <input type="hidden" name="redirect" value="/dev"/>
        <div class="mb-2">
          <label class="form-label mb-1" for="devUname">User Name <span class="text-danger">*</span></label>
          <input class="form-control form-control-sm" type="text" id="devUname" name="uname"
                 placeholder="e.g. LOGINITI" required autofocus/>
        </div>
        <div class="mb-3">
          <label class="form-label mb-1" for="devPwd">Password <span class="text-danger">*</span></label>
          <input class="form-control form-control-sm" type="password" id="devPwd" name="pwd" required/>
        </div>
        <button class="btn btn-primary btn-sm w-100" type="submit">Login</button>
      </form>

      <div class="text-secondary small mt-3">
      </div>
    </div>

    <div class="text-center">
      <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/">&larr; Normal application login</a>
    </div>
  </div>
</body>
</html>