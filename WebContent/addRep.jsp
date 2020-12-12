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
		String ssn = request.getParameter("addSsn");
		String surname = request.getParameter("addLastname");
		String firstname = request.getParameter("addFirstname");
		String username = request.getParameter("addUsername");
		String password = request.getParameter("addPassword");
		
		String regex = "^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(ssn);
		
		if(username.contains(" ") || password.contains(" ") || password.contains("'") || username.length() <=0 || password.length() <=0 ||
				!username.matches("[a-zA-Z0-9]*")){
			con.close();
			out.println("Invalid username or password. Please refrain from using non-alphanumeric characters. <a href='editRep.jsp'>Click here to try again</a>");
		}
		else if(!(m.matches())){
			out.println("Invalid SSN. <a href='editRep.jsp'>Click here to try again</a>");	
		}
		else{
			String check = "select* from login where ssn = '" + ssn + "'";
			ResultSet result = stmt.executeQuery(check);
			
			if(result.next() == false){
				String insert = "INSERT INTO login(username, password, firstName, lastName, emailAddr, ssn, acctType)"
				+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setString(1, username);
				ps.setString(2, password);
				ps.setString(3, firstname);
				ps.setString(4, surname);		
				ps.setString(5, "NULL");
				ps.setString(6, ssn);
				ps.setString(7, "CS");
				ps.executeUpdate();
				out.println("Successfully added the customer representative's information. <a href='home.jsp'>Click here to return home</a>");			
			}
			else{
				out.println("SSN already taken. <a href='editRep.jsp'>Click here to try again</a>");
			}
		}

		
%>
</body>
</html>