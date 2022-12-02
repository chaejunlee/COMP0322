<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
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
    <meta charset="UTF-8" />
    <link rel="stylesheet" href="style.css" />
    <title>Main :: UNI-BUS</title>
  </head>
  <body>
    <jsp:include page="header.jsp" />
    <h1 class="px-1">Find Your Trip!</h1>
    <main>
    <div class="border flex">
    	<div class="bg-primary"><h2 class="title">🚌   Explore the Fun   🚐</h2></div>
	    <form class="py-1 grid-3" method="post" action="./BUS.jsp">
			<div>
				<label class="small" for="ddate">Date</label>
				<input name="ddate" id="ddate" type="date" />
			</div>
			
			<div>
				<label class="small" style="display: block" for="dstation">Departure</label>
				<select name="dstation" id="dstation">
					<option value="dongdaegu">Dongdaegu</option>
					<option value="seosan">Seosan</option>
					<option value="seoul">Seoul</option>
					<option value="daegu">Daegu</option>
					<option value="busan">Busan</option>
				</select>
    		</div>
    		
    		<input
		        style="align-self:end;"
		        class="btn blank"
		        type="reset"
		        value="Reset"
	      	/>
	      
			<div>
				<label class="small" for="time">Time</label>
				<input name="time" id="time" type="time" />
			</div>
	      
	      
	      
	      <div>
	        <label class="small" style="display: block" for="astation">Arrival</label>
	        <select name="astation" id="astation">
	          <option value="gapyeong">Gapyeong</option>
	          <option value="kwangmyeong">Kwangmyeong</option>
	          <option value="seoul">Seoul</option>
	          <option value="daegu">Daegu</option>
	          <option value="busan">Busan</option>
	        </select>
	      </div>

	      <input
	        style="align-self:end;"
	        class="btn"
	        type="submit"
	        value="Search"
	      />
	    </form>
    </div>
    </main>
    <jsp:include page="footer.jsp" />
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
