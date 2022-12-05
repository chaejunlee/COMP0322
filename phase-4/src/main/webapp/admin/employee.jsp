<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 5;
String src = request.getParameter("src");
String ssn = request.getParameter("ssn");
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String salary = request.getParameter("salary");
String esname = request.getParameter("esname");


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
if (src.equals("select")) {
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
} else if (src.equals("insert")) {
	if (ssn != "" || fname != "" || lname != "" || salary != "" || esname != "") {
		sql = "INSERT INTO EMPLOYEE VALUES(";
		sql += "'" + ssn + "', '" + fname + "', '" + lname + "', '" + salary + "', '" + esname;
		sql += "')";
	}
} else if (src.equals("delete")) {
	sql = "DELETE EMPLOYEE WHERE 1=1  ";
	if (ssn != "")
		sql += "AND DBID = '" + ssn + "' ";
	if (fname != "")
		sql += "AND fname = '" + fname + "' ";
	if (lname != "")
		sql += "AND lname = '" + lname + "' ";
	if (salary != "")
		sql += "AND salary = '" + salary + "' ";
	if (esname != "")
		sql += "AND esname = '" + esname + "' ";
}
 System.out.println(sql);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Employee</title>
</head>
<body>
	<div>
	<%
		try {
			if (src.equals("select")) {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
		%>

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
		<%
		}
		%>
		<%
		if (src.equals("insert")) {
			if (ssn != "" || fname != "" || lname != "" || salary != "" || esname != "") {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
			} else {
		%>
		NO BLANKS!
		<%
		}
		%>
		<%=sql%>
		<%
		}
		} catch (Exception e) {
		%>
		Exception Occur
		<%
		}
		%>
	</div>
</body>
</html>