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
	<title>Timetables :: UNI-BUS</title>
</head>
	<body>
		<jsp:include page="header.jsp" />
		<h1 class="px-1" style="transform: translateY(-16px);">
			<span style="font-size: 0.5em;">Timetable of</span>
			<span style="display: flex;"><% out.println(businfo.getDdate()); %></span>
		</h1>
		<main>
		<div class="title px-1">
			<span class="place depart"><% out.println(businfo.getDstation()); %></span>
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
			<span class="place arrival"><% out.println(businfo.getAstation()); %></span>
		</div>
		<div class="grid-3 px-1">
			<div class="head">Details</div>
			<div class="head">Time</div>
			<div class="head">Book</div>
			
			<%
				BusDAO busDAO = new BusDAO();
				ArrayList<Businfo> list = busDAO.getList(businfo);
				for(int i = 0; i < list.size(); i++){
			%>
			<div class="item"><a class="btn-sm blank" href='busdetails.jsp?tid=<%= list.get(i).getTid() %>'>Bus Details</a></div>
			<div class="item date"><%= list.get(i).getTime().substring(0, 2) + ":" + list.get(i).getTime().substring(3, 5) %></div>
			<div class="item"><a class="btn-sm" href='reservation.jsp?rtid=<%= list.get(i).getTid() %>&depart=<%= list.get(i).getDstation() %>
			&arrive=<%= list.get(i).getAstation() %>&ddate=<%= list.get(i).getDdate() %>&dtime=<%= list.get(i).getTime() %>'>Ticket</a></div>
			<%
				}
			%>
		</div>  
		</main>
		<jsp:include page="footer.jsp" />
	</body>
</html>