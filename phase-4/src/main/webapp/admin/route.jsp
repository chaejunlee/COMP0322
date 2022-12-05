<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 5;
String src = request.getParameter("src");
String rid = request.getParameter("rid");
String dstation = request.getParameter("dstation");
String astation = request.getParameter("astation");
String dplatform = request.getParameter("dplatform");
String aplatform = request.getParameter("aplatform");


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
sql = "SELECT * FROM ROUTE WHERE 1=1 ";
if (rid != "") 
	sql += "AND rid = '" + rid + "' ";

if (dstation != "") 
	sql += "AND dstation = '" + dstation + "' ";

if (astation != "") 
	sql += "AND astation = '" + astation + "' ";

if (dplatform != "")
	sql += "AND dplatform = '" + dplatform + "' ";

if (aplatform != "")
	sql += "AND dplatform = '" + aplatform + "' ";
} else if (src.equals("insert")) {
	if (rid != "" || dstation != "" || astation != "" || dplatform != "" || aplatform != "") {
		sql = "INSERT INTO ROUTE VALUES(";
		sql += "'" + rid + "', '" + dstation + "', '" + astation + "', '" + dplatform + "', '" + aplatform;
		sql += "')";
	}
} else if (src.equals("delete")) {
	sql = "DELETE ROUTE WHERE 1=1  ";
	if (rid != "")
		sql += "AND DBID = '" + rid + "' ";
	if (dstation != "")
		sql += "AND dstation = '" + dstation + "' ";
	if (astation != "")
		sql += "AND astation = '" + astation + "' ";
	if (dplatform != "")
		sql += "AND dplatform = '" + dplatform + "' ";
	if (aplatform != "")
		sql += "AND aplatform = '" + aplatform + "' ";
}
 System.out.println(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Route</title>
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
					<th>rid</th>
					<th>dstation</th>
					<th>astation</th>
					<th>dplatform</th>
					<th>aplatform</th>
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
			if (rid != "" || dstation != "" || astation != "" || dplatform != "" || aplatform != "") {
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