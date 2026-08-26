<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ITI MIS - Home</title>
    <style>
        body { margin: 0; background: #ffffff; font-family: Arial, Verdana, sans-serif; }
        .welcome { text-align: center; margin-top: 18%; }
        .welcome h1 { color: #333; font-weight: normal; }
        .welcome p { color: #666; }
        .welcome a { color: #0645ad; text-decoration: none; }
    </style>
</head>
<body>
    <div class="welcome">
        <h1>Welcome! Your role ID is: <strong>${roleId}</strong></h1>
        <p>Logged in as: ${username} (${fullName})</p>
        <p><a href="${pageContext.request.contextPath}/logout">Logout</a></p>
    </div>
</body>
</html>
