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
<title>bus page</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>날짜</th>
					<th>시간</th>
					<th>depart station</th>
					<th>arrive station</th>
					<th>버스 상세 정보</th>
					<th>예약</th>
				</tr>
			</thead>
			<tbody>
				<%
					BusDAO busDAO = new BusDAO();
					ArrayList<Businfo> list = busDAO.getList(businfo);
					for(int i = 0; i < list.size(); i++){
				%>
				<tr>
					<td><%= list.get(i).getDdate() %></td>
					<td><%= list.get(i).getTime().substring(0, 2) + "시" + list.get(i).getTime().substring(3, 5) + "분" %></td>
					<td><%= list.get(i).getDstation() %></td>
					<td><%= list.get(i).getAstation() %></td>
					<td><a href='busdetails.jsp'>버스 정보 상세보기 </a></td>
					<td><a href='reservation.jsp?rtid=<%= list.get(i).getTid() %>&depart=<%= list.get(i).getDstation() %>
					&arrive=<%= list.get(i).getAstation() %>&ddate=<%= list.get(i).getDdate() %>&dtime=<%= list.get(i).getTime() %>'>예약하기</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>  
</body>
</html>