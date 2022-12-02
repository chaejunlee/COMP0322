<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>main.jsp</title>
</head>
<body>
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
	%>
	<div>
		<ul>
			<li><a href="main.jsp">main page</a>
			<li><a href="administrator.jsp">Administrator</a>
	<%
		if(userAID == null){
	%>
			<li><a href="login.jsp">login</a>
			<li><a href="signup.jsp">sign up</a>
	<%
		} else{
	%>
		<li><a href="myReservation.jsp">myReservation</a>
		<li><a href="logoutAction.jsp">logout</a>
	<%
		}
	%>
		</ul>
	</div>
	<div>
		<form method="post" action="./BUS.jsp">
		<p>
			Departure:
			<select id="dstation" name="dstation">
				<option id="0" value="dongdaegu">Dongdaegu</option>
				<option id="1" value="busan">Busan</option>
				<option id="2" value="gapyeong">Gapyeong</option>
			</select>
		
			Arrival:
			<select id="astation" name="astation">
				<option id="0" value="dongdaegu">Dongdaegu</option>
				<option id="1" value="busan">Busan</option>
				<option id="2" value="gapyeong">Gapyeong</option>
			</select>
			
			Date: 
			<input type="text" id="ddate" name="ddate" placeholder="22/12/24">
			
			Time: 
			<input type="text" id="time" name="time" placeholder="15:30">
		</p>
				
		<input type="reset" value="Reset">
		<input type="submit" value="Submit">
	</form>
	</div>
	
</body>
</html>