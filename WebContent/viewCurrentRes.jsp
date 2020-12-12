<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>
<body>

<table border="1">
<tr>
<th>Reservation Number</th>
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
		
		String username = (String)session.getAttribute("newUsername"); 
		
		String getResults = "select* from reservations where username = '" + username + "' and status = 'active' order by resNum ASC'";
		ResultSet result = stmt.executeQuery(getResults);
		
		//System.out.println(getResults);
		boolean hasResults = false;
		while(result.next()){
%>
<tr>
<% hasResults = true; 
int resNum = result.getInt("resNum");%>
<td><%=resNum%></td>
<% String transitLineName = result.getString("transitLineName");%>
<%String status = result.getString("status");%>
<td><%=status%></td>
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
	out.println("No results. <a href='home.jsp'>Click here to return home.</a>");
}%>

</table>

</body>
</html>