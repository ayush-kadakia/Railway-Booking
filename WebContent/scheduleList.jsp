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
<title>Search for Schedules by station</title>
</head>
<body>
<form method="post" name="form" action="repScheduleResults.jsp">
<select name="name" id="name">
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		/**
		select* from stops s where s.stationID = (origin.stationID); <--- tuples that stop at the origin stop --> subquery alpha
		select* from stops s where s.stationID = (destination.stationID); <--- tuples that stop at the destination stop --> subquery beta
		
		select* from stops s where s.stationID = (origin.stationID) OR s.stationID = (destination.stationID); <--- subquery blah
		
		select a.scheduleNum 
		from alpha a, beta b
		where a.scheduleNum = b.scheduleNum //scheduleNum of a schedule that stops at both the origin and the destination
		and a.stopNum <  b.stopNum;
		
		start 23 end 14
		**/
		
		String str = "select* from stations";
		ResultSet result = stmt.executeQuery(str);
		
		while(result.next()){

			String name = result.getString("name");%>
			<option value="<%=name%>"><%=name%></option>
<%		}
%>	
</select>
<input type="radio" name="type" id="r1" value="Origin" onClick="getResults()" required>Origin&nbsp;
<input type="radio" name="type" id="r2" value="Destination">Destination
<input type="submit" name="Submit" value="Submit" style="background-color:blue;font-weight:bold;color:white;">
</form>
</body>
</html>