<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%
int column = 5;
String ssn = request.getParameter("ssn");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String salary = request.getParameter("salary");
String esname = request.getParameter("esname");


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
sql = "SELECT * FROM EMPLOYEE WHERE 1=1 ";
if (ssn != "") 
	sql += "AND ssn = '" + ssn + "' ";

if (fname != "") 
	sql += "AND fname = '" + fname + "' ";

if (lname != "") 
	sql += "AND lname = '" + lname + "' ";

if (salary != "")
	sql += "AND salary = '" + salary + "' ";

if (esname != "")
	sql += "AND salary = '" + esname + "' ";

// System.out.println(sql);
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Employee</title>
</head>
<body>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>ssn</th>
					<th>fname</th>
					<th>lname</th>
					<th>salary</th>
					<th>esname</th>
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