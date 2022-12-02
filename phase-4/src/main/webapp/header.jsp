<%@ page import="user.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
   	<a class="main" href="main.jsp">UNI-BUS</a>
	<ul>
		<li class="auth">
			<a href="./admin/admin.jsp">Administrator</a> <% if(userAID == null){
			%>
			<a href="login.jsp">Sign In</a>
			<a href="signup.jsp">Sign Up</a> <% } else{ %>
			<p><%= point %> pts</p>
			<a href="myReservation.jsp">My Reservations</a>
		  	<a href="logoutAction.jsp">Sign Out</a>
		   <% } %>
		</li>
     </ul>
</nav>