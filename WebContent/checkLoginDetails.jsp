<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
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
		
		if(newUsername.contains(" ") || newPassword.contains(" ") || newPassword.contains("'") || newUsername.length() <=0 || newPassword.length() <=0 ||
				!newUsername.matches("[a-zA-Z0-9]*")){
			con.close();
			out.println("Invalid username or password. Please refrain from using non-alphanumeric characters. <a href='login.jsp'>Click here to try again</a>");
		}
		else{
		//check in the db if the usr exists
			String str = "SELECT username FROM login where username = '" + newUsername + "' AND password = '" + newPassword + "'";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			
		//Make an insert statement for the login table:
			if(result.next() == false){ //pasword and username not found
				result.close();
				String str2 = "SELECT username FROM login where username = '" + newUsername + "'";
				ResultSet result2 = stmt.executeQuery(str2);
				if(result2.next() == false){ // username not in database
					//String insert = "INSERT INTO login(username, password)"
							//+ "VALUES (?, ?)";

					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					//PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					//ps.setString(1, newUsername);
					//ps.setString(2, newPassword);
					//ps.executeUpdate();
					
					//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
					//con.close();
					//session.setAttribute("newUsername", newUsername);
					//out.println("Welcome " + newUsername + ". You have successfully created a new account.");
			        //out.println("<a href='logout.jsp'>Log out</a>");
			        //response.sendRedirect("success2.jsp");
					out.println("Username not found. <a href='register.jsp'>Click here to create an account.</a>");
				}
				else
					out.println("Incorrect password. <a href='login.jsp'>Click here to try again.</a>");
			}
			else{
				result.close();
				String str3 = "SELECT acctType FROM login where username = '" + newUsername + "'";
				ResultSet result3 = stmt.executeQuery(str3);
				result3.next();
				String acctType = result3.getString("acctType");
				session.setAttribute("newUsername", newUsername);
				session.setAttribute("acctType", acctType);
				result.close();
				response.sendRedirect("home.jsp");
				//if(acctType.equals("Customer"))
					//response.sendRedirect("customerHome.jsp");
				//else if(acctType.equals("Admin"))
					//response.sendRedirect("adminHome.jsp");
				//else
		        	//response.sendRedirect("repHome.jsp");
			}
		}
	} catch (Exception ex) {
		out.print(ex);
		out.print("Incorrect Password.");
	}
%>
</body>
</html>