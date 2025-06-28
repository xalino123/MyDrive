<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="java.util.*"%>
<%@ page import="beans.Utente" %>
<%@ page import="it.GroupManager" %>
<%@ page import="it.FileSystemManager" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="user" class="beans.Utente" scope="session"/>

<html>
<head>
    <title>Inviti</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="styles/style.css">
    <script type="text/javascript" src="scripts/utils.js"></script>
    <script type="text/javascript" src="scripts/scripts.js"></script>
</head>

	<%
	    if(session.getAttribute("logged")==null || session.getAttribute("logged").equals(false))
	        response.sendRedirect(request.getContextPath()+"/login.jsp");
	
		String groupToJoin = request.getParameter("accept");
		if(groupToJoin!=null){
			user.getInviti().remove(groupToJoin);
			FileSystemManager.GetInstance().saveUser(user);
			GroupManager.GetInstance().addUserToGroup(groupToJoin, user.getUsername());
		}
		String groupToRefuse = request.getParameter("refuse");
		if(groupToRefuse!=null){
			user.getInviti().remove(groupToRefuse);
			FileSystemManager.GetInstance().saveUser(user);
		}
	%>
	
<body>
	<div id="groupsList">
	<table id="basic-list">
		<form action="VisInviti.jsp" method="post">
	        <h2 class="text-center">I tuoi inviti</h2>
	        <%if(!user.getInviti().isEmpty()){%>
	        <tr>
	        	<th>Nome gruppo</th>
	        	<th>Mittente</th>
	        	<th></th>
	        	<th></th>
	        </tr>
	        <%for(String groupName : user.getInviti().keySet()){%>
	        <tr>
	        	<td><%= groupName %></td>
	        	<td><%=user.getInviti().get(groupName)%></td>
	        	<td><button type="submit" class="promoteButton" name="accept" value="<%=groupName%>">Accetta</button></td>
	        	<td><button type="submit" class="removeUserButton" name="refuse" value="<%=groupName%>">Rifiuta</button></td>
	        </tr>
	        <%}}else{%>
	        	<div class="form-group">
	        		<h3>Non hai nessun invito.</h3>
	        	</div>
	        <%} %>
    	</form>
    </table>
	</div>
	<a href=<%=request.getContextPath()%>/index.jsp class="principal-anchor">Home</a>
</body>
</html>

