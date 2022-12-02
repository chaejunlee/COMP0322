<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%
int column = 3;
String bid = request.getParameter("bid");
String bcompany = request.getParameter("bcompany");
String btype = request.getParameter("btype");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String serverIP = "localhost";
String strSID = "xe";
String portNum = "1600";
String user = "knubus";
String pass = "knubus";
String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
String sql = null;

int num = 0;

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);
%>

<%
sql = "SELECT * FROM BUS WHERE 1=1 ";
if (bid != "") {
	sql += "AND BID = '" + bid + "' ";

}
if (bcompany != "") {
	sql += "AND BCOMPANY = '" + bcompany + "' ";

}
if (btype != "") {
	sql += "AND BTYPE = '" + btype + "' ";

}
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Bus</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>BID</th>
					<th>BCOMPANY</th>
					<th>BTYPE</th>
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