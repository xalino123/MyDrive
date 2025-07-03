<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="java.util.*"%>
<%@ page import="beans.Utente" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="user" class="beans.Utente" scope="session"/>

<html>
<head>
    <title>Home page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="styles/style.css">
    <script type="text/javascript" src="scripts/utils.js"></script>
    <script type="text/javascript" src="scripts/scripts.js"></script>
</head>

	<%
	    if(session.getAttribute("logged")==null || session.getAttribute("logged").equals(false))
	        response.sendRedirect(request.getContextPath()+"/login.jsp");
	%>
	
<body>
    <h2>Benvenuto alla pagina principale <%=user.getUsername()%>!</h2>	
	<div id="main">
		<a href=<%=request.getContextPath()%>/VisInviti.jsp class="principal-anchor">Inviti</a>
		<br/>
		<a href=<%=request.getContextPath()%>/VisGruppi.jsp class="principal-anchor">Gruppi</a>
		<br/><br/>
		<a href=<%=request.getContextPath()%>/login.jsp class="login-anchor">Login</a>
	</div>
</body>
</html>

