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
<title>Best Customer</title>
</head>
<body>

<table border="1">
<caption><b><u>Best Customer</u></b></caption>
<tr>
<th>Username</th>
<th>Last Name</th>
<th>Last Name</th>
<th>Reservations Made</th>
<th>Total Spent</th>
</tr>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();

	String best = "select firstName, lastName, username, numRes, totalSpent from (select u.firstName, u.lastName, u.username, count(r.resNum) numRes, sum(r.fare) totalSpent from login u, reservations r where u.username = r.username and r.status <> 'canceled' group by u.username) b where totalSpent = (select max(totalSpent) from (select u.firstName, u.lastName, u.username, count(r.resNum) numRes, sum(r.fare) totalSpent from login u, reservations r where u.username = r.username and r.status <> 'canceled' group by u.username) b2 )";
	ResultSet result = stmt.executeQuery(best);
	String username = "";
	String firstName = "";
	String lastName = "";
	int numRes = -1;
	float totalSpent = -1;
	while(result.next()){
		username = result.getString("username");
		firstName = result.getString("firstName");
		lastName = result.getString("lastName");
		numRes = result.getInt("numRes");
		totalSpent = result.getFloat("totalSpent");
	}
%>
<tr>
<td><%=username%></td>
<td><%=lastName%></td>
<td><%=firstName%></td>
<td><%=numRes%></td>
<td><%=totalSpent%></td>
</tr>
</table>

</body>
</html>