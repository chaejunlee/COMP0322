<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
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
	<title>Timetables :: UniBus</title>
</head>
	<body>
		<jsp:include page="header.jsp" />
		<h1 class="px-1" style="transform: translateY(-24px);">
			<span style="font-size: 0.5em;">Timetable of</span>
			<span style="display: flex;"><% out.println(businfo.getDdate()); %></span>
		</h1>
		<main>
		<div class="title px-1">
			<span class="place depart border"><% out.println(businfo.getDstation()); %></span>
			<svg
			  xmlns="http://www.w3.org/2000/svg"
			  fill="none"
			  viewBox="0 0 24 24"
			  stroke-width="3"
			  stroke="currentColor"
			  style="width: 2rem; height: 2rem; flex-shrink: 0;"
			>
			  <path
			    stroke-linecap="round"
			    stroke-linejoin="round"
			    d="M8.25 4.5l7.5 7.5-7.5 7.5"
			  />
			</svg>
			<span class="place arrival border"><% out.println(businfo.getAstation()); %></span>
		</div>
		<div class="mx-auto max-w px-1 py-2">
			<div class="grid-3 grid-2-1-1 border">
				<div class="head">Time</div>
				<div class="head">Details</div>
				<div class="head">Ticket</div>
				
				<%
					BusDAO busDAO = new BusDAO();
					ArrayList<Businfo> list = busDAO.getList(businfo);
					for(int i = 0; i < list.size(); i++){
				%>
				<div class="item date"><%= list.get(i).getTime().substring(0, 2) + ":" + list.get(i).getTime().substring(3, 5) %></div>
				<div class="item"><a class="btn-sm blank" href='busdetails.jsp?tid=<%= list.get(i).getTid() %>'>Show</a></div>
				<div class="item"><a class="btn-sm" href='reservation.jsp?rtid=<%= list.get(i).getTid() %>&depart=<%= list.get(i).getDstation() %>
				&arrive=<%= list.get(i).getAstation() %>&ddate=<%= list.get(i).getDdate() %>&dtime=<%= list.get(i).getTime() %>'>Book</a></div>
				<%
					}
				%>
			</div>
		</div>  
		</main>
		<jsp:include page="footer.jsp" />
	</body>
</html>