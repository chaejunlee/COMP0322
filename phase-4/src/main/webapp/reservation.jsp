<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="reservation.ReservationDAO" %>
<%@ page import="reservation.Reservation" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="reservation" class="reservation.Reservation" scope="page" />
<jsp:setProperty name="reservation" property="raid" />
<jsp:setProperty name="reservation" property="rsid" />
<jsp:setProperty name="reservation" property="rtid" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="style.css" />
<title>reservation</title>
</head>
<body>
  <%
    String rtid = request.getParameter("rtid");
    String depart = request.getParameter("depart");
    String arrive = request.getParameter("arrive");
    String ddate = request.getParameter("ddate");
    String dtime = request.getParameter("dtime");
  %>
  <h1>Available Seats</h1>
  <form method="get" action="reservationAction.jsp">
    <div class="bus-grid row-span">
    <%
      ReservationDAO reserveDAO = new ReservationDAO();
      ArrayList<Reservation> list = reserveDAO.getSeat(rtid, depart, arrive, ddate, dtime);
      
      boolean arr[][] = new boolean[4][10];
      
      String row[] = {"A", "B", "C", "D"};
      
      for(int a = 0; a < arr.length; a++){
          for(int b = 0; b < arr[a].length; b++){
              arr[a][b] = false;
          }
      }
    
      for(int i = 0; i < list.size(); i++){
        String seats = list.get(i).getRsid();
        if (seats.contains("A")) {
          arr[0][seats.charAt(1) - '0'] = true;
        } else if (seats.contains("B")) {
          arr[1][seats.charAt(1) - '0'] = true;
        } else if (seats.contains("C")) {
          arr[2][seats.charAt(1) - '0'] = true;
        } else if (seats.contains("D")) {
          arr[3][seats.charAt(1) - '0'] = true;
        }
      }
      
      out.println("<div></div>");
      
      for (int i = 1; i < 11; i++)
        out.println("<div class=\"head\">" + i + "</div>");
      
      for(int a = 0; a < 4; a++){
        out.println("<div class=\"head\">" + row[a] + "</div>");
          
          for(int b = 0; b < arr[a].length; b++){
          String seat = row[a] + Integer.toString(b + 1);
    %>
      <div class="item">
        <input
          type="checkbox"
          class="seat"
          style="display: grid; place-items: center;"
          <% out.println((arr[a][b] ? "" : "disabled") + " id=" + seat + " value=" + seat); %>
          name="sid"
        >
      </div>
      
    <%
          }
      }
    %>
    </div>
    <input type="hidden" id="tid" name="tid" value=<%= rtid %>>
    <input type="hidden" id="depart" name="depart" value=<%= depart %>>
    <input type="hidden" id="arrive" name="arrive" value=<%= arrive %>>
    <input type="hidden" id="ddate" name="ddate" value=<%= ddate %>>
    <input type="hidden" id="dtime" name="dtime" value=<%= dtime %>>
    <div class="row-span grid-3">
    <div>
      <label for="child">Children <span class="label-sm">(Under age 9)</span></label>
      
      <input type="number" min="0" id = "child" name = "child" value="0">
    </div>
    <div>
        <label for="teenage">Teenager <span class="label-sm">(Between age 10 ~ 18)</span></label>
        <input type="number" min="0"  id = "teenager" name = "teenager" value="0">
    </div>
    <div>
        <label for="adult">Adult <span class="label-sm">(Over age 18)</span></label>
        <input type="number" min="0"  id = "adult" name = "adult" value="0">
    </div>
    </div>			
    <input class="row-span btn" type="submit" value="Confirm">
  </form>
</html>