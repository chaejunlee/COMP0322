<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="config.Properties"%>

<%
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

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page: insert</title>
</head>
<body>
	<div>
		<b>BUS</b>
		<form method="post" action="./bus.jsp?src=insert">
			<div>
				Bid: <input id="bid" name="bid" placeholder="1234">
				Bcompany: <select id="bcompany" name="bcompany">
					<option value="" selected></option>
					<%
					sql = "select distinct BCOMPANY from bus group by bcompany order by bcompany";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String bcompany = "'"+rs.getString(1)+"'";
					%>

					<option value=<%=bcompany%>><%=bcompany%>
					</option>

					<%
					}
					%>
				</select>
					Btype: <select id="btype" name="btype">
					<option value="" selected></option>
					<%
					sql = "select distinct BTYPE from bus group by btype order by btype";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String btype = rs.getString(1);
					%>

					<option value=<%=btype%>><%=btype%>
					</option>

					<%
					}
					%>
				</select>


			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>DRIVES</b>
		<form method="post" action="./drives.jsp?src=insert">
			<div>
				<div>
				Dbid: <select id="dbid" name="dbid">
					<option value="" selected></option>
					<%
					sql = "select distinct bid from bus";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dbid = rs.getString(1);
					%>

					<option value=<%=dbid%>><%=dbid%>
					</option>

					<%
					}
					%>
				</select> Dssn: <select id="dssn" name="dssn">
					<option value="" selected></option>
					<%
					sql = "select distinct ssn from employee";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dssn = rs.getString(1);
					%>

					<option value=<%=dssn%>><%=dssn%>
					</option>

					<%
					}
					%>
				</select>
				Hours: <input id="hours" name="hours"  placeholder="12.3">

			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>EMPLOYEE</b>
		<form method="post" action="./employee.jsp?src=insert">
			<div>
				ssn: <input id="ssn" name="ssn" placeholder="123456789">
				fname: <input id="fname" name="fname" placeholder="Seokhyeon">
				lname: <input id="lname" name="lname" placeholder="Lee">
				salary: <input id="salary" name="salary" placeholder="99999">

				esname: <select id="esname" name="esname">
					<option value="" selected></option>
					<%
					sql = "select distinct esname from employee group by esname order by esname";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String esname = rs.getString(1);
					%>

					<option value=<%=esname%>><%=esname%>
					</option>

					<%
					}
					%>
				</select>


			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>price</b>
		<form method="post" action="./price.jsp?src=insert">
			<div>
				age: <select id="age" name="age">
					<option value="" selected></option>
					<%
					sql = "select distinct age from price group by age order by age";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String age = rs.getString(1);
					%>

					<option value=<%=age%>><%=age%>
					</option>

					<%
					}
					%>
				</select> bustype: <select id="bustype" name="bustype">
					<option value="" selected></option>
					<%
					sql = "select distinct bustype from price group by bustype order by bustype";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String bustype = rs.getString(1);
					%>

					<option value=<%=bustype%>><%=bustype%>
					</option>

					<%
					}
					%></select>
					 fee: <input id="fee"
					name="fee"> prid: <select id="prid" name="prid">
					<option value="" selected></option>
					<%
					sql = "select distinct prid from price group by prid order by prid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String prid = rs.getString(1);
					%>

					<option value=<%=prid%>><%=prid%>
					</option>

					<%
					}
					%>
				</select>




			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>route</b>
		<form method="post" action="./route.jsp?src=insert">
			<div>
				rid: <input id="rid" name="rid"  placeholder="0"> dstation: <select id="dstation" name="dstation">
					<option value="" selected></option>
					<%
					sql = "select distinct dstation from route group by dstation order by dstation";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dstation = rs.getString(1);
					%>

					<option value=<%=dstation%>><%=dstation%>
					</option>

					<%
					}
					%>
				</select> astation: <select id="astation" name="astation">
					<option value="" selected></option>
					<%
					sql = "select distinct astation from route group by astation order by astation";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String astation = rs.getString(1);
					%>

					<option value=<%=astation%>><%=astation%>
					</option>

					<%
					}
					%>
				</select> dplatform: <input
					id="dplatform" name="dplatform" placeholder="0"> aplatform: <input
					id="aplatform" name="aplatform" placeholder="0">




			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>station</b>
		<form method="post" action="./station.jsp?src=insert">
			<div>
				stname: <input id="stname" name="stname"  placeholder="LOCATION">
				totalplatform: <input
					id="totalplatform" name="totalplatform"  placeholder="0">
					address: <input
					id="address" name="address"  placeholder="Daegu Bukgu Daehyeonro OOO">
					zipcode: <input id="zipcode"
					name="zipcode"  placeholder="00000">






			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
	<div>
		<b>timetable</b>
		<form method="post" action="./timetable.jsp?src=insert">
			<div>
				<p>tid: <input id="tid" name="tid" placeholder="000000000"></p>
				날짜
				<p>년: <select id = "tdate_yyyy" name = "tdate_yyyy">
						<option value="2022">2022년</option>
						<option value="2023">2023년</option>
						</select>
				월: <select id = "tdate_mm" name = "tdate_mm">
						<% 
						String[] temp ={
							"00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" 
						};
						
						for (String i : temp) { %>
						<option value="<%=i %>"><%=i%>월</option>
						<% } %>
						</select>
				일: <select id = "tdate_dd" name = "tdate_dd">
						<% 
						String[] temp1 ={
								"01", "02", "03", "04", "05", "06", "07", "08", "09",
								"10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
								"20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
								"30", "31"
							};
						for (String i : temp1) { %>
						<option value="<%=i %>"><%=i%>일</option>
						<% } %>
						</select>
				</p>
				출발
				<p>
				시: <select id = "depart_hh24" name = "depart_hh24">
						<% 
						String[] temp2 ={
								"00", "01", "02", "03", "04", "05", "06", "07", "08", "09",
								"10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
								"20", "21", "22", "23"
						};
						
						for (String i : temp1) { %>
						<option value="<%=i %>"><%=i%>시</option>
						<% } %>
						</select>
				분: <select id = "depart_mi" name = "depart_mi">
						<% 
						String[] temp3 ={
							"00", "10", "20", "30", "40", "50"	
						};
						for (String i : temp3) { %>
						<option value="<%=i %>"><%=i%>분</option>
						<% } %>
						</select>
				</p>
				도착
				<p>
				시: <select id = "arrive_hh24" name = "arrive_hh24">
						<% for (String i : temp1) { %>
						<option value="<%=i %>"><%=i%>시</option>
						<% } %>
						</select>
				분: <select id = "arrive_mi" name = "arrive_mi">
						<% for (String i : temp3) { %>
						<option value="<%=i %>"><%=i%>분</option>
						<% } %>
						</select>
				</p>
				
				</select> tbid: <select id="tbid" name="tbid" >
					<option value="" selected></option>
					<%
					sql = "select distinct bid from bus";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String tbid = rs.getString(1);
					%>

					<option value=<%=tbid%>><%=tbid%>
					</option>

					<%
					}
					%>
				</select> trid: <select id="trid" name="trid">
					<option value="" selected></option>
					<%
					sql = "select distinct rid from route";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String trid = rs.getString(1);
					%>

					<option value=<%=trid%>><%=trid%>
					</option>

					<%
					}
					%>
				</select>





			</div>

			<input type="reset" value="Reset"> <input type="submit"
				value="Submit">
		</form>
	</div>
</body>
</html>