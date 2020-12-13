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
<title>Most Active Lines</title>
</head>
<body>

<table border="1">
<caption><b><u>Most Active Transit Lines</u></b></caption>
<tr>
<th>Rank</th>
<th>Transit Line Name</th>
<th>Number of Reservations</th>
</tr>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();

	String best = "select s.transitLineName, count(r.resNum) numRes from schedules s, reservations r where s.scheduleNum = r.scheduleNum and r.status <> 'canceled'  group by s.transitLineName order by numRes DESC";
	ResultSet result = stmt.executeQuery(best);
	String transitLineName = "";
	int numRes = -1;
	int i = 1;
	while(result.next() && i < 6){
		transitLineName = result.getString("transitLineName");
		numRes = result.getInt("numRes");
%>
<tr>
<td><%=i%></td>
<td><%=transitLineName%></td>
<td><%=numRes%></td>
</tr>
<%		i++;}%>
</table>

</body>
</html>