<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit/Delete Schedule</title>
</head>
<body>
<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String ssn = request.getParameter("ssn");
		String oldssn = request.getParameter("oldssn");
		String surname = request.getParameter("surname");
		String firstname = request.getParameter("firstname");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		String regex = "^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(ssn);
		
		if(username.contains(" ") || password.contains(" ") || password.contains("'") || username.length() <=0 || password.length() <=0 ||
				!username.matches("[a-zA-Z0-9]*")){
			con.close();
			out.println("Invalid username or password. Please refrain from using non-alphanumeric characters. <a href='editRepInfo.jsp'>Click here to try again</a>");
		}
		else if(!(m.matches())){
			out.println("Invalid SSN. <a href='editRepInfo.jsp'>Click here to try again</a>");	
		}
		else{
			String comm = "update login set ssn = '" + ssn + "', lastName = '" + surname + "', firstName = '" + firstname + "', username = '" + username + "', password = '" 
			+ password + "' where ssn = '" + oldssn + "'";
					
			stmt.executeUpdate(comm);
			out.println("Successfully updated the customer representative's information. <a href='home.jsp'>Click here to return home</a>");				
		}

		
%>
</body>
</html>