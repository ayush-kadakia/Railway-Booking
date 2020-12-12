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
<title>Make Reservation</title>
</head>
<body>
<% 
	String og = request.getParameter("og");
	String dest = request.getParameter("dest");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String schNum = request.getParameter("schNum"); //will be submitted to reservations table
	String line = request.getParameter("lineName");
	String ogNum = request.getParameter("ogNum");
	String destNum = request.getParameter("destNum");
	String ogName = request.getParameter("ogName");
	String destName = request.getParameter("destName");
	String ogTime = request.getParameter("ogTime");
	String destTime = request.getParameter("destTime");
	String date = request.getParameter("date"); //will be submitted to reservations table
	String fare = request.getParameter("subtotal"); //will be submitted to reservations table
	
	int resNum = -1; //will be submitted to reservations table
	String getNum = "select count(resNum) num from reservations";
	ResultSet result = stmt.executeQuery(getNum);
	while(result.next()){
		resNum = result.getInt("num"); 
	}
	resNum  += 1;
	result.close();
	
%>
<script>
function changeFare() {
	var fare = <%=fare%>;;
    if (document.getElementById("ticketType").value == "round"){
    fare = fare * 2;
    if (document.getElementById("customerType").value == "adult") {
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "child") {
    	fare = fare * 0.75;
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "senior") {
        fare = fare * 0.65;
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "disabled") {
        fare = fare * 0.50;
        document.getElementById("divText").innerHTML = fare.toString();
    }
    }
    else{
        if (document.getElementById("customerType").value == "adult") {
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "child") {
    	fare = fare * 0.75;
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "senior") {
        fare = fare * 0.65;
        document.getElementById("divText").innerHTML = fare.toString();
    } else if (document.getElementById("customerType").value == "disabled") {
        fare = fare * 0.50;
        document.getElementById("divText").innerHTML = fare.toString();
    }
    
    }
}
</script>
<form method="post" name="form" action="resConfirmation.jsp?og=<%=og%>&dest=<%=dest%>">
<table>

<tr>
<th>Reservation Number:</th>
<td><input type="text" name="resNum" value="<%=resNum%>" readonly></td>
</tr>
<tr>
<th>Schedule Number:</th>
<td><input type="text" name="schNum" value="<%=schNum%>" readonly></td>
</tr>
<tr>
<th>Transit Line Name:</th>
<td><input type="text" name="lineName" value="<%=line%>" readonly></td>
</tr>
<tr>
<th>Schedule Date:</th>
<td><input type="date" name="date" value="<%=date%>" readonly></td>
</tr>
<tr>
<th>Total:</th>
<td>
<p id= "divText"><%=fare%></p>
 <input type="text" style="display:none" name="subtotal" value="<%=fare%>" readonly></td>
</tr>
<tr>
<td>Origin Stop Number: <input type="text" name="ogNum" value="<%=ogNum%>" readonly></td>
<td>Origin Station:<input type="text" name="ogName" value="<%=ogName%>" readonly></td>
<td>Departure Time: <input type="text" name="ogTime" value="<%=ogTime%>" readonly></td>
</tr>
<tr>
<td>Destination Stop Number: <input type="text" name="destNum" value="<%=destNum%>" readonly></td>
<td>Destination Station:<input type="text" name="destName" value="<%=destName%>" readonly></td>
<td>Arrival Time: <input type="text" name="destTime" value="<%=destTime%>" readonly></td>
</tr>
</table>
<label for = "customerType">Customer Type:</label>
<select name = "customerType" id = "customerType" onchange = "changeFare()" >
			<option value="adult">Adult</option>
			<option value="child">Child</option>
			<option value="senior">Senior</option>
			<option value="disabled">Disabled</option>
</select>
<label for = "ticketType">Ticket Type:</label>
<select name = "ticketType" id = "ticketType" onchange = "changeFare()" >
			<option value="one">One Way</option>
			<option value="round">Round Trip</option>
</select>
<center>
<input type="submit" name="makeReservation" value = "Make Reservation" style="background-color:gray;font-weight:bold;color:black;"></center>
</form>
</body>
</html>