<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 3;
String src = request.getParameter("src");
String bid = request.getParameter("bid");
String bcompany = request.getParameter("bcompany");
String btype = request.getParameter("btype");

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
	sql = "SELECT * FROM BUS WHERE 1=1 ";
	if (bid != "")
		sql += "AND BID = '" + bid + "' ";
	if (bcompany != "")
		sql += "AND BCOMPANY = '" + bcompany + "' ";
	if (btype != "")
		sql += "AND BTYPE = '" + btype + "' ";
} else if (src.equals("insert")) {
	if (bid != "" || bcompany != "" || btype != "") {
		sql = "INSERT INTO BUS VALUES(";
		sql += bid + ", '" + bcompany + "', '" + btype;
		sql += "')";
	}
} else if (src.equals("delete")) {
	sql = "DELETE BUS WHERE 1=1  ";
	if (bid != "")
		sql += "AND BID = '" + bid + "' ";
	if (bcompany != "")
		sql += "AND BCOMPANY = '" + bcompany + "' ";
	if (btype != "")
		sql += "AND BTYPE = '" + btype + "' ";
}

//System.out.println(sql);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Bus</title>
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
					<th>BID</th>
					<th>BCOMPANY</th>
					<th>BTYPE</th>
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
			if (bid != "" || bcompany != "" || btype != "") {
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