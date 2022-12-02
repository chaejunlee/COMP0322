<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<jsp:setProperty name="reservation" property="rsid" />
<jsp:setProperty name="reservation" property="rtid" />
<jsp:setProperty name="reservation" property="rtid" />
<jsp:setProperty name="reservation" property="rage" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>complete</title>
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
			script.println("alert('server error')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('no money.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('success')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}		
	%>
	
</body>
</html>