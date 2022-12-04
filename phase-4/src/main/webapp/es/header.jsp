<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<%
    String userAID = null;
    if(session.getAttribute("userAid") != null){
    	userAID = (String) session.getAttribute("userAid");
    }
    UserDAO userDAO = new UserDAO();
    int point = userDAO.getPoint(userAID);
   %>
   <nav class="nav">
   	<a class="main" href="main.jsp">UniBus</a>
	<ul>
		<li class="auth">
			<!-- <a href="./admin/admin.jsp">Administrator</a> --> <% if(userAID == null){
			%>
			<a href="login.jsp">Iniciar Sesión</a>
			<a href="signup.jsp">Registrarse</a> <% } else{ %>
			<p><b><%= point %></b> pts</p>
			<a href="myReservation.jsp">Mis Reservas</a>
		  	<a href="logoutAction.jsp">Cerrar Sesión</a>
		   <% } %>
		</li>
     </ul>
</nav>