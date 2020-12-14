<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<button style="background-color: green; border-radius: 10px; position: absolute; top:0px; right: 20px;" onclick="window.location.href='home.jsp'">Home</button>
<button style="background-color: red; border-radius: 10px; position: absolute; top:25px; right: 20px;" onclick="window.location.href='logout.jsp'">Logout</button>

<%
	if(session.getAttribute("acctType").equals("CS")){
%>
		<button style="background-color: yellow; border-radius:10px; position: absolute; top:50px; right: 20px;" onclick="location.href='questionAnswer.jsp'">Answer Questions </button>
<% 
	}
%>

<button style="background-color: yellow; border-radius:10px; position: absolute; top:50px; right: 20px;" onclick="location.href='questionAnswer.jsp'">Answer Questions </button>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Question Page</title>
	
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
	<h2> Search, Ask, or Browse all Questions!</h2>
	<form action="questionSearch.jsp" method="post">
		<b>Search for a question:</b>
        <input type="text"  name="keyword" style = "width: 80%">
        <input type="submit" value="Search!">
    </form>
    
    
    
	<h2>Ask a Question and a Customer Representative Will Get Back to You! </h2>
		<form action="questionMessage.jsp" method="post">
			<b>Type your question here: </b>
	        <input type="text"  name="question" style = "width: 80%">
	        <input type="submit" value="Ask!">
	    </form>
    
    <h3>Click below to Browse all Questions!</h3>
    	<button type ="button" onclick="location.href='questionBrowse.jsp'">Browse!</button>
    
    
</body>
</html>

	