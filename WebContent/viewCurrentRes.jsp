<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Current Reservations</title>
</head>
<body>

<table border="1">
<tr>
<th>Reservation Number</th>
<th>Transit Line Name</th>
</tr>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String username = (String)session.getAttribute("newUsername"); 
		
		String getResults = "select r.resNum resNum, s.transitLineName transitLineName from reservations r, schedules s where(r.scheduleNum = s.scheduleNum) and r.username = '" + username + "' and r.status = 'active' order by r.resNum ASC";
		
		System.out.println(getResults);
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
<td><%=transitLineName%></td>
<td><input type="submit" name="Details" value="Details" style="background-color:green;font-weight:bold;color:black;"onclick="window.location.href='viewScheduleDetails.jsp?resNum=<%=resNum%>&transitLineName=<%=transitLineName%>'"></td>
</tr> 
<%}
if(!hasResults){
	out.println("No results. <a href='home.jsp'>Click here to return home.</a>");
}%>

</table>

</body>
</html>