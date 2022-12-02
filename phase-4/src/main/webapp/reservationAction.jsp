<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReserveInfoDAO" %>
<%@ page import="reservation.ReservationInfo" %>
<jsp:useBean id="reserveinfo" class="reservation.ReservationInfo" scope="page" />
<jsp:setProperty name="reserveinfo" property="tid" />
<jsp:setProperty name="reserveinfo" property="depart" />
<jsp:setProperty name="reserveinfo" property="arrive" />
<jsp:setProperty name="reserveinfo" property="sid" />
<jsp:setProperty name="reserveinfo" property="ddate" />
<jsp:setProperty name="reserveinfo" property="dtime" />
<jsp:setProperty name="reserveinfo" property="child" />
<jsp:setProperty name="reserveinfo" property="teenager" />
<jsp:setProperty name="reserveinfo" property="adult" />
<jsp:setProperty name="reserveinfo" property="price" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login action page</title>
</head>
<body>
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		if(userAID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후 이용해주세요')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		String[] rsid = request.getParameterValues("sid");		
		
		ReserveInfoDAO reserveDAO = new ReserveInfoDAO();
		ReservationInfo info = reserveDAO.getReserve(reserveinfo, rsid);
	%>

	<p>예약정보></p>
	<table border="1">
		<tr>
			<th>date</th>
			<th>depart time</th>
			<th>depart station</th>
			<th>arrive station</th>
			<th>seat number</th>
			<th>price</th>
		</tr>
		<tr>
			<td><%= info.getDdate() %></td>
			<td><%= info.getDtime() %></td>
			<td><%= info.getDepart() %></td>
			<td><%= info.getArrive() %></td>
			<td><%= info.getSid() %></td>
			<td><%= info.getPrice() %></td>
		<tr>
	</table>
	<a href="complete.jsp?fee=<%= info.getPrice() %>&rtid=<%= info.getTid() %>&rsid=<%= info.getSid() %>" value="reserve">reserve</a>
</body>
</html>