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

<%
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

Class.forName("oracle.jdbc.driver.OracleDriver");
conn = DriverManager.getConnection(url, user, pass);
%>


<!DOCTYPE html>
<html>

<head>
<meta charset="EUC-KR">
<title>Admin Page</title>
</head>

<body>
	<div>
		<b>BUS</b>
		<form method="post" action="./bus.jsp">
			<div>
				Bid: <select id="bid" name="bid">
					<option value="" selected></option>
					<%
					sql = "select BID from bus group by bid order by bid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String bid = rs.getString("BID");
					%>

					<option value=<%=bid%>><%=bid%>
					</option>

					<%
					}
					%>
				</select> Bcompany: <select id="bcompany" name="bcompany">
					<option value="" selected></option>
					<%
					sql = "select BCOMPANY from bus group by bcompany order by bcompany";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String bcompany = "'"+rs.getString("BCOMPANY")+"'";
					%>

					<option value=<%=bcompany%>><%=bcompany%>
					</option>

					<%
					}
					%>
				</select> Btype: <select id="btype" name="btype">
					<option value="" selected></option>
					<%
					sql = "select BTYPE from bus group by btype order by btype";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String btype = rs.getString("BTYPE");
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
		<form method="post" action="./drives.jsp">
			<div>
				Dbid: <select id="dbid" name="dbid">
					<option value="" selected></option>
					<%
					sql = "select dbid from drives group by dbid order by dbid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dbid = rs.getString("DBID");
					%>

					<option value=<%=dbid%>><%=dbid%>
					</option>

					<%
					}
					%>
				</select> Dssn: <select id="dssn" name="dssn">
					<option value="" selected></option>
					<%
					sql = "select dssn from drives group by dssn order by dssn";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dssn = rs.getString("DSSN");
					%>

					<option value=<%=dssn%>><%=dssn%>
					</option>

					<%
					}
					%>
				</select> Hours: <select id="hours" name="hours">
					<option value="" selected></option>
					<%
					sql = "select hours from drives group by hours order by hours";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String hours = rs.getString("hours");
					%>

					<option value=<%=hours%>><%=hours%>
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
		<b>EMPLOYEE</b>
		<form method="post" action="./employee.jsp">
			<div>
				ssn: <select id="ssn" name="ssn">
					<option value="" selected></option>
					<%
					sql = "select ssn from employee group by ssn order by ssn";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String ssn = rs.getString("ssn");
					%>

					<option value=<%=ssn%>><%=ssn%>
					</option>

					<%
					}
					%>
				</select> fname: <select id="fname" name="fname">
					<option value="" selected></option>
					<%
					sql = "select fname from employee group by fname order by fname";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String fname = rs.getString("fname");
					%>

					<option value=<%=fname%>><%=fname%>
					</option>

					<%
					}
					%>
				</select> lname: <select id="lname" name="lname">
					<option value="" selected></option>
					<%
					sql = "select lname from employee group by lname order by lname";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String lname = rs.getString("lname");
					%>

					<option value=<%=lname%>><%=lname%>
					</option>

					<%
					}
					%>
				</select> salary: <select id="salary" name="salary">
					<option value="" selected></option>
					<%
					sql = "select salary from employee group by salary order by salary";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String salary = rs.getString("salary");
					%>

					<option value=<%=salary%>><%=salary%>
					</option>

					<%
					}
					%>
				</select> esname: <select id="esname" name="esname">
					<option value="" selected></option>
					<%
					sql = "select esname from employee group by esname order by esname";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String esname = rs.getString("esname");
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
		<form method="post" action="./price.jsp">
			<div>
				age: <select id="age" name="age">
					<option value="" selected></option>
					<%
					sql = "select age from price group by age order by age";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String age = rs.getString("age");
					%>

					<option value=<%=age%>><%=age%>
					</option>

					<%
					}
					%>
				</select> bustype: <select id="bustype" name="bustype">
					<option value="" selected></option>
					<%
					sql = "select bustype from price group by bustype order by bustype";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String bustype = rs.getString("bustype");
					%>

					<option value=<%=bustype%>><%=bustype%>
					</option>

					<%
					}
					%>
				</select> fee: <select id="fee" name="fee">
					<option value="" selected></option>
					<%
					sql = "select fee from price group by fee order by fee";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String fee = rs.getString("fee");
					%>

					<option value=<%=fee%>><%=fee%>
					</option>

					<%
					}
					%>
				</select> prid: <select id="prid" name="prid">
					<option value="" selected></option>
					<%
					sql = "select prid from price group by prid order by prid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String prid = rs.getString("prid");
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
		<b>reservation</b>
		<form method="post" action="./reservation.jsp">
			<div>
				raid: <select id="raid" name="raid">
					<option value="" selected></option>
					<%
					sql = "select raid from reservation group by raid order by raid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String raid = rs.getString("raid");
					%>

					<option value=<%=raid%>><%=raid%>
					</option>

					<%
					}
					%>
				</select> rsid: <select id="rsid" name="rsid">
					<option value="" selected></option>
					<%
					sql = "select rsid from reservation group by rsid order by rsid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String rsid = rs.getString("rsid");
					%>

					<option value=<%=rsid%>><%=rsid%>
					</option>

					<%
					}
					%>
				</select> rtid: <select id="rtid" name="rtid">
					<option value="" selected></option>
					<%
					sql = "select rtid from reservation group by rtid order by rtid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String rtid = rs.getString("rtid");
					%>

					<option value=<%=rtid%>><%=rtid%>
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
		<form method="post" action="./route.jsp">
			<div>
				rid: <select id="rid" name="rid">
					<option value="" selected></option>
					<%
					sql = "select rid from route group by rid order by rid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String rid = rs.getString("rid");
					%>

					<option value=<%=rid%>><%=rid%>
					</option>

					<%
					}
					%>
				</select> dstation: <select id="dstation" name="dstation">
					<option value="" selected></option>
					<%
					sql = "select dstation from route group by dstation order by dstation";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dstation = rs.getString("dstation");
					%>

					<option value=<%=dstation%>><%=dstation%>
					</option>

					<%
					}
					%>
				</select> astation: <select id="astation" name="astation">
					<option value="" selected></option>
					<%
					sql = "select astation from route group by astation order by astation";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String astation = rs.getString("astation");
					%>

					<option value=<%=astation%>><%=astation%>
					</option>

					<%
					}
					%>
				</select> dplatform: <select id="dplatform" name="dplatform">
					<option value="" selected></option>
					<%
					sql = "select dplatform from route group by dplatform order by dplatform";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String dplatform = rs.getString("dplatform");
					%>

					<option value=<%=dplatform%>><%=dplatform%>
					</option>

					<%
					}
					%>
				</select> aplatform: <select id="aplatform" name="aplatform">
					<option value="" selected></option>
					<%
					sql = "select aplatform from route group by aplatform order by aplatform";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String aplatform = rs.getString("aplatform");
					%>

					<option value=<%=aplatform%>><%=aplatform%>
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
		<b>station</b>
		<form method="post" action="./station.jsp">
			<div>
				stname: <select id="stname" name="stname">
					<option value="" selected></option>
					<%
					sql = "select stname from station group by stname order by stname";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String stname = rs.getString("stname");
					%>

					<option value=<%=stname%>><%=stname%>
					</option>

					<%
					}
					%>
				</select> totalplatform: <select id="totalplatform" name="totalplatform">
					<option value="" selected></option>
					<%
					sql = "select totalplatform from station group by totalplatform order by totalplatform";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String totalplatform = rs.getString("totalplatform");
					%>

					<option value=<%=totalplatform%>>
						<%=totalplatform%>
					</option>

					<%
					}
					%>
				</select> address: <select id="address" name="address">
					<option value="" selected></option>
					<%
					sql = "select address from station group by address order by address";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String address = "'"+rs.getString("address")+"'";
					%>

					<option value=<%=address%>><%=address%>
					</option>

					<%
					}
					%>
				</select> zipcode: <select id="zipcode" name="zipcode">
					<option value="" selected></option>
					<%
					sql = "select zipcode from station group by zipcode order by zipcode";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String zipcode = rs.getString("zipcode");
					%>

					<option value=<%=zipcode%>><%=zipcode%>
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
		<b>timetable</b>
		<form method="post" action="./timetable.jsp">
			<div>
				tid: <select id="tid" name="tid">
					<option value="" selected></option>
					<%
					sql = "select tid from timetable group by tid order by tid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String tid = rs.getString("tid");
					%>

					<option value=<%=tid%>><%=tid%>
					</option>

					<%
					}
					%>
				</select> tdate: <select id="tdate" name="tdate">
					<option value="" selected></option>
					<%
					sql = "select tdate from timetable group by tdate order by tdate";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String tdate = "'"+rs.getString("tdate")+"'";
					%>

					<option value=<%=tdate%>><%=tdate%>
					</option>

					<%
					}
					%>
				</select> depart_time: <select id="depart_time" name="depart_time">
					<option value="" selected></option>
					<%
					sql = "select depart_time from timetable group by depart_time order by depart_time";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String depart_time = "'"+rs.getString("depart_time")+"'";
					%>

					<option value=<%=depart_time%>><%=depart_time%>
					</option>

					<%
					}
					%>
				</select> arrive_time: <select id="arrive_time" name="arrive_time">
					<option value="" selected></option>
					<%
					sql = "select arrive_time from timetable group by arrive_time order by arrive_time";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String arrive_time = "'"+rs.getString("arrive_time")+"'";
					%>

					<option value=<%=arrive_time%>><%=arrive_time%>
					</option>

					<%
					}
					%>
				</select> tbid: <select id="tbid" name="tbid">
					<option value="" selected></option>
					<%
					sql = "select tbid from timetable group by tbid order by tbid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String tbid = rs.getString("tbid");
					%>

					<option value=<%=tbid%>><%=tbid%>
					</option>

					<%
					}
					%>
				</select> trid: <select id="trid" name="trid">
					<option value="" selected></option>
					<%
					sql = "select trid from timetable group by trid order by trid";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						String trid = rs.getString("trid");
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