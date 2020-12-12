<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Registration Screen</title>
	</head>
<body>

									
Registration Page <br> <br>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function () {
    $(".text").hide();
    $(".text2").hide();
    $("#r1").click(function () {
        $(".text").show();
        $(".text2").hide();
        $('#email').attr('required', true);
        $('#ssn').removeAttr('required');
    });
    $("#r2").click(function () {
    	$(".text2").show();
        $(".text").hide();
        $('#ssn').attr('required', true);
        $('#email').removeAttr('required');
    });
    $("#r3").click(function () {
    	$(".text2").show();
        $(".text").hide();
        $('#ssn').attr('required', true);
        $('#email').removeAttr('required');
    });
});
</script>

<form method="post" action="checkRegistration.jsp">
First Name <input type="text" name="firstname" required>
<br>
Last Name <input type="text" name="lastname" required> 
<br>
Username <input type="text" name="username" required> 
<br>
Password <input type="password" name="password" required> 
<br>
Account Type

<input type="radio" name="type" id="r1" value="Customer" onClick="getResults()" required>Customer&nbsp;
<input type="radio" name="type" id="r2" value="Admin">Admin&nbsp;
<input type="radio" name="type" id="r3" value="CS">Customer Representative 

<div class="text">
Email <input type="email" id="email" name="email"> 
</div>

<div class="text2">
SSN <input type="text" id="ssn" name="ssn"> 
</div>
<br><br><input type="submit" value="Submit">
</form>

</body>
</html>