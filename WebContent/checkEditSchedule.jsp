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
		
		String schedName = request.getParameter("sname");
		String option = request.getParameter("ed");
		
		if(option.equals("Delete")){
			String str = "select* from schedules where transitLineName = '" + schedName + "'";
			ResultSet result = stmt.executeQuery(str);
			if(result.next() == false){
				result.close();
				out.println("Schedule not found. <a href='editSchedule.jsp'>Click here to try again</a>");
			}
			else{
				result.close();
				String del = "delete from stops where transitLineName = '" + schedName + "'";
				String del2 = "delete from schedules where transitLineName = '" + schedName + "'";
				stmt.executeUpdate(del);
				stmt.executeUpdate(del2);
				out.println("Successfully deleted the schedule. <a href='home.jsp'>Click here to return home</a> ");
			}
			
		}
		else{
			String str = "select* from schedules where transitLineName = '" + schedName + "'";
			ResultSet result = stmt.executeQuery(str);
			if(result.next() == false){
				result.close();
				out.println("Schedule not found. <a href='editSchedule.jsp'>Click here to try again</a>");
			}
			else{
				result.close(); 
			}
			
		}
		

%>
</body>
</html>