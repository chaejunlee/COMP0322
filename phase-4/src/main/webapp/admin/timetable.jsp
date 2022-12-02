<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%
int column = 6;
String tid = request.getParameter("tid");
String tdate = request.getParameter("tdate");
String depart_time = request.getParameter("depart_time");
String arrive_time = request.getParameter("arrive_time");
String tbid = request.getParameter("tbid");
String trid = request.getParameter("trid");


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String serverIP = "localhost";
String strSID = "xe";
String portNum = "1600";
String user = "BUS_25";
String pass = "qwe123";
String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
String sql = null;

int num = 0;

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);
%>

<%
sql = "SELECT * FROM Timetable WHERE 1=1 ";
if (tid != "") 
	sql += "AND tid = '" + tid + "' ";

if (tdate != "") 
	sql += "AND tdate = to_date('" + tdate + "', 'yy/mm/dd HH24:MI:SS') ";

if (depart_time != "") 
	sql += "AND depart_time = to_date('" + depart_time + "', 'yy/mm/dd HH24:MI:SS') ";

if (arrive_time != "")
	sql += "AND arrive_time = to_date('" + arrive_time + "', 'yy/mm/dd HH24:MI:SS') ";

if (tbid != "")
	sql += "AND tbid = '" + tbid + "' ";

if (trid != "")
	sql += "AND trid = '" + trid + "' ";

System.out.println(sql);
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Timetable</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>tid</th>
					<th>tdate</th>
					<th>depart_time</th>
					<th>arrive_time</th>
					<th>tbid</th>
					<th>trid</th>
				</tr>
			</thead>
			<tbody>

				<% while (rs.next()) {
					num++;
				%>
				
				<tr>
					
					<% for (int i = 1; i <= column; i++) {
					%>
					<td><%=rs.getString(i)%></td>
					<%} %>
				</tr>
				<%} %>
			</tbody>
		</table>
		<%=num %>개
	</div>
</body>
</html>