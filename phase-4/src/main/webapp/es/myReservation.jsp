<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="reservation.MyTicket" %>
<%@ page import="reservation.ReservationDAO" %>
<jsp:useBean id="reservation" class="reservation.MyTicket" scope="page" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="style.css" />
<title>Mis Reservas :: UniBus</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 class="px-1">Mis Reservas</h1>
<main class="mx-auto max-w px-1 py-2">
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		
		ArrayList <MyTicket> reserveList;
		ReservationDAO ticketDAO = new ReservationDAO();
		reserveList = ticketDAO.getReservation(userAID);
		
		for(int i = 0; i < reserveList.size(); i++){
	%>
		<div class="flex border" style="margin-bottom: 1rem;">
			<h2 class="bg-primary px-1 py-05"> 🚐&nbsp; Viaje en <%= reserveList.get(i).getDdate().substring(0, 10) %></h2>
			
			<div class="grid-3 px-1 py-1 gap-1">
				<div>
					<h3>Número de autobús</h3>
					<p class="emphasize"><%= reserveList.get(i).getBid() %></p>
				</div>
				<div>
					<h3>Número de asiento</h3>
					<p class="emphasize"><%= reserveList.get(i).getSid() %></p>
				</div>
				<div>
					<h3>Edad</h3>
					<p class="emphasize"><%= reserveList.get(i).getAge() %></p>
				</div>

				<div>
					<h3>Hora de Salida</h3>
					<p class="emphasize"><%= reserveList.get(i).getDtime().substring(11, 16) %></p>
				</div>
				<div>
					<h3>Estación de Salida</h3>
					<p class="emphasize"><%= reserveList.get(i).getDstation() %></p>
				</div>
				<div>
					<h3>Plataforma de Salida</h3>
					<p class="emphasize">Nº <%= reserveList.get(i).getDplatform() %></p>
				</div>

				<div>
					<h3>Hora de Llegada</h3>
					<p class="emphasize"><%= reserveList.get(i).getAtime().substring(11, 16) %></p>
				</div>
				<div>
					<h3>Estación de Llegada</h3>
					<p class="emphasize"><%= reserveList.get(i).getAstation() %></p>
				</div>
				<div>
					<h3>Plataforma de Llegada</h3>
					<p class="emphasize">Nº <%= reserveList.get(i).getAplatform() %></p>
				</div>
			</div>
			
			<div style="display: flex; justify-content: flex-end; padding-top: 0;" class="px-1 py-1"><a class="btn-sm" href="cancelAction.jsp?rsid=<%= reserveList.get(i).getSid() %>&rtid=<%= reserveList.get(i).getTid() %>&rage=<%= reserveList.get(i).getAge() %>&raid=<%= userAID %>">Cancelar la Reserva</a></div>
		</div>
	<%
		}	
	%>
	</div>
</main>
<jsp:include page="footer.jsp" />
</body>
</html>