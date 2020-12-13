<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.regex.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<button style="background-color: green; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='home.jsp'">Home</button>
<button style="background-color: red; border-radius: 10px; position: absolute; top:25px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>
<head>
<meta charset="ISO-8859-1">
<title>Admin Reservation List</title>
</head>
<body>
<form method="post" name="form" action="adminResListBuffer.jsp">
<input type="radio" name="type" id="r1" value="Transit Line" onClick="getResults()" required>Transit Line&nbsp;
<input type="radio" name="type" id="r2" value="Customer Name">Customer Name&nbsp;
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    $(".transitDropdown").hide();
    $(".customerDropdown").hide();
    $("#r1").click(function () {
        $(".transitDropdown").show();
        $(".customerDropdown").hide();
        $('#transitLineName').attr('required', true);
        $('#customerName').removeAttr('required');
    });
    $("#r2").click(function () {
    	$(".customerDropdown").show();
        $(".transitDropdown").hide();
        $('#customerName').attr('required', true);
        $('#transitLineName').removeAttr('required');
    });
});
</script>
<div class="transitDropdown">
<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str = "select s.transitLineName from schedules s, reservations r where s.scheduleNum = r.scheduleNum group by s.transitLineName";
		ResultSet result = stmt.executeQuery(str);
%>

<select name = "transitLineName" id="transitLineName"><%

		
		while(result.next()){
			String name = result.getString("transitLineName");%>
			<option value="<%=name%>"><%=name%></option>
<%		}
		result.close();
%>

</select>
</div>

<div class="customerDropdown">
<%
		ApplicationDB db1 = new ApplicationDB();	
		Connection con1 = db1.getConnection();

		//Create a SQL statement
		Statement stmt1 = con1.createStatement();
		
		String str1 = "select r.username from reservations r group by r.username";
		ResultSet result1 = stmt1.executeQuery(str1);
%>

<select name = "customerName" id="customerName"><%

		
		while(result1.next()){
			String name1 = result1.getString("username");%>
			<option value="<%=name1%>"><%=name1%></option>
<%		}
		result1.close();
%>

</select>
</div>
<input type="submit" name="Submit" value="Submit" style="background-color:blue;font-weight:bold;color:white;">
</form>
</body>
</html>