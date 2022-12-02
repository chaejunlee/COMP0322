<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userAid" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userFname" />
<jsp:setProperty name="user" property="userLname" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userPoint" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="style.css" />
<title>main.jsp</title>
</head>
<body>
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		
		UserDAO userDAO = new UserDAO();
		int point = userDAO.getPoint(userAID);
		
	%>
	<div>
		<ul>
			<li><a href="main.jsp">main page</a>
			<li><a href="./admin/admin.jsp">Administrator</a>
	<%
		if(userAID == null){
	%>
			<li><a href="login.jsp">login</a>
			<li><a href="signup.jsp">sign up</a>
	<%
		} else{
	%>
		<li>my point: <%= point %></li>
		<li><a href="myReservation.jsp">myReservation</a>
		<li><a href="logoutAction.jsp">logout</a>
	<%
		}
	%>
		</ul>
	</div>
	<h1>Book Your Trip!</h1>
	<form method="post" action="./BUS.jsp">
		<div>
	        <label style="display: block" for="dstation">Departure</label>
	        <select name="dstation" id="dstation">
	          <option value="dongdaegu">Dongdaegu</option>
	          <option value="seosan">Seosan</option>
	          <option value="seoul">Seoul</option>
	          <option value="daegu">Daegu</option>
	          <option value="busan">Busan</option>
	        </select>
        </div>
	
		<div>
	        <label style="display: block" for="astation">Arrival</label>
	        <select name="astation" id="astation">
	          <option value="gapyeong">Gapyeong</option>
	          <option value="kwangmyeong">Kwangmyeong</option>
	          <option value="seoul">Seoul</option>
	          <option value="daegu">Daegu</option>
	          <option value="busan">Busan</option>
	        </select>
        </div>
		<div>
	        <label for="ddate">Date</label>
	        <input name="ddate" id="ddate" type="date" />
	      </div>
		
		<div>
	       <label for="time">Time</label>
	       <input name="time" id="time" type="time" />
	     </div>
		
		<input style="margin-top: 0.5em;" class="btn blank" type="reset" value="Reset">
		<input style="margin-top: 0.5em;" class="btn" type="submit" value="Submit">
	</form>
	
</body>
<script>
    const dateInput = document.getElementById("ddate");
    const timeInput = document.getElementById("time");
    const now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    now.setSeconds(null, 0);
    dateInput.valueAsDate = now;
    timeInput.valueAsDate = now;
 </script>
</html>