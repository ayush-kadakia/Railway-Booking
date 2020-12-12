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
<title>Schedule Details</title>
</head>
<body>
<form method="post" name="form" action="cancelRes.jsp">
<table>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		
		//for each: resNum, line name, fare, date, origin station, origin time, destination station, destination time
		String resNum = (String)request.getParameter("resNum");
		String transitLineName = (String)request.getParameter("transitLineName");
		String ref = request.getParameter("ref");
		String getRes = "select* from reservations where resNum = " + resNum;
		ResultSet result = stmt.executeQuery(getRes);
		java.sql.Date date = null;
		float fare = 0;
		int ogStatID = 0;
		int destStatID = 0;
		while(result.next()){
			date = result.getDate("resDate");
			fare = result.getFloat("fare");
			ogStatID = result.getInt("originStationID");
			destStatID = result.getInt("destStationID");
		}
		
		result.close();
		
		String ogStat = "";
		java.sql.Time depTime = null;
		String getOg = "select st.stopName, st.stopTime from reservations r, schedules s, stops st where r.resNum = " + resNum 
				+ " and r.scheduleNum = s.scheduleNum and s.scheduleNum = st.scheduleNum and r.originStationID = st.stationID";
		result = stmt.executeQuery(getOg);
		while(result.next()){
			ogStat = result.getString("stopName");
			depTime = result.getTime("stopTime");
		}
		result.close();
		
		String destStat = "";
		java.sql.Time arrTime = null;
		String getDest = "select st.stopName, st.stopTime from reservations r, schedules s, stops st where r.resNum = " + resNum 
				+ " and r.scheduleNum = s.scheduleNum and s.scheduleNum = st.scheduleNum and r.destStationID = st.stationID";
		result = stmt.executeQuery(getDest);
		while(result.next()){
			destStat = result.getString("stopName");
			arrTime = result.getTime("stopTime");
		}
		result.close();
%>
<tr>
<th>Reservation Number:</th>
<td><input type="text" name="resNum" value="<%=resNum%>" readonly></td>
</tr>
<tr>
<th>Transit Line Name:</th>
<td><input type="text" name="lineName" value="<%=transitLineName%>" readonly></td>
</tr>
<tr>
<th>Reservation Date:</th>
<td><input type="date" name="date" value="<%=date%>" readonly></td>
</tr>
<tr>
<th>Total Fare:</th>
<td><input type="text" name="subtotal" value="<%=fare%>" readonly></td>
</tr>
<tr>
<td>Origin Station:<input type="text" name="ogName" value="<%=ogStat%>" readonly></td>
<td>Departure Time: <input type="text" name="ogTime" value="<%=depTime%>" readonly></td>
</tr>
<tr>
<td>Destination Station:<input type="text" name="destName" value="<%=destStat%>" readonly></td>
<td>Arrival Time: <input type="text" name="destTime" value="<%=arrTime%>" readonly></td>
</tr>
<tr>
<td colspan="3">
<center>
<input type="submit" name="makeReservation" value = "Cancel" style="background-color:red;font-weight:bold;color:black;"></center>
</td>
</tr>
</table>
</form>
</body>
</html>