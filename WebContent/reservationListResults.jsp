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
<title>Results</title>
</head>
<body>
<table border="1">
<tr>
<th>Reservation Number</th>
<th>Username</th>
<th>Last Name</th>
<th>First Name Name</th>
<th>Reservation Date</th>
<th>Transit Line Name</th>
<th>Customer Type</th>
<th>Ticket Type</th>
<th>Total Fare</th>
</tr>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String lineName = request.getParameter("name");
		String date = request.getParameter("Date");
		
		String str = "select r.resNum, r.ticketType, r.customerType, r.fare, u.firstName, u.lastName, u.username  from login u, reservations r, schedules s where u.username = r.username and r.scheduleNum = s.scheduleNum and r.resDate = '"
				+ date + "' and s.transitLineName = '" + lineName + "'";
		ResultSet result = stmt.executeQuery(str);
		
		boolean hasResults = false;
		while(result.next()){
			hasResults = true;
			int resNum = result.getInt("resNum");
			String username = result.getString("username");
			String last = result.getString("lastName");
			String first = result.getString("firstName");
			String customerType = result.getString("customerType");
			String ticketType = result.getString("ticketType");
			float fare = result.getFloat("fare");
			%>
			<tr>
			<td><%=resNum%></td>
			<td><%=username%></td>
			<td><%=last%></td>
			<td><%=first%></td>
			<td><%=date%></td>
			<td><%=lineName%></td>
			<td><%=customerType%></td>
			<td><%=ticketType%></td>
			<td><%=fare%></td>
			</tr>
<%		}
		if(!hasResults)
			out.println("No results.");
%>	
</table>
</body>
</html>