<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 3;
String src = request.getParameter("src");
String dbid = request.getParameter("dbid");
String dssn = request.getParameter("dssn");
String hours = request.getParameter("hours");

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

if (src.equals("select")) {
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
} else if (src.equals("insert")) {
	if (dbid != "" || dssn != "" || hours != "") {
		sql = "INSERT INTO DRIVES VALUES(";
		sql += "'" + dbid + "', '" + dssn + "', '" + hours;
		sql += "')";
	}
} else if (src.equals("delete")) {
	sql = "DELETE DRIVES WHERE 1=1  ";
	if (dbid != "")
		sql += "AND DBID = '" + dbid + "' ";
	if (dssn != "")
		sql += "AND dssn = '" + dssn + "' ";
	if (hours != "")
		sql += "AND hours = '" + hours + "' ";
}

//System.out.println(sql);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Drives</title>
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
					<th>dbid</th>
					<th>dssn</th>
					<th>hours</th>
				</tr>
			</thead>
			<tbody>

				<%
				while (rs.next()) {
					num++;
				%>

				<tr>

					<%
					for (int i = 1; i <= column; i++) {
					%>
					<td><%=rs.getString(i)%></td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%=num%>개
		<%
		}
		%>
		<%
		if (src.equals("insert")) {
			if (dbid != "" || dssn != "" || hours != "") {
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