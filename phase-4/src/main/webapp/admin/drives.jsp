<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%
int column = 3;
String dbid = request.getParameter("dbid");
String dssn = request.getParameter("dssn");
String hours = request.getParameter("hours");


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
sql = "SELECT * FROM DRIVES WHERE 1=1 ";
if (dbid != "") {
	sql += "AND dbid = '" + dbid + "' ";

}
if (dssn != "") {
	sql += "AND dssn = '" + dssn + "' ";

}
if (hours != "") {
	sql += "AND hours = '" + hours + "' ";

}
System.out.println(sql);
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Drives</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>dbid</th>
					<th>dssn</th>
					<th>hours</th>
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