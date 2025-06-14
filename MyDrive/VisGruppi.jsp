<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="java.util.*"%>
<%@ page import="beans.Utente" %>
<%@ page import="it.FileSystemManager" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="user" class="beans.Utente" scope="session"/>

<html>
<head>
    <title>Gruppi</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="styles/style.css">
    <script type="text/javascript" src="scripts/utils.js"></script>
</head>

	<%
	    if(session.getAttribute("logged")==null || session.getAttribute("logged").equals(false))
	        response.sendRedirect(request.getContextPath()+"/login.jsp");
	%>
	
<body>
	<div id="groupsList">
		<form action="HomeGruppo.jsp" method="post">
	        <h2 class="text-center">I tuoi gruppi</h2>
	        <%for(String groupName : user.getGruppi().keySet()){%>
	        <div class="form-group">
	        	Nome: <%= groupName %> Ruolo: <%=user.getGruppi().get(groupName)%>
	            <button type="submit" class="createGroupButton" name="groupName" value="<%=groupName%>">Visualizza</button>
	        </div>
	        <%}if(user.getGruppi().isEmpty()){%>
	        	<div class="form-group">
	        		<h3>Non hai nessun gruppo.</h3>
	        	</div>
	        <%} %>
    	</form>
    	<form action="HomeGruppo.jsp" method="post" onsubmit="return validateAndSubmit(this)">
    		<div class="form-group">
	        	<input type="text" class="form-control" placeholder="Nome Gruppo" required="required" name="groupName">
	            <button type="submit" class="createGroupButton" name="action" value="createNewGroup">Crea un gruppo</button>
	        </div>
    	</form>
	</div>
	<a href=<%=request.getContextPath()%>/index.jsp class="principal-anchor">Home</a>
</body>
</html>

