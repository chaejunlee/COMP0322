<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="busdetails.Busdetails"%>
<%@ page import="busdetails.Busfee"%>
<%@ page import="busdetails.BusDAO"%>
<%@ page import="java.util.ArrayList"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<%
String tid = request.getParameter("tid");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="style.css" />
<title>Insert title here</title>
</head>
<body>
	<h1>Bus Details</h1>
	<div class="grid-2 gap-1 p-1">
		<%
			BusDAO details = new BusDAO();
			ArrayList<Busdetails> list = details.getDetails(tid);
			for (int i = 0; i < list.size(); i++) {
		%>
			<div>
				<h3>BUS Number</h3>
				<div class="emphasize"><%=list.get(i).getBid()%></div>
			</div>
			
			<div>
				<h3>Name of Bus Company</h3>
				<div class="emphasize" style="text-transform: capitalize;"><%=list.get(i).getBcompany()%></div>
			</div>
			
			<div>
				<h3>Bus Type</h3>
				<div class="emphasize"><%=list.get(i).getBtype()%></div>
			</div>
			
			<div>
				<h3>Driver's Name</h3>
				<div class="emphasize"><%=list.get(i).getFname()%> <%=list.get(i).getLname()%></div>
			</div>
			
			<div>
				<h3>Estimated Time of Travel</h3>
				<div class="emphasize"><%=list.get(i).getDiff_mi()%> min</div>
			</div>
			
		<%
			}
		%>
	</div>

	<div class="grid-2 gap-1 p-1">
		<div>
			<h3>Age</h3>
			<%
				ArrayList<Busfee> list1 = details.getFee(tid);
				for (int i = 0; i < list1.size(); i++) {
					out.println("<div class=\"emphasize\">" + list1.get(i).getAge() + "</div>");
				}
			%>
		</div>
		<div>
			<h3>Fee</h3>
			<%
				for (int i = 0; i < list1.size(); i++) {
					out.println("<div class=\"emphasize\">" + list1.get(i).getFee() + "</div>");
				}		
			%>
		</div>
	</div>

</body>
</html>