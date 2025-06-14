<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles/style.css">
</head>
<body>
<div class="error-box">
    <h1 class="error">Errore!</h1>
    <%
        String error = request.getParameter("err");
        if (error.equals("login")) {
            out.print("<h2 class=\"error\">Errore, login non valido.</br>Nome utente o password non validi</h2>");
        }
        if (error.equals("registration")) {
            out.print("<h2 class=\"error\">Errore, registrazione non valida.</br>Nome utente gia' usato</h2>");
        }
    %>
    <a href="<%= request.getContextPath() %>/login.jsp" class="login-anchor">Login</a>
</div>
	
</body>
</html>