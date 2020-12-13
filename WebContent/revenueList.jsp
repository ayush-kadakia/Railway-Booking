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
<title>Admin Res List</title>
</head>
<body>
<input type="radio" name="type" id="r1" value="Transit Line" onClick="getResults()" required>Transit Line&nbsp;
<input type="radio" name="type" id="r2" value="Customer Name">Customer Name&nbsp;

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    $(".table").hide();
    $(".table2").hide();
    $("#r1").click(function () {
        $(".table").show();
        $(".table2").hide();
    });
    $("#r2").click(function () {
    	$(".table2").show();
        $(".table").hide();
    });
});
</script>

<div class="table">
<table id="transit" border="1">
<caption><b><u>Revenue List by Transit Line</u></b></caption>
<tr>
<th>Transit Line Name</th>
<th>Total Revenue</th>
</tr>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();

	String best = "select s.transitLineName, sum(r.fare) totalRev from schedules s, reservations r where s.scheduleNum = r.scheduleNum and r.status <> 'canceled'  group by s.transitLineName";
	ResultSet result = stmt.executeQuery(best);
	String transitLineName = "";
	float totalRev = -1;
	while(result.next()){
		transitLineName = result.getString("transitLineName");
		totalRev = result.getFloat("totalRev");
%>
<tr>
<td><%=transitLineName%></td>
<td><%=totalRev%></td>
</tr>
<%}%>
</table>
</div>
<div class="table2">
<table id="customer" border="1">
<caption><b><u>Revenue List by Customer Name</u></b></caption>
<tr>
<th>First Name</th>
<th>Last Name</th>
<th>Customer Name</th>
<th>Total Revenue</th>
</tr>
<%
	ApplicationDB db1 = new ApplicationDB();	
	Connection con1 = db1.getConnection();

	//Create a SQL statement
	Statement stmt1 = con1.createStatement();

	String best1 = "select u.lastName, u.firstName, u.username, sum(r.fare) totalRev from login u, reservations r where u.username = r.username and r.status <> 'canceled'  group by u.username order by totalRev DESC";
	ResultSet result1 = stmt1.executeQuery(best1);
	String customerName = "";
	String firstName = "";
	float totalRev1 = -1;
	String lastName = "";
	while(result1.next()){
		lastName = result1.getString("lastName");
		firstName = result1.getString("firstName");
		customerName = result1.getString("username");
		totalRev1 = result1.getFloat("totalRev");
%>
<tr>
<td><%=firstName%></td>
<td><%=lastName%></td>
<td><%=customerName%></td>
<td><%=totalRev1%></td>
</tr>
<%}%>
</table>
</div>
</body>
</html>