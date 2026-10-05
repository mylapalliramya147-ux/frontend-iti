<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>DEV - All Pages | ITI Admission</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
  html { scroll-behavior: smooth; }
  body { background:#f4f6f9; }
  .dev-sidebar { position: sticky; top: 12px; }
  .dev-sidebar .nav-link { border-radius: 6px; color:#333; display:flex; justify-content:space-between; }
  .dev-sidebar .nav-link:hover { background:#e9ecef; }
  .dev-sidebar .nav-link.active { background:#0d6efd; color:#fff; }
  .badge-count { background:#dee2e6; color:#495057; }
  .page-link-item { text-decoration:none; color:#212529; display:flex; justify-content:space-between; align-items:center;
                     padding:7px 12px; border:1px solid #e9ecef; border-radius:6px; margin-bottom:5px; background:#fff; }
  .page-link-item:hover { border-color:#0d6efd; background:#f8f9ff; }
  .page-link-main { color:#212529; text-decoration:none; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
  .page-link-main:hover { color:#0d6efd; }
  .badge-route { font-size:.68rem; }
  .badge-done { background:#198754; }
  .badge-partial { background:#6c757d; }
  .badge-wip { background:#ffc107; color:#212529; }
  .dev-header { background:linear-gradient(90deg,#212529,#343a40); color:#fff; border-radius:10px; }

  /* Role tags: which login owns the page. */
  .role-tag { font-size:.68rem; font-weight:600; }
  .role-iti { background:#0d6efd; color:#fff; }
  .role-district { background:#198754; color:#fff; }
  .role-nodal { background:#6f42c1; color:#fff; }
  .role-admin { background:#dc3545; color:#fff; }
  .role-multi { background:#fd7e14; color:#fff; }
  .role-any { background:#6c757d; color:#fff; }

  /* Page the signed-in login does not own: listed, but visibly not openable. */
  .page-locked { background:#f8f9fa; border-style:dashed; color:#adb5bd; }
  .page-locked .page-link-main { color:#adb5bd; }
  .page-locked .page-link-main:hover { color:#6c757d; text-decoration:underline; }
  .lock-icon { margin-right:4px; font-size:.8rem; }
</style>
</head>
<body>
<div class="container-fluid py-3 px-4">

  <div class="dev-header p-3 mb-4 d-flex justify-content-between align-items-center">
    <div>
      <h3 class="mb-1">&#128736; DEV - Page Index</h3>
      <small class="text-white-50">Temporary development tool - every JSP in WEB-INF. All pages are listed for every login, but only the pages your own login owns will open; the rest are shown locked with an 🔒. Green = done (has its own real URL), Grey = partial (navbar/header/include), Yellow = wip (no route yet). Tags show which login owns each page. Click the &#8599; badge to open the real role-guarded route.</small>
    </div>
    <input id="devSearch" type="search" class="form-control w-25" placeholder="Search pages..." autofocus>
  </div>

  <!-- ============ SESSION BANNER (login happens on /dev/login) ============ -->
  <c:if test="${param.error eq 'denied'}">
    <div class="alert alert-danger d-flex justify-content-between align-items-center">
      <span>
        &#128683; <b><c:out value="${param.page}"/></b> belongs to another login and was not opened.
        You are signed in as <c:out value="${devRoleLabel}"/>
        <c:if test="${devRoleId ne null}"> (role <c:out value="${devRoleId}"/>)</c:if>.
        Sign in with that login to develop this page.
      </span>
      <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/dev/logout">Switch login</a>
    </div>
  </c:if>

  <div class="alert alert-success d-flex justify-content-between align-items-center">
    <span>
      &#9989; Signed in as <b><c:out value="${devUserName}"/></b>
      <c:if test="${not empty devFullName}">&nbsp;(<c:out value="${devFullName}"/>)</c:if>
      &nbsp;- <b><c:out value="${devRoleLabel}"/></b>
      <c:if test="${devRoleId ne null}"> (role <c:out value="${devRoleId}"/>)</c:if>
      <c:if test="${not empty devItiName}">, <c:out value="${devItiName}"/></c:if>
      <c:if test="${devIsAdmin}"> <span class="badge bg-danger">full access</span></c:if>
      <small class="text-muted">All pages are listed below; only the ones your login owns will open.</small>
    </span>
    <span>
      <a class="btn btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/dev">Refresh</a>
      <a class="btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/dev/logout">Switch login</a>
    </span>
  </div>

  <div class="row">
    <div class="col-md-2">
      <nav class="dev-sidebar nav flex-column gap-1">
        <c:forEach var="entry" items="${pages}">
          <a class="nav-link" href="#mod-${entry.key}">
            <c:out value="${entry.key}"/><span class="badge badge-count"><c:out value="${fn:length(entry.value)}"/></span>
          </a>
        </c:forEach>
      </nav>
    </div>

    <div class="col-md-10" id="devPageList">
      <c:forEach var="entry" items="${pages}">
        <div class="module-section mb-4" id="mod-${entry.key}" data-module="${entry.key}">
          <h5 class="text-uppercase text-secondary border-bottom pb-1"><c:out value="${entry.key}"/></h5>
          <div class="row">
            <c:forEach var="page" items="${entry.value}">
              <c:set var="viewName" value="${entry.key}/${page}"/>
              <c:set var="status" value="${pageStatuses[viewName]}"/>
              <c:set var="roleTag" value="${roleTags[viewName]}"/>
              <c:set var="canOpen" value="${allowedViews[viewName]}"/>
              <c:set var="roleTagClass" value="${roleTagClasses[viewName]}"/>
              <div class="col-md-4 page-item" data-name="${page}" data-roles="${roleTag}">
                <%-- Every page is listed, but /dev/view only opens the ones the signed-in
                     login owns. Locked pages are muted and carry the owning login's tag.
                     The ↗ badge jumps to the real role-guarded controller route. --%>
                <div class="page-link-item ${canOpen ? '' : 'page-locked'}">
                  <a class="page-link-main" href="${pageContext.request.contextPath}/dev/view/${entry.key}/${page}">
                    <c:if test="${not canOpen}"><span class="lock-icon">&#128274;</span></c:if>
                    <c:out value="${page}"/>
                  </a>
                  <span class="d-flex align-items-center gap-1">
                    <c:if test="${not empty roleTag}">
                      <span class="badge role-tag ${roleTagClass}">${roleTag}</span>
                    </c:if>
                    <c:if test="${not empty realRoutes[viewName]}">
                      <a class="badge badge-route text-decoration-none"
                         title="Open the real controller route (role-guarded)"
                         href="${pageContext.request.contextPath}${realRoutes[viewName]}">&#8599;</a>
                    </c:if>
                    <span class="badge badge-route badge-${status}">
                      <c:out value="${status}"/>
                    </span>
                  </span>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>

<script>
  // live search filter across all sections
  document.getElementById('devSearch').addEventListener('input', function () {
    var q = this.value.toLowerCase();
    document.querySelectorAll('.page-item').forEach(function (el) {
      el.style.display = el.getAttribute('data-name').toLowerCase().indexOf(q) !== -1 ? '' : 'none';
    });
    document.querySelectorAll('.module-section').forEach(function (sec) {
      var visible = sec.querySelectorAll('.page-item:not([style*="none"])').length;
      sec.style.display = visible ? '' : 'none';
    });
  });
</script>
</body>
</html>
