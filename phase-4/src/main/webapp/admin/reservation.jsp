<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 4;
String src = request.getParameter("src");
String raid = request.getParameter("raid");
String rsid = request.getParameter("rsid");
String rtid = request.getParameter("rtid");


Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String serverIP = Properties.serverIP;
String strSID = Properties.strSID;
String portNum = Properties.portNum;
String user = Properties.user;
String pass = Properties.pass;
String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
String sql = null;

int num = 0;

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);
%>

<%
sql = "SELECT * FROM RESERVATION WHERE 1=1 ";
if (raid != "") {
	sql += "AND raid = '" + raid + "' ";

}
if (rsid != "") {
	sql += "AND rsid = '" + rsid + "' ";

}
if (rtid != "") {
	sql += "AND rtid = '" + rtid + "' ";

}
// System.out.println(sql);
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Reservation</title>
</head>
<body>
	<div>
	<% if (src.equals("select")) { %>
		<table border="1">
			<thead>
				<tr>
					<th>raid</th>
					<th>rsid</th>
					<th>rtid</th>
					<th>rage</th>
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
<% } %>
	</div>
</body>
</html>