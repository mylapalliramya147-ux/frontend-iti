<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>:: ITI ::</title>
</head>
<body style="margin:0;background:#fff">
<div style="width:100%;height:100vh;display:flex;align-items:center;justify-content:center;font-family:Verdana,Arial,sans-serif">
    <div style="text-align:center">
        <c:if test="${empty roleId}">
            <p>Login successful.</p>
        </c:if>
        <c:if test="${not empty roleId}">
            <p>Login successful. Role ID: <strong>${roleId}</strong></p>
            <p>Username: <strong>${sessionScope.username}</strong></p>
            <p>ITI: <strong>${sessionScope.itiName}</strong></p>
        </c:if>
    </div>
</div>
</body>
</html>