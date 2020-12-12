<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
    if ((session.getAttribute("newUsername") == null)) {
%>
You have entered an invalid username. Please refrain from using non-alphanumeric characters.<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("newUsername")%>
<a href='logout.jsp'>Log out</a>
<%
    }
%>