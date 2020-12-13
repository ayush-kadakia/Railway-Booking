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
<title>Sales Report</title>
</head>
<body>
<table id="reservationList" border="1">
<caption><b><u>Sales Report</u></b></caption>
<tr>
<th>Month</th>
<th>Sales</th>
</tr>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();

	String str = "select sum(fare) as rev, month(resDate) as month from reservations where status <> 'canceled' group by month(resDate)";
	
	ResultSet result = stmt.executeQuery(str);

	
	String month = "";
	float sales = -1;
	String[] arr = new String[]{"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
	while(result.next()){
		month = result.getString("month");
		sales = result.getFloat("rev");
%>
<tr>
<td><%=arr[(Integer.parseInt(month))-1]%></td>
<td><%=sales%></td>
</tr>
<%}%>
</table>
</body>
</html>