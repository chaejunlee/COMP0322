<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<jsp:setProperty name="reservation" property="rsid" />
<jsp:setProperty name="reservation" property="rtid" />
<jsp:setProperty name="reservation" property="rage" />
<jsp:setProperty name="reservation" property="raid" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel Reservation :: UNI-BUS</title>
</head>
<body>
	<%		
		String age = request.getParameter("rage");
		
		if (age.equals("18 ")){
			reservation.setRage("18+");
		}
		
		ReservationDAO reserve = new ReservationDAO();
		int result = reserve.cancelReservation(reservation);
	
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('complete cancel')");
			script.println("location.href = 'myReservation.jsp'");
			script.println("</script>");
		}
		else if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('server error. fail to cancel')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (result == 2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('the reservation has been already canceled')");
			script.println("history.back()");
			script.println("</script>");
		}

	%>
</body>
</html>