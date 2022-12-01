<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="businfo.BusDAO" %>
<%@ page import="businfo.Businfo" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="businfo" class="businfo.Businfo" scope="page" />
<jsp:setProperty name="businfo" property="dstation" />
<jsp:setProperty name="businfo" property="astation" />
<jsp:setProperty name="businfo" property="ddate" />
<jsp:setProperty name="businfo" property="time" />
<jsp:setProperty name="businfo" property="tid" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="style.css" />
	<title>Routes</title>
</head>
	<body>
		<%
			String userAID = null;
			if(session.getAttribute("userAid") != null){
				userAID = (String) session.getAttribute("userAid");
			}
		%>
		<div>
			<ul>
				<li><a href="main.jsp">main page</a>
		<%
			if(userAID == null){
		%>
				<li><a href="login.jsp">login</a>
				<li><a href="signup.jsp">sign up</a>
		<%
			} else{
		%>
			<li><a href="myReservation.jsp">myReservation</a>
			<li><a href="logoutAction.jsp">logout</a>
		<%
			}
		%>
			</ul>
		</div>
		<h1>Routes</h1>
		<div class="title">
			<span class="place depart">Dongdaegu</span>
			<svg
			  xmlns="http://www.w3.org/2000/svg"
			  fill="none"
			  viewBox="0 0 24 24"
			  stroke-width="3"
			  stroke="currentColor"
			  style="width: 1.5rem; height: 1.5rem; flex-shrink: 0;"
			>
			  <path
			    stroke-linecap="round"
			    stroke-linejoin="round"
			    d="M8.25 4.5l7.5 7.5-7.5 7.5"
			  />
			</svg>
			<span class="place arrival">Gapyeong</span>
		</div>
		<div class="grid-6">
			<div class="head">Date</div>
			<div class="head">Time</div>
			<div class="head">Departure</div>
			<div class="head">Arrival</div>
			<div class="head">Details</div>
			<div class="head">Book</div>
			
			<%
				BusDAO busDAO = new BusDAO();
				ArrayList<Businfo> list = busDAO.getList(businfo);
				for(int i = 0; i < list.size(); i++){
			%>
			<div class="item"><%= list.get(i).getDdate() %></div>
			<div class="item"><%= list.get(i).getTime().substring(0, 2) + ":" + list.get(i).getTime().substring(3, 5) %></div>
			<div class="item"><%= list.get(i).getDstation() %></div>
			<div class="item"><%= list.get(i).getAstation() %></div>
			<div class="item"><a href='busdetails.jsp'>Bus Details</a></div>
			<div class="item"><a href='reservation.jsp?rtid=<%= list.get(i).getTid() %>&depart=<%= list.get(i).getDstation() %>
			&arrive=<%= list.get(i).getAstation() %>&ddate=<%= list.get(i).getDdate() %>&dtime=<%= list.get(i).getTime() %>'>Ticket</a></div>
			<%
				}
			%>
		</div>  
	</body>
</html>