<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<button style="background-color: green; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='home.jsp'">Home</button>
<button style="background-color: red; border-radius: 10px; position: absolute; top:25px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>
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

		String schNum = request.getParameter("schNum"); 
		String date = request.getParameter("date"); 
		float fare = Float.parseFloat(request.getParameter("subtotal")); 
		float subtotal = fare;
		String username = (String)session.getAttribute("newUsername"); 
		String resNum = request.getParameter("resNum");
		String ticketType = request.getParameter("ticketType");
		String customerType = request.getParameter("customerType");
		String og = request.getParameter("og");
		String dest = request.getParameter("dest");
		
		if(customerType.equals("child"))
			fare *= 0.75;
		else if(customerType.equals("senior"))
			fare  *= 0.65;
		else if(customerType.equals("disabled"))
			fare *= 0.5;
		
		if(ticketType.equals("round"))
			fare *= 2;
		try{
			String insert = "insert into reservations values (" + resNum + ", '" + username + "', " + schNum + ", '" + date + "', '" + fare + "', " + og + ", " + dest + ", '" + customerType + "', '" + ticketType + "', 'active')";
			//System.out.println(insert);
			stmt.executeUpdate(insert);
		
			out.println("Successfully made your reservation. <a href='home.jsp'>Click here to return home.</a>");
		}
		catch(Exception e){
			out.println(e);
			out.println("Error: you've tried making the same reservation twice. Please <a href='home.jsp'>return home</a>, or refresh the previous page to make a new reservation with the same options.");
		}
%>
</body>
</html>