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
<title>Insert title here</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>#BUS</th>
					<th>COMPANY</th>
					<th>TYPE</th>
					<th>First name</th>
					<th>Last name</th>
					<th>예상 시간</th>
				</tr>
			</thead>
			<tbody>
				<%
				BusDAO details = new BusDAO();
				ArrayList<Busdetails> list = details.getDetails(tid);
				for (int i = 0; i < list.size(); i++) {
				%>
				<tr>
					<td><%=list.get(i).getBid()%></td>
					<td><%=list.get(i).getBcompany()%></td>
					<td><%=list.get(i).getBtype()%></td>
					<td><%=list.get(i).getFname()%></td>
					<td><%=list.get(i).getLname()%></td>
					<td><%=list.get(i).getDiff_mi()%>분</td>

				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<div>
		<table border="1">
			<thead>
				<tr>
					<th>Age</th>
					<th>Fee</th>
				</tr>
			</thead>
			<tbody>
				<%
				ArrayList<Busfee> list1 = details.getFee(tid);
				for (int i = 0; i < list1.size(); i++) {
				%>
				<tr>
					<td><%=list1.get(i).getAge()%></td>
					<td><%=list1.get(i).getFee()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

</body>
</html>