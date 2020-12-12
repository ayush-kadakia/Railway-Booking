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
<th>Fare</th>
<th>Date of Travel</th>
<th>Origin Stop Number</th>
<th>Origin Stop Time</th>
<th>Destination Stop Number</th>
<th>Destination Stop Time</th>
</tr>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String og = request.getParameter("origin");
		
		String getID1 = "select stationID from stations where name = '" + og + "'";
		ResultSet result = stmt.executeQuery(getID1);
		int stationID1 = 0;
		while(result.next()){
			stationID1 = result.getInt("stationID");
		}
		result.close();
		
		String dest = request.getParameter("destination");
		String getID2 = "select stationID from stations where name = '" + dest + "'";
		result = stmt.executeQuery(getID2);
		
		int stationID2 = 0;
		while(result.next()){
			stationID2 = result.getInt("stationID");
		}
		result.close();
		
		String date = request.getParameter("Date");
		String getResults = "select a.scheduleNum, a.numStops stops, s.transitLineName, s.scheduleDate, (s.fare/(a.numStops-1) * (b.stopNum - a.stopNum)) fare, a.stopTime originTime, b.stopTime destTime, a.stopNum ogNum, b.stopNum destNum from (select* from stops where stationID = "
				+ stationID1 + ") a, (select* from stops where stationID = "
				+ stationID2 + ") b, schedules s where a.scheduleNum = b.scheduleNum and a.scheduleNum = s.scheduleNum and a.stopNum < b.stopNum and s.scheduleDate = '"
				+ date + "'";
		String Filter = request.getParameter("Filter");
		if(!Filter.equals("default")){
			getResults += " order by ";
			if(Filter.equals("ogTimeAsc"))
				getResults += "originTime ASC";
			else if(Filter.equals("ogTimeDesc"))
				getResults += "originTime DESC";
			else if(Filter.equals("destTimeAsc"))
				getResults += "destTime ASC";
			else if(Filter.equals("destTimeDesc"))
				getResults += "destTime DESC";
			else if(Filter.equals("fareAsc"))
				getResults += "fare ASC";
			else
				getResults += "fare DESC";
		}
		
		//System.out.println(getResults);
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
<% float fare = result.getFloat("fare");%>
<td><%=fare%></td>
<td><%=date%></td>
<% int ogNum = result.getInt("ogNum");%>
<td><%=ogNum%></td>
<% java.sql.Time originTime = result.getTime("originTime");%>
<td><%=originTime%></td>
<% int destNum = result.getInt("destNum");%>
<td><%=destNum%></td>
<% java.sql.Time destTime = result.getTime("destTime");%>
<td><%=destTime%></td>
<td><input type="submit" name="Details" value="details" style="background-color:green;font-weight:bold;color:black;"onclick="window.location.href='scheduleDetails.jsp?schNum=<%=schNum%>&ogNum=<%=ogNum%>&destNum=<%=destNum%>&ogID=<%=stationID1%>&destID=<%=stationID2%>'"></td>
</tr> 
<%}
if(!hasResults){
	out.println("No results. <a href='searchSchedules.jsp'>Click here to try again</a>");
}%>

</table>

</body>
</html>