<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit/Delete Schedule</title>
</head>
<body>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String schedNum = (String)request.getParameter("scheduleNum");
		String stationID = (String)request.getParameter("stationID");
		String stopTime = (String)request.getParameter("newTime");
		
		String comm = "update stops set stopTime = '" + stopTime + "' where scheduleNum = " + schedNum + " and stationID = " + stationID;

		stmt.executeUpdate(comm);
		out.println("Successfully updated the schedule. <a href='home.jsp'>Click here to return home</a>");
		
%>
</body>
</html>