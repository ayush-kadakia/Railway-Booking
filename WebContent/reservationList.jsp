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
<title>Find Reservations based on Line/Date</title>
</head>
<body>
<form method="post" name="form" action="reservationListResults.jsp">
<select name="name" id="name">
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		String str = "select distinct transitLineName from schedules";
		ResultSet result = stmt.executeQuery(str);
		
		while(result.next()){

			String lineName = result.getString("transitLineName");%>
			<option value="<%=lineName%>"><%=lineName%></option>
<%		}
%>	
</select>
<label for = "Date">Date:</label>
<input type="date" name="Date" id="Date" required>
<input type="submit" name="Submit" value="Submit" style="background-color:blue;font-weight:bold;color:white;">
</form>
</body>
</html>