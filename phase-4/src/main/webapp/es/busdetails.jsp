<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="user.UserDAO" %>
<%@ page import="busdetails.Busdetails"%>
<%@ page import="busdetails.Busfee"%>
<%@ page import="busdetails.BusDAO"%>
<%@ page import="java.util.ArrayList"%>

<%
String tid = request.getParameter("tid");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Detalles de Autobús :: UniBus</title>
</head>
<body>
<jsp:include page="header.jsp" />

<h1 class="px-1">Detalles de Autobús</h1>
<main class="mx-auto max-w px-1 py-2">
<%
	BusDAO details = new BusDAO();
	ArrayList<Busdetails> list = details.getDetails(tid);
%>
	<div class="border flex">
		<div class="bg-primary px-1 py-05"><h2>💵&nbsp; INFO</h2></div>
		<div class="grid-3 px-1 py-1 gap-1">
			<div>
				<h3>Edad</h3>
				<%
					ArrayList<Busfee> list1 = details.getFee(tid);
					for (int i = 0; i < list1.size(); i++) {
						out.println("<div class=\"emphasize\">" + list1.get(i).getAge() + "</div>");
					}
				%>
			</div>
			<div>
				<h3>Tarifa</h3>
				<%
					for (int i = 0; i < list1.size(); i++) {
						out.println("<div class=\"emphasize\">" + list1.get(i).getFee() + "</div>");
					}		
				%>
			</div>
		</div>
	</div>
	<div class="border flex" style="margin-top: 2rem;">
		<div class="bg-primary px-1 py-05"><h2>🚌&nbsp; INFO</h2></div>
		<div class="grid-3 px-1 py-1 gap-1">
			<%
				for (int i = 0; i < list.size(); i++) {
			%>
				<div>
					<h3>NÚMERO DE AUTOBÚS</h3>
					<div class="emphasize"><%=list.get(i).getBid()%></div>
				</div>
				
				<div>
					<h3>hora prevista</h3>
					<div class="emphasize"><%=list.get(i).getDiff_mi()%> min</div>
				</div>
				
				<div>
					<h3>clase de autobús</h3>
					<div class="emphasize"><%=list.get(i).getBtype()%></div>
				</div>
				
				<div>
					<h3>empresa de autobuses</h3>
					<div class="emphasize" style="text-transform: capitalize;"><%=list.get(i).getBcompany()%></div>
				</div>
				
				<div>
					<h3>Conductor(a)</h3>
					<div class="emphasize"><%=list.get(i).getFname()%> <%=list.get(i).getLname()%></div>
				</div>
			<%
				}
			%>
		</div>
	</div>
</main>
<jsp:include page="footer.jsp" />
</body>
</html>