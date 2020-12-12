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
<title>Edit</title>
</head>
<body>

<form method="post" name="form" action="confirmScheduleEdit.jsp">
<table border="1">
<tr>
<th>Stop Number</th>
<th>Station Name</th>
<th>Time</th>
</tr>

<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String scheduleNum = request.getParameter("scheduleNum");
		
		
		String str = "select stopNum, stopName, stopTime, stationID from stops where scheduleNum = " + request.getParameter("scheduleNum") + " order by stopNum ASC";
		ResultSet result = stmt.executeQuery(str);
		session.setAttribute("scheduleNum", scheduleNum);
		
		while(result.next()){
%>
<tr>
<% int stop = result.getInt("stopNum");
String name = result.getString("stopName");
java.sql.Time time;
time = new java.sql.Time(result.getTime("stopTime").getTime());
int stationID = result.getInt("stationID");
%>
<td style="display:none"><input type="text" name="scheduleNum" value="<%=scheduleNum%>" readonly></td>
<td><%=stop%></td>
<td style="display:none"><input type="text" name="stationID" value="<%=stationID%>" readonly></td>
<td><%=name%></td>
<td><input type="time" name="newTime" value="<%=time%>"></td>
<td><input type="submit" name="update" value="Update" style="background-color:gray;font-weight:bold;color:black;'"></td>


</tr> 
<%}%>

</table>
</form>

</body>
</html>