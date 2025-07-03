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
    <title>Home gruppo</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="styles/style.css">
    <script type="text/javascript" src="scripts/utils.js"></script>
</head>

	<%
	    if(session.getAttribute("logged")==null || session.getAttribute("logged").equals(false))
	        response.sendRedirect(request.getContextPath()+"/login.jsp");
		
		String action = request.getParameter("action");
		String groupName = request.getParameter("groupName");
		
		if(action!=null){
			if(action.equals("createNewGroup")){
				GroupManager.GetInstance().createNewGroup(groupName, user.getUsername());
			}
			if(action.equals("inviteUser")){
				String inviteUsername = request.getParameter("inviteUsername");
				Utente userToInvite = FileSystemManager.GetInstance().getUser(inviteUsername);
				if(userToInvite!=null){
					userToInvite.getInviti().put(groupName, user.getUsername());
					FileSystemManager.GetInstance().saveUser(userToInvite);	
				}
			}
		}else{
			String userToPromote = request.getParameter("promote");
			if(userToPromote!=null){
				GroupManager.GetInstance().promoteUser(groupName, userToPromote);
			}
			String userToRemove = request.getParameter("remove");
			if(userToRemove!=null){
				GroupManager.GetInstance().removeUserFromGroup(groupName, userToRemove);
			}
		}
		
		request.getSession().setAttribute("user", FileSystemManager.GetInstance().getUser(user.getUsername()));
		boolean userIsHost = GroupManager.GetInstance().getUserRole(groupName,user.getUsername()).equals("host");
	%>
	
<body class="horizzontalBody">
	<div id="memberList">
		<table id="basic-list">
		<form action="HomeGruppo.jsp" method="post">
	        <h3 class="text-center">Membri</h3>
	        <input type="hidden" name="groupName" value="<%=groupName%>"/>
	        <tr>
	        	<th>nome</th>
	        	<th>ruolo</th>
	        	<%if(userIsHost){ %>
	        		<th></th><th></th>
	        	<%} %>
	        </tr>
	        <%
	        for(String memberUsername : GroupManager.GetInstance().getGroupMembers(groupName).keySet()){%>
	        	<tr>
	        	<td><%= memberUsername %></td>
	        	<td><%=GroupManager.GetInstance().getGroupMembers(groupName).get(memberUsername)%></td>
	            <%if(userIsHost&&!memberUsername.equals(user.getUsername())){%>
	            	<td><button type="submit" class="promoteButton" name="promote" value="<%=memberUsername%>">Promuovi</button></td>
	        		<td><button type="submit" class="removeUserButton" name="remove" value="<%=memberUsername%>">Rimuovi</button></td>
	        		<%}%>
	        	</tr>
	        <%}%>
    	</form>
    	</table>
    	
    	<form action="HomeGruppo.jsp" method="post" onsubmit="return validateAndSubmit(this)">
    		<div class="form-group">
    		<%if(userIsHost){%>
    			<input type="hidden" name="groupName" value="<%=groupName%>"/>
	        	<input type="text" class="form-control" id="inviteInput" placeholder="Nome Utente" required="required" name="inviteUsername">
	            <button type="submit" class="createGroupButton" name="action" value="inviteUser">Invita</button>
	        	</br>
	        <%} %>
	        	<a href=<%=request.getContextPath()%>/VisGruppi.jsp class="principal-anchor">Gruppi</a>
	        </div>
    	</form>
    	<form action="VisGruppi.jsp" method="post">
    		<%if(userIsHost){%>
    			<input type="hidden" name="groupName" value="<%=groupName%>"/>
    			<button type="submit" class="removeUserButton" name="action" value="deleteGroup">Elimina gruppo</button>
    		<%}else{ %>
    			<input type="hidden" name="groupName" value="<%=groupName%>"/>
    			<button type="submit" class="removeUserButton" name="action" value="exitFromGroup">Esci</button>
    		<%} %>
    	</form>
	</div>
	<div id="mainGroup">
		<h2 class="text-center"><%=groupName%></h2>
		<div class="border">
		<form action="GroupDiskServlet" method="post" enctype="multipart/form-data">
			<input type="hidden" name="groupName" value="<%=groupName%>"/>
			<label for="myfile">Carica file:</label>
			<input type="file" id="myfile" name="myfile" multiple> <button type="submit" class="createGroupButton">Invia</button>
		</form>
		</div>
		
		<div>
		<table id="file-list">
			<h3 class="text-center">File caricati:</h3><br/><br/>
			<%
				Map<String,String> fileList;
				fileList = GroupManager.GetInstance().getFilesMapInDisk(groupName);
				if(!fileList.isEmpty()){%>
			<tr>
				<th>nome</th>
				<th>dimenzioni</th>
				<th></th>
				<%if(userIsHost){%>
					<th></th>
				<%}%>
			</tr>
			<%
			
				for(String fileName : fileList.keySet()){
					%>
					<tr>
					<form action="GroupDiskServlet" method="get">
						<td><%=fileName%></td>
						<td><%=fileList.get(fileName)%> MB</td>
						<input type="hidden" name="groupName" value="<%=groupName%>"/>
						<input type="hidden" name="fileName" value="<%=fileName%>"/>
						<td id="table-align-center"><button type="submit" name="action" value="download" class="fileButton">
						    <img class="fileButton" src="images/download.png" width="32" height="32" alt="Download">
						</button></td><%
						if(userIsHost){
							%><td id="table-align-center"><button type="submit" name="action" value="delete" class="fileButton">
							    <img class="fileButton" src="images/delete.png" width="32" height="32" alt="Delete">
							</button></td><%
						}%>
					</form>
					</tr>
				<%}}else{%>
					<p>Lo spazio condiviso è vuoto, carica dei file!</p>
				<%}%>
		</table>
		</div>
	</div>
</body>
</html>

