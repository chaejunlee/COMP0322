<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
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
<meta charset="UTF-8">
<title>Sign Up :: UNI-BUS</title>
</head>
<body>
	<%
		String userAID = null;
		if(session.getAttribute("userAid") != null){
			userAID = (String) session.getAttribute("userAid");
		}
		if(userAID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Ya has iniciado sesión.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		if(user.getUserEmail()==null || user.getUserPassword() == null
			|| user.getUserFname()==null || user.getUserLname()==null|| user.getUserPhone()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Algunos elementos no se han introducido.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.signup(user);
			
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Correos duplicados.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				session.setAttribute("userAid", user.getUserAid());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	
		
	%>
	
</body>
</html>