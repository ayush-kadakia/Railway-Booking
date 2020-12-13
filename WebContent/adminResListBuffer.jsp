<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<button style="background-color: green; border-radius: 10px; position: absolute; top:0px; right: 80px;" onclick="window.location.href='home.jsp'">Home</button>
<button style="background-color: red; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>
<head>
<meta charset="ISO-8859-1">
<title>Admin Reservation List Buffer</title>
</head>
<body>
<table id="reservationList" border="1">
<caption><b><u>Reservation List</u></b></caption>
<tr>
<th>Reservation Number</th>
<th>Transit Line Name</th>
<th>Username</th>
<th>Schedule Number</th>
<th>Reservation Date</th>
<th>Fare</th>
<th>Origin Station ID</th>
<th>Destination Station ID</th>
<th>Customer Type</th>
<th>Ticket Type</th>
</tr>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	String str = "";
	if(request.getParameter("type").equals("Customer Name")){
		String un = request.getParameter("customerName");
		str = "select r.resNum, r.username, s.transitLineName, r.scheduleNum, r.resDate, r.fare, r.originStationID, r.destStationID, r.customerType, r.ticketType from schedules s, reservations r where s.scheduleNum = r.scheduleNum and r.username = '" + un + "'";
		} 
	else {
			String tl = request.getParameter("transitLineName");
			str = "select r.resNum, r.username, s.transitLineName, r.scheduleNum, r.resDate, r.fare, r.originStationID, r.destStationID, r.customerType, r.ticketType from schedules s, reservations r where s.scheduleNum = r.scheduleNum and s.transitLineName = '" + tl + "'";
		}
	
	ResultSet result = stmt.executeQuery(str);

	
	int resNum = -1;
	String transitLineName = "";
	String username = "";
	int schedNum = -1;
	java.sql.Date resDate = null;
	float fare = -1;
	int originStationID = -1;
	int destinationStationID = -1;
	String customerType = "";
	String ticketType = "";
	while(result.next()){
		resNum = result.getInt("resNum");
		transitLineName = result.getString("transitLineName");
		username = result.getString("username");
		schedNum = result.getInt("scheduleNum");
		resDate = result.getDate("resDate");
		fare = result.getFloat("fare");
		originStationID = result.getInt("originStationID");
		destinationStationID = result.getInt("destStationID");
		customerType = result.getString("customerType");
		ticketType = result.getString("ticketType");
%>
<tr>
<td><%=resNum%></td>
<td><%=transitLineName%></td>
<td><%=username%></td>
<td><%=schedNum%></td>
<td><%=resDate%></td>
<td><%=fare%></td>
<td><%=originStationID%></td>
<td><%=destinationStationID%></td>
<td><%=customerType%></td>
<td><%=ticketType%></td>
</tr>
<%}%>
</table>
</body>
</html>