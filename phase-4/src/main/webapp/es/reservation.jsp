<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<jsp:setProperty name="reservation" property="raid" />
<jsp:setProperty name="reservation" property="rsid" />
<jsp:setProperty name="reservation" property="rtid" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="style.css" />
<title>Reservas :: UniBus</title>
</head>
<body>
    <jsp:include page="header.jsp" />
	<%
		String rtid = request.getParameter("rtid");
		String depart = request.getParameter("depart");
		String arrive = request.getParameter("arrive");
		String ddate = request.getParameter("ddate");
		String dtime = request.getParameter("dtime");
	%>
	<h1 class="px-1">Asientos Disponibles</h1>
	<form method="get" action="reservationAction.jsp">
		<div class="row-span grid-3 py-1">
			<div>
				<label for="adult">Adultos <span class="label-sm">Mayor de 18 años</span></label>
				<input type="number" min="0"  id = "adult" name = "adult" value="0">
			</div>
			<div>
				<label for="teenage">Adolescentes <span class="label-sm">entre 10 ~ 18 años</span></label>
				<input type="number" min="0"  id = "teenager" name = "teenager" value="0">
			</div>
			<div>
				<label for="child">Niños <span class="label-sm">menores de 9 años</span></label>
				
				<input type="number" min="0" id = "child" name = "child" value="0">
			</div>
			
			
		</div>
	
		<div class="bus-grid row-span">
		<%
			ReservationDAO reserveDAO = new ReservationDAO();
			ArrayList<Reservation> list = reserveDAO.getSeat(rtid, depart, arrive, ddate, dtime);
			
			boolean arr[][] = new boolean[4][10];
			
			String row[] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"};
			
			for(int a = 0; a < arr.length; a++){
			    for(int b = 0; b < arr[a].length; b++){
			        arr[a][b] = false;
			    }
			}
		
			for(int i = 0; i < list.size(); i++){
				String seats = list.get(i).getRsid();
				// out.println(seats);
				if (seats.contains("A")) {
					arr[seats.charAt(1) - '1'][0] = true;
				} else if (seats.contains("B")) {
					arr[seats.charAt(1) - '1'][1] = true;
				} else if (seats.contains("C")) {
					arr[seats.charAt(1) - '1'][2] = true;
				} else if (seats.contains("D")) {
					arr[seats.charAt(1) - '1'][3] = true;
				} else if (seats.contains("E")) {
					arr[seats.charAt(1) - '1'][4] = true;
				} else if (seats.contains("F")) {
					arr[seats.charAt(1) - '1'][5] = true;
				} else if (seats.contains("G")) {
					arr[seats.charAt(1) - '1'][6] = true;
				} else if (seats.contains("H")) {
					arr[seats.charAt(1) - '1'][7] = true;
				} else if (seats.contains("I")) {
					arr[seats.charAt(1) - '1'][8] = true;
				} else if (seats.contains("J")) {
					arr[seats.charAt(1) - '1'][9] = true;
				}
			}
			
			out.println("<div></div>");
			
			for (int i = 0; i < 10; i++)
				out.println("<div class=\"head\">" + row[i] + "</div>");
			
			for(int a = 0; a <= 3; a++) {
				out.println("<div class=\"head item\">" + (a + 1) + "</div>");
					
			    for(int b = 0; b < 10; b++) {
					String seat = row[b] + Integer.toString(a + 1);
		%>
			<div class="item">
				<input
					type="checkbox"
					class="seat"
					style="display: grid; place-items: center;"
					<% out.println((arr[a][b] ? "" : "disabled") + " id=" + seat + " value=" + seat); %>
					name="sid"
				>
			</div>
			
		<%
			    }
			}
		%>
		</div>
		
		<input type="hidden" id="tid" name="tid" value=<%= rtid %>>
		<input type="hidden" id="depart" name="depart" value=<%= depart %>>
		<input type="hidden" id="arrive" name="arrive" value=<%= arrive %>>
		<input type="hidden" id="ddate" name="ddate" value=<%= ddate %>>
		<input type="hidden" id="dtime" name="dtime" value=<%= dtime %>>
			
		<div class="py-1 row-span">
			<input class="btn" type="submit" value="Confirmar">
		</div>		
	</form>
</html>