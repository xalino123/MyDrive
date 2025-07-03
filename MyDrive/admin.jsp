<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="it.S1"%>
<%@ page import="java.util.*"%>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="beans.Utente" %>

<html>
<head>
    <title>Admin Page</title>
</head>
<%//Eseguo nuovamente il controllo di username e pass
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    if(username==null || password == null)
		request.getRequestDispatcher("/login.jsp").forward(request, response);
    else
    	if (!username.equals("admin") || !password.equals("admin"))
			request.getRequestDispatcher("/login.jsp").forward(request, response);
%>

<%
	Integer numReqAdmin;
	numReqAdmin = (Integer) session.getAttribute("numReqAdmin");
	
	if(numReqAdmin != null){
		//numReqAdmin = Integer.parseInt(numReqAdminAttribute)+1;
		numReqAdmin = numReqAdmin+1;
	}else{
		numReqAdmin=1;	
	}
	
	session.setAttribute("numReqAdmin", numReqAdmin);
%>

<body>
<h2>Pagina di amministrazione</h2>
<a href="<%=request.getContextPath()%>/index.jsp">Applicazione</a> <br/>

Num richieste da admin in questa sesisone: <%=numReqAdmin %> <br/>

<%
	int totReqCount=0;
	List<Utente> utenti = (List<Utente>) application.getAttribute("utenti");
	for (Utente utente : utenti) {
		List<Instant> list = utente.getRequestList();
		for(Instant istant : list){
			if(istant.until(Instant.now(), ChronoUnit.MINUTES)<60){
				totReqCount++;
			}else{
				list.remove(istant);
			}
		}
		utente.setRequestList(list);	
	}
	application.setAttribute("utenti", utenti);
%>
Numero totali di richieste negli ultimi 60 minuti: <%=totReqCount %>

</body>
</html>
