<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="reservation.MyTicket" %>
<%@ page import="reservation.ReservationDAO" %>
<jsp:useBean id="reservation" class="reservation.MyTicket" scope="page" />

<!DOCTYPE html>
<html>
<head>
<title>myReservation</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>Date</th>
			<th>Depart Time</th>
			<th>Arrive Time</th>
			<th>Depart station</th>
			<th>Depart Platform</th>
			<th>Arrive station</th>
			<th>Arrive Platform</th>
			<th>Bus ID</th>
			<th>Seat ID</th>
			<th>Age</th>
			<th>Cancel</th>
		</tr>
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
		<tr>
			<td><%= reserveList.get(i).getDdate().substring(0, 10) %></td>
			<td><%= reserveList.get(i).getDtime().substring(11, 16) %></td>
			<td><%= reserveList.get(i).getAtime().substring(11, 16) %></td>
			<td><%= reserveList.get(i).getDstation() %></td>
			<td><%= reserveList.get(i).getDplatform() %></td>
			<td><%= reserveList.get(i).getAstation() %></td>
			<td><%= reserveList.get(i).getAplatform() %></td>
			<td><%= reserveList.get(i).getBid() %></td>
			<td><%= reserveList.get(i).getSid() %></td>
			<td><%= reserveList.get(i).getAge() %></td>
			<td><a href="cancelAction.jsp?sid=<%= reserveList.get(i).getSid() %>&tid=<%= reserveList.get(i).getTid() %>&aid=<%= userAID %>">취소하기</a></td>
		</tr>
	<%
		}	
	%>
	</table>
</body>
</html>