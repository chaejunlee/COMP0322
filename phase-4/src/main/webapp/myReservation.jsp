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
<title>My Reservation :: UNI-BUS</title>
</head>
<body>
<jsp:include page="header.jsp" />
<h1 class="px-1">My Reservations</h1>
<main class="px-1">
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
		<div class="flex border" style="margin-top: 1.5rem;">
			<h2 class="bg-primary px-1 py-05"> 🚐 Trip on <%= reserveList.get(i).getDdate().substring(0, 10) %></h2>
			
			<div class="grid-3 px-1">
				<div>
					<h3>Bus ID</h3>
					<p class="emphasize"><%= reserveList.get(i).getBid() %></p>
				</div>
				<div>
					<h3>Seat ID</h3>
					<p class="emphasize"><%= reserveList.get(i).getSid() %></p>
				</div>
				<div>
					<h3>Reserved Age</h3>
					<p class="emphasize"><%= reserveList.get(i).getAge() %></p>
				</div>
			</div>
			
			<div class="grid-3 px-1">
				<div>
					<h3>Departing Time</h3>
					<p class="emphasize"><%= reserveList.get(i).getDtime().substring(11, 16) %></p>
				</div>
				<div>
					<h3>Departing Station</h3>
					<p class="emphasize"><%= reserveList.get(i).getDstation() %></p>
				</div>
				<div>
					<h3>Departing Platform</h3>
					<p class="emphasize">No. <%= reserveList.get(i).getDplatform() %></p>
				</div>
			</div>
			
			<div class="grid-3 px-1">
				<div>
					<h3>Arriving Time</h3>
					<p class="emphasize"><%= reserveList.get(i).getAtime().substring(11, 16) %></p>
				</div>
				<div>
					<h3>Arriving Station</h3>
					<p class="emphasize"><%= reserveList.get(i).getAstation() %></p>
				</div>
				<div>
					<h3>Arriving Platform</h3>
					<p class="emphasize">No. <%= reserveList.get(i).getAplatform() %></p>
				</div>
			</div>
			
			<div style="display: flex; justify-content: flex-end;" class="px-1 py-1"><a class="btn-sm" href="cancelAction.jsp?sid=<%= reserveList.get(i).getSid() %>&tid=<%= reserveList.get(i).getTid() %>&aid=<%= userAID %>">Cancel Reservation</a></div>
		</div>
	<%
		}	
	%>
	</div>
</main>
<jsp:include page="footer.jsp" />
</body>
</html>