<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New User</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the index.jsp
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("password");
		
		if(newUsername.contains(" ") || newPassword.contains(" ") || newPassword.contains("'") ||  !newUsername.matches("[a-zA-Z0-9]*")){
			con.close();
			out.println("Invalid username or password. Please refrain from using non-alphanumeric characters. <a href='register.jsp'>Click here to try again</a>");
		}
		else if(newUsername.length() > 45 || newPassword.length() > 45){
			con.close();
			out.println("Invalid username or password. Username and password can be at mostcharacters each. <a href='register.jsp'>Click here to try again</a>");
		}
		else{
		
		//"^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$"	
		//check in the db if the usr exists
			String str = "SELECT username FROM login where username = '" + newUsername + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		//Make an insert statement for the login table:
			if(result.next() == false){ //username does not exist
				String firstName = request.getParameter("firstname");
				String lastName = request.getParameter("lastname");
				String accountType = request.getParameter("type");
				result.close();
				if(firstName.length() > 25 || lastName.length() > 25){
					out.println("Invalid first or last name. First and last name can be at most 25 characters each.<a href='register.jsp'>Click here to try again</a>");
				}
				if(accountType.equals("Customer")){
					String emailAddr = request.getParameter("email");
					String str2 = "SELECT emailAddr FROM login where emailAddr = '" + emailAddr + "'";
					result = stmt.executeQuery(str2);
					if(result.next() == false){
						result.close();
						if(emailAddr.length() > 50)
							out.println("Invalid email address. Email address must not be blank and can be at most 50 characters. <a href='register.jsp'>Click here to try again</a>");
						else{
							String insert = "INSERT INTO login(username, password, firstName, lastName, emailAddr, ssn, acctType)"
									+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, newUsername);
							ps.setString(2, newPassword);
							ps.setString(3, firstName);
							ps.setString(4, lastName);		
							ps.setString(5, emailAddr);
							ps.setString(6, "NULL");
							ps.setString(7, accountType);
							ps.executeUpdate();
							session.setAttribute("newUsername", newUsername);
							session.setAttribute("acctType", accountType);
							out.println("You've succesfully created a new account. <a href='home.jsp'>Click here to be redirected to the homepage.</a>");
						}	
					}
					else{
						result.close();
						out.println("Email address already taken. <a href='register.jsp'>Click here to try again</a>");
					}
				}
				else if(accountType.equals("Admin")){
					String ssn = request.getParameter("ssn");
					String regex = "^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$";
					Pattern p = Pattern.compile(regex);
					Matcher m = p.matcher(ssn);
					if(!(m.matches()))
						out.println("Invalid SSN. <a href='register.jsp'>Click here to try again</a>");
					else{
						String str3 = "SELECT ssn FROM login where ssn = '" + ssn + "'";
						result = stmt.executeQuery(str3);
						if(result.next() == false){
							result.close();
							String insert = "INSERT INTO login(username, password, firstName, lastName, emailAddr, ssn, acctType)"
									+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, newUsername);
							ps.setString(2, newPassword);
							ps.setString(3, firstName);
							ps.setString(4, lastName);		
							ps.setString(5, "NULL");
							ps.setString(6, ssn);
							ps.setString(7, accountType);
							ps.executeUpdate();
							session.setAttribute("newUsername", newUsername);
							session.setAttribute("acctType", accountType);
							out.println("You've succesfully created a new account. <a href='home.jsp'>Click here to be redirected to the homepage.</a>");		
						}
						else{
							result.close();
							out.println("SSN already taken. <a href='register.jsp'>Click here to try again</a>");
						}
					}
					
				}
				else{
					String ssn = request.getParameter("ssn");
					String regex = "^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$";
					Pattern p = Pattern.compile(regex);
					Matcher m = p.matcher(ssn);
					if(!(m.matches()))
						out.println("Invalid SSN. <a href='register.jsp'>Click here to try again</a>");
					else{
						String str4 = "SELECT ssn FROM login where ssn = '" + ssn + "'";
						result = stmt.executeQuery(str4);
						if(result.next() == false){
							String insert = "INSERT INTO login(username, password, firstName, lastName, emailAddr, ssn, acctType)"
									+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
							PreparedStatement ps = con.prepareStatement(insert);
							ps.setString(1, newUsername);
							ps.setString(2, newPassword);
							ps.setString(3, firstName);
							ps.setString(4, lastName);		
							ps.setString(5, "NULL");
							ps.setString(6, ssn);
							ps.setString(7, accountType);
							ps.executeUpdate();
							session.setAttribute("newUsername", newUsername);
							session.setAttribute("acctType", accountType);
							out.println("You've succesfully created a new account. <a href='home.jsp'>Click here to be redirected to the homepage.</a>");
						}
						else{
							result.close();
							out.println("SSN already taken. <a href='register.jsp'>Click here to try again</a>");
						}
					}
				}
			}
			else{
				out.println("Username already taken. <a href='login.jsp'>Click here to try again.</a>");
			}
		}
	} catch (Exception ex) {
		out.print(ex);
		out.print("Incorrect Password.");
	}
%>
</body>
</html>