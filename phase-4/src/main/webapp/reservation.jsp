<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
<title>reservation</title>
</head>
<body>
	<form method="post" action="">
		<div>
			<%
				ReservationDAO reserveDAO = new ReservationDAO();
			
				String rtid = request.getParameter("rtid");
				String depart = request.getParameter("depart");
				String arrive = request.getParameter("arrive");
				String ddate = request.getParameter("ddate");
				String dtime = request.getParameter("dtime");
				
				ArrayList<Reservation> list = reserveDAO.getSeat(rtid, depart, arrive, ddate, dtime);
				
				for(int i = 0; i < list.size(); i++){
				%>
					<input type="checkbox" id = <%= list.get(i).getRsid() %> name = "seat" value = <%= list.get(i).getRsid() %>/><%= list.get(i).getRsid() %>		
				<%
					}
				%>
			<input type="submit" value="reserve">
		</div>  
	</form>
</html>