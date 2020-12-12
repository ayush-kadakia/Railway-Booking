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
<title>Edit</title>
</head>
<body>

<form method="post" name="form" action="confirmRepEdit.jsp">
<table border="1">


<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String ssn; 
		if(session.getAttribute("ssn") != null)
			ssn = (String)session.getAttribute("ssn");
		else
			ssn = request.getParameter("ssn");
		String oldssn = ssn;
		
		
		String str = "select* from login where ssn = '" + ssn + "'";
		ResultSet result = stmt.executeQuery(str);
		session.setAttribute("ssn", ssn);
		
		while(result.next()){
%>
<% String surname = result.getString("lastName");
String firstname = result.getString("firstname");
String username = result.getString("username");
String password = result.getString("password");
%>
<tr>
<th>ssn</th>
<td><input type="text" name="ssn" value="<%=ssn%>"></td>
</tr>
<tr style="display:none">
<th>oldssn</th>
<td><input type="text" name="oldssn" value="<%=oldssn%>"></td>
</tr>
<tr>
<th>Last Name</th>
<td><input type="text" name="surname" value="<%=surname%>"></td>
</tr>
<tr>
<th>First Name</th>
<td><input type="text" name="firstname" value="<%=firstname%>"></td>
</tr>
<tr>
<th>Username</th>
<td><input type="text" name="username" value="<%=username%>"></td>
</tr>
<tr>
<th>Password</th>
<td><input type="text" name="password" value="<%=password%>"></td>
</tr>
<tr>
<td><input type="submit" name="update" value="Update" style="background-color:gray;font-weight:bold;color:black;'"></td>
</tr> 
<%}%>

</table>
</form>

</body>
</html>