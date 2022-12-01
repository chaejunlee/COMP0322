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
	<%
		String rtid = request.getParameter("rtid");
		String depart = request.getParameter("depart");
		String arrive = request.getParameter("arrive");
		String ddate = request.getParameter("ddate");
		String dtime = request.getParameter("dtime");
	%>
	<form method="get" action="reservationAction.jsp">
		<div>
				어린이(9세이하): <input type="text" id = "child" name = "child" value="0"></p>
				청소년(10~18세): <input type="text" id = "teenager" name = "teenager" value="0"></p>
				어른(19세 이상): <input type="text" id = "adult" name = "adult" value="0"></p>
				<%
					ReservationDAO reserveDAO = new ReservationDAO();
					ArrayList<Reservation> list = reserveDAO.getSeat(rtid, depart, arrive, ddate, dtime);
				
					for(int i = 0; i < list.size(); i++){
				%>
					<input type="checkbox" id = <%= list.get(i).getRsid() %> name = "sid" value = <%= list.get(i).getRsid() %>><%= list.get(i).getRsid() %>
				<%
					}
				%>
					<input type="hidden" id="tid" name="tid" value=<%= rtid %>>
					<input type="hidden" id="depart" name="depart" value=<%= depart %>>
					<input type="hidden" id="arrive" name="arrive" value=<%= arrive %>>
					<input type="hidden" id="ddate" name="ddate" value=<%= ddate %>>
					<input type="hidden" id="dtime" name="dtime" value=<%= dtime %>>					
			<input type="submit" value="confirm">
		</div>  
	</form>
</html>