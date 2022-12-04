<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="user.UserDAO" %>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Detalles de Reserva :: UniBus</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		
		if(userAID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('¡Inicia sesión primero!')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
		String[] rsid = request.getParameterValues("sid");
		String age = request.getParameter("child") + request.getParameter("teenager") + request.getParameter("adult");
		
		ReserveInfoDAO reserveDAO = new ReserveInfoDAO();
		ReservationInfo info = reserveDAO.getReserve(reserveinfo, rsid, age);
	%>

	<h1 class="px-1">Detalles de Reserva</h1>
	<main class="mx-auto max-w px-1 py-1">
	<div class="border flex">
		<div class="bg-primary px-1 py-05"><h2>🎫 Información</h2></div>
		<div class="grid-3 px-1 py-1 gap-1">
			<div>
				<h3>fecha</h3>
				<div class="emphasize"><%= info.getDdate() %></div>
			</div>
			
			<div>
				<h3>hora de salida</h3>
				<div class="emphasize"><%= info.getDtime() %></div>
			</div>
			
			<div>
				<h3>estación de salida</h3>
				<div class="emphasize"><%= info.getDepart() %></div>
			</div>
			<div>
				<h3>estación de llegada</h3>
				<div class="emphasize"><%= info.getArrive() %></div>
			</div>
			
			<div>
				<h3>número de asiento</h3>
				<div class="emphasize"><%= info.getSid() %></div>
			</div>
			
			<div>
				<h3>precio</h3>
				<div class="emphasize"><%= info.getPrice() %></div>
			</div>
		</div>
	</div>
	<div class="grid-2 gap-1 py-1">
		<div class="btn blank">
			<a href="reservation.jsp?rtid = <%= info.getTid() %>&depart=<%= info.getDepart() %>&arrive=<%= info.getArrive() %>&ddate=<%= info.getDdate() %>&dtime=<%= info.getDtime() %>" style="width: auto; color: inherit; text-decoration: none;" value="back">Volver</a>	
		</div>
		<div class="btn">
			<a href="complete.jsp?fee=<%= info.getPrice() %>&rtid=<%= info.getTid() %>&rsid=<%= info.getSid() %>&rage=<%= info.getAge() %>" style="width:auto; color: inherit; text-decoration: none;" value="reserve">Reservar</a>
		</div>
	</div>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>