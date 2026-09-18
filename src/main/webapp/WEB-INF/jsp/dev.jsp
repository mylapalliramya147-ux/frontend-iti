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
  .badge-route { font-size:.68rem; }
  .badge-real { background:#198754; }
  .badge-wip { background:#ffc107; color:#212529; }
  .dev-header { background:linear-gradient(90deg,#212529,#343a40); color:#fff; border-radius:10px; }
</style>
</head>
<body>
<div class="container-fluid py-3 px-4">

  <div class="dev-header p-3 mb-4 d-flex justify-content-between align-items-center">
    <div>
      <h3 class="mb-1">&#128736; DEV - Page Index</h3>
      <small class="text-white-50">Temporary development tool - every JSP in WEB-INF. Green = real route, Yellow = WIP (opened via /dev/view passthrough).</small>
    </div>
    <input id="devSearch" type="search" class="form-control w-25" placeholder="Search pages..." autofocus>
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
              <div class="col-md-4 page-item" data-name="${page}">
                <a class="page-link-item"
                   href="${pageContext.request.contextPath}${realRoutes[viewName] != null ? realRoutes[viewName] : '/dev/view/'.concat(entry.key).concat('/').concat(page)}">
                  <span><c:out value="${page}"/></span>
                  <span class="badge badge-route ${realRoutes[viewName] != null ? 'badge-real' : 'badge-wip'}">
                    ${realRoutes[viewName] != null ? 'route' : 'wip'}
                  </span>
                </a>
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
