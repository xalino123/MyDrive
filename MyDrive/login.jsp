<%@ page session="true" %>
<%@ page import="it.Login" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="styles/style.css">
    <script type="text/javascript" src="scripts/utils.js"></script>
</head>
<body>
<div class="login-form">
    <form action="Login" method="post" onsubmit="return validateAndSubmit(this)">
        <h2 class="text-center">Login</h2>
        <div class="form-group">
            <input type="text" class="form-control" placeholder="Username" required="required" name="username">
        </div>
        <div class="form-group">
            <input type="password" class="form-control" placeholder="Password" required="required" name="password">
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-primary btn-block">Log in</button>
            Non hai un account? <a href=<%=request.getContextPath()%>/registration.jsp class="login-anchor">Registrati qui</a>
        </div>
    </form>
</div>
</body>
</html>
