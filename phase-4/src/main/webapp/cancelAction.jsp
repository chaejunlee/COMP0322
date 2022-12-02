<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cancel reservation</title>
</head>
<body>
	<%
		String sid = request.getParameter("sid");
		String tid = request.getParameter("tid");	
		String aid = request.getParameter("aid");	
		
		ReservationDAO reserve = new ReservationDAO();

		
		String sql = "DELETE FROM RESERVATION WHERE RSID = ? AND RTID = ?";
		
		try{
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>