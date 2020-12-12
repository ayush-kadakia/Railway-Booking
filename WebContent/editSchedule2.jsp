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

<form method="post" name="form">
<table border="1">
<tr><th>Schedule Number</th></tr>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		
		String str = "select scheduleNum from schedules";
		ResultSet result = stmt.executeQuery(str);
		
		while(result.next()){
%>
<tr>
<% int schNum = result.getInt("scheduleNum");%>
<td><%=schNum%></td>
<td><input type="button" name="edit" value="Edit" style="background-color:green;font-weight:bold;color:black;"onclick="window.location.href='editScheduleInfo.jsp?scheduleNum=<%=schNum%>'"></td>
<td><input type="button" name="delete" value="Delete" style="background-color:red;font-weight:bold;color:black;" onclick="window.location.href='deleteSchedule.jsp?scheduleNum=<%=schNum%>'"></td>
</tr> 
<%}%>

</table>
</form>

</body>
</html>