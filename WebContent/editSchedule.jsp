<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<button style="background-color: green; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='home.jsp'">Home</button>
<button style="background-color: red; border-radius: 10px; position: absolute; top:25px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit/Delete Schedule</title>
	</head>
<body>

									
Edit/Delete a Schedule <br> <br>

<form method="post" action="checkEditSchedule.jsp">
Would you like to edit or delete a schedule?

<input type="radio" name="ed" id="r1" value="Edit" onClick="getResults()" required>Edit&nbsp;
<input type="radio" name="ed" id="r2" value="Delete">Delete&nbsp;


<div class="text">
Name of schedule: <input type="text" id="sname" name="sname"> 
</div>
<br><br><input type="submit" value="Submit">
</form>

</body>
</html>