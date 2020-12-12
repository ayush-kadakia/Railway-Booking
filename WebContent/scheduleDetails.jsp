<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Schedule Details</title>
</head>
<body>
<% 
	String og = request.getParameter("ogID");
	String dest = request.getParameter("destID");
	System.out.println(og + " " + dest);
%>
<form method="post" name="form" action="makeReservation.jsp?og=<%=og%>&dest=<%=dest%>">
<table>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String schNum = (String)request.getParameter("schNum");
		int ogNum = Integer.parseInt(request.getParameter("ogNum"));
		int destNum = Integer.parseInt(request.getParameter("destNum"));
		float fare = 0;
		
		
		String str = "select* from schedules where scheduleNum = " + schNum;
		ResultSet result = stmt.executeQuery(str);
		java.sql.Date date = null;
		String name = "";
		while(result.next()){
			date = result.getDate("scheduleDate");
			name = result.getString("transitLineName");
			fare = result.getFloat("fare");
		}

		result.close();
		
		int numStops = 0;
		String ogName = "";
		String getOg = "select* from stops where scheduleNum = " + schNum + " and stopNum = " + ogNum;
		java.sql.Time ogTime = null;
		result = stmt.executeQuery(getOg);
		while(result.next()){
			ogName = result.getString("stopName");
			numStops = result.getInt("numStops");
			ogTime = result.getTime("stopTime");
		}
		result.close();
		
		float subtotal = (fare/(numStops - 1)) * (destNum - ogNum);
		
		String getDest = "select* from stops where scheduleNum = " + schNum + " and stopNum = " + destNum;
		String destName = "";
		java.sql.Time destTime = null;
		result = stmt.executeQuery(getDest);
		while(result.next()){
			destName = result.getString("stopName");
			destTime = result.getTime("stopTime");
		}
		result.close();
%>
<tr>
<th>Schedule Number:</th>
<td><input type="text" name="schNum" value="<%=schNum%>" readonly></td>
</tr>
<tr>
<th>Transit Line Name:</th>
<td><input type="text" name="lineName" value="<%=name%>" readonly></td>
</tr>
<tr>
<th>Schedule Date:</th>
<td><input type="date" name="date" value="<%=date%>" readonly></td>
</tr>
<tr>
<th>Subtotal:</th>
<td><input type="text" name="subtotal" value="<%=subtotal%>" readonly></td>
</tr>
<tr>
<td>Origin Stop Number: <input type="text" name="ogNum" value="<%=ogNum%>" readonly></td>
<td>Origin Station:<input type="text" name="ogName" value="<%=ogName%>" readonly></td>
<td>Departure Time: <input type="text" name="ogTime" value="<%=ogTime%>" readonly></td>
</tr>
<%
	String stops = "select stopName, stopNum, stopTime from stops where scheduleNum = " + schNum + "  and stopNum > " + ogNum + " and stopNum < " + destNum + " order by stopNum ASC";
	result = stmt.executeQuery(stops);
	int stopNum = 0;
	String stopName = "";
	java.sql.Time stopTime = null;
	while(result.next()){
		stopNum = result.getInt("stopNum");
		stopName = result.getString("stopName");
		stopTime = result.getTime("stopTime");
%>
<tr>
<td>Stop Number: <input type="text" name="destNum" value="<%=stopNum%>" readonly></td>
<td>Station: <input type="text" name="destNum" value="<%=stopName%>" readonly> </td>
<td>Station Time: <input type="text" name="destNum" value="<%=stopTime%>" readonly> </td>
</tr>
<%}%>
<tr>
<td>Destination Stop Number: <input type="text" name="destNum" value="<%=destNum%>" readonly></td>
<td>Destination Station:<input type="text" name="destName" value="<%=destName%>" readonly></td>
<td>Arrival Time: <input type="text" name="destTime" value="<%=destTime%>" readonly></td>
</tr>
<tr>
<td colspan="3">
<center>
<input type="submit" name="makeReservation" value = "Make Reservation" style="background-color:gray;font-weight:bold;color:black;"></center>
</td>
</tr>
</table>
</form>
</body>
</html>