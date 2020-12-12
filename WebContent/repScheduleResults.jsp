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
<title>Search Results</title>
</head>
<body>

<table border="1">
<tr>
<th>Schedule Number</th>
<th>Transit Line Name</th>
<th>Selected Stop Number</th>
<th>Selected Stop Time</th>
</tr>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String name = request.getParameter("name");
		
		String getID = "select stationID from stations where name = '" + name + "'";
		ResultSet result = stmt.executeQuery(getID);
		int stationID = 0;
		while(result.next()){
			stationID = result.getInt("stationID");
		}
		result.close();
		
		String getResults;
		if(request.getParameter("type").equals("Origin"))
			getResults = "select* from stops s, schedules s2 where s.stationID = " + stationID + " and s.stopNum <> s.numStops and s.scheduleNum = s2.schedulenum group by s.scheduleNum";
		else
			getResults = "select* from stops s, schedules s2 where s.stationID = " + stationID + " and s.stopNum <> 1 and s.scheduleNum = s2.schedulenum group by s.scheduleNum";
		result = stmt.executeQuery(getResults);
		boolean hasResults = false;
		while(result.next()){
%>
<tr>
<% hasResults = true; 
int schNum = result.getInt("scheduleNum");%>
<td><%=schNum%></td>
<% String transitLineName = result.getString("transitLineName");%>
<td><%=transitLineName%></td>
<% int stopNum = result.getInt("stopNum");%>
<td><%=stopNum%></td>
<% java.sql.Time time = result.getTime("stopTime");%>
<td><%=time%></td>
</tr> 
<%}
if(!hasResults){
	out.println("No results. <a href='scheduleList.jsp'>Click here to try again</a>");
}%>

</table>

</body>
</html>