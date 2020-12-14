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
	<title>CS answer page</title>
	
		<style>
			body {
			  margin: 0 auto;
			  max-width: 800px;
			  padding: 0 20px;
			  background-color: #d7d7d7;
			}
			
			.container {
			  border: 2px solid #dedede;
			  background-color: #f1f1f1;
			  border-radius: 5px;
			  padding: 10px;
			  margin: 10px 0;
			}
			
			.darker {
			  border-color: #ccc;
			  background-color: #ddd;
			}
			
			</style>
	</head>
	<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at questionAnswer.jsp
		String entry = request.getParameter("CSanswer");
		
		
		System.out.println(entry);
		
		
		String[] split = entry.split("\\s", 2);
		String qid = split[0];
		String answer = split[1];
		System.out.println(qid);
		System.out.println(answer);
		

		//Make an insert statement:
		String update = "UPDATE questions SET answer='" + answer + "' WHERE questionID="+qid;
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(update);
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
	} catch (Exception ex) {
		out.print(ex);
		out.print("update failed");
	}
	request.getRequestDispatcher("questionAnswer.jsp").forward(request, response);
%>	
    
    
	</body>
</html>