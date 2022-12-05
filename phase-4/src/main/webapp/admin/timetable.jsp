<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<%@ page language="java" import="java.text.*, java.sql.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="config.Properties"%>

<%
int column = 6;
String src = request.getParameter("src");
String tid = request.getParameter("tid");
String tbid = request.getParameter("tbid");
String trid = request.getParameter("trid");

String tdate = request.getParameter("tdate");
String depart_time = request.getParameter("depart_time");
String arrive_time = request.getParameter("arrive_time");


String tdate_yyyy = request.getParameter("tdate_yyyy");
String tdate_mm = request.getParameter("tdate_mm");
String tdate_dd = request.getParameter("tdate_dd");
String depart_hh24 = request.getParameter("depart_hh24");
String depart_mi = request.getParameter("depart_mi");
String arrive_hh24 = request.getParameter("arrive_hh24");
String arrive_mi = request.getParameter("arrive_mi");

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
} else if (src.equals("insert")) {
	if (tid != "" || tdate_yyyy != "" || tdate_mm != "" || tdate_dd != "" ||
	depart_hh24 != "" || depart_mi != "" || 
	arrive_hh24 != "" || arrive_mi != "" ||
	tbid != "" || trid != "") {
		sql = "INSERT INTO TIMETABLE VALUES(";
		sql += "'" + tid + 
		"', to_date('" + tdate_yyyy + "-" + tdate_mm + "-" + tdate_dd + " "+ "00:00:00" +
		"', 'yyyy-mm-dd hh24:mi:ss')"+ 
		", to_date('" + tdate_yyyy + "-" + tdate_mm + "-" + tdate_dd + " " + depart_hh24 + ":" + depart_mi + ":00"+ 
		"', 'yyyy-mm-dd HH24:MI:ss')"+
		", to_date('" + tdate_yyyy + "-" + tdate_mm + "-" + tdate_dd + " " + arrive_hh24 + ":" + arrive_mi + ":00"+ 
		"', 'yyyy-mm-dd HH24:MI:ss'), '" +
		tbid + "', '" +trid;
		sql += "')";
	}
} else if (src.equals("delete")) {
	sql = "DELETE TIMETABLE WHERE 1=1  ";
	if (tid != "")
		sql += "AND DBID = '" + tid + "' ";
	if (tdate != "")
		sql += "AND tdate = '" + tdate + "' ";
	if (depart_time != "")
		sql += "AND depart_time = '" + depart_time + "' ";
	if (arrive_time != "")
		sql += "AND arrive_time = '" + arrive_time + "' ";
	if (tbid != "")
		sql += "AND tbid = '" + tbid + "' ";
	if (trid != "")
		sql += "AND trid = '" + trid + "' ";
}
 System.out.println(sql);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: Timetable</title>
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
		<%
		}
		%>
		<%
		if (src.equals("insert")) {
			if (tid != "" || tdate_yyyy != "" || tdate_mm != "" || tdate_dd != "" ||
	depart_hh24 != "" || depart_mi != "" || 
	arrive_hh24 != "" || arrive_mi != "" ||
	tbid != "" || trid != "") {
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