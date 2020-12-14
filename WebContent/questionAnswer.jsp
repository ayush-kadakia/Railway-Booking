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
	<title>Browse Page</title>
	
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
		<h2> You are Browsing all Questions</h2>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a statement for the question table:
		String str = "SELECT * FROM questions";
	   	
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ResultSet result = stmt.executeQuery(str);
		
		while(result.next()) {
			%>
			<div class="container">
	  		<p><%out.print("(QuestionID=" + result.getString("questionID") + ")" + result.getString("question"));%></p>
			</div>
			<div class="container darker">
	 		 <p><%
	 		 
	 		 if(result.getString("answer") == null){
	 			out.print("This question has not been answer by a customer representative yet!");
	 		 }else{
	 			out.print(result.getString("answer"));
	 		 }
	 		 %></p>
			</div>
		<%
		}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	
		//Close the connection. Don't forget to it, otherwise you're keeping the resources of the server allocated.
	} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
	}
%>
	
	<button type="button" onclick="location.href = 'questionList.jsp'">Go Back</button> 
	
	<h3>To answer a question please enter valid questionID followed by a space then your answer!</h3>
		<form action="questionAnswerUpdate.jsp" method="post">
			<b>Type your answer here: </b>
	        <input type="text"  name="CSanswer" style = "width: 80%">
	        <input type="submit" value="Answer!">
	    </form>
   
	</body>
</html>