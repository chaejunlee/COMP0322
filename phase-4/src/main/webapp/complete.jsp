<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<jsp:setProperty name="reservation" property="rsid" />
<jsp:setProperty name="reservation" property="rtid" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Complete Reservation</title>
</head>
<body>
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		
		int price = Integer.valueOf(request.getParameter("fee"));
		String tid = request.getParameter("rtid");
		String sid = request.getParameter("rsid");
		String age = request.getParameter("rage");

		ReservationDAO reserveDAO = new ReservationDAO();
		int result = reserveDAO.completeReserve(reservation, userAID, tid, sid, age, price);
		
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Server Error')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Not enough points to book.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}		
		else if(result == 2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('The seat has already been reserved')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Reserved Successfully')");
			script.println("location.href = 'myReservation.jsp'");
			script.println("</script>");
		}
		
	%>
	
</body>
</html>