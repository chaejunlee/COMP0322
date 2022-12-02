<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%
int column = 4;
String stname = request.getParameter("stname");
String totalplatform = request.getParameter("totalplatform");
String address = request.getParameter("address");
String zipcode = request.getParameter("zipcode");


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
sql = "SELECT * FROM STATION WHERE 1=1 ";
if (stname != "") 
	sql += "AND stname = '" + stname + "' ";

if (totalplatform != "") 
	sql += "AND totalplatform = '" + totalplatform + "' ";

if (address != "") 
	sql += "AND address = '" + address + "' ";

if (zipcode != "")
	sql += "AND zipcode = '" + zipcode + "' ";


System.out.println(sql);
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin page: Station</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>stname</th>
					<th>totalplatform</th>
					<th>address</th>
					<th>zipcode</th>
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