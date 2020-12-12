<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Home Page</title>
	</head>
<body>

<button style="background-color: red; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>

<input type = "button" value = "Browse All Train Schedules" onClick = "javascript:window.location='searchSchedules.jsp'">
<%
    if(session.getAttribute("acctType").equals("Customer")) {
%>
<input type = "button" value = "View Current Reservations" onClick = "javascript:window.location='viewCurrentRes.jsp'">
<input type = "button" value = "View Past Reservations" onClick = "javascript:window.location='viewPastRes.jsp'">
<input type = "button" value = "Browse Questions/Answers" onClick = "javascript:window.location='questionList.jsp'">


<%
	} else if(session.getAttribute("acctType").equals("Admin")){
%>
<input type = "button" value = "Add/Edit/Delete Customer Rep Info" onClick = "javascript:window.location='editRep.jsp'">
<input type = "button" value = "Best Customer" onClick = "javascript:window.location='bestCustomer.jsp'">
<input type = "button" value = "Sales Reports" onClick = "javascript:window.location='salesReport.jsp'">
<input type = "button" value = "Revenue List" onClick = "javascript:window.location='revenueList.jsp'">
<input type = "button" value = "Most Active Lines" onClick = "javascript:window.location='mostActiveLines.jsp'">
<input type = "button" value = "List of Reservations" onClick = "javascript:window.location='adminReservationList.jsp'">


<%
	} else if(session.getAttribute("acctType").equals("CS")){
%>
<input type = "button" value = "Edit Train Schedule Information" onClick = "javascript:window.location='editSchedule2.jsp'">
<input type = "button" value = "Answer Customer Questions" onClick = "javascript:window.location='questionList.jsp'">
<input type = "button" value = "Train Schedules by Station" onClick = "javascript:window.location='scheduleList.jsp'">
<input type = "button" value = "Reservations by transit line" onClick = "javascript:window.location='reservationList.jsp'">
<%
    }
%>

</body>
</html>