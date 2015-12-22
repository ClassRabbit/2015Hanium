<%@page import="javax.websocket.Session"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//String id = (String)request.getAttribute("id");
	String id = (String)session.getAttribute("id");
	String state = "";
	String light_IP = (String)session.getAttribute("light_IP");
	int counter = 0;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM light;");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Shome 컨트롤러</title>
<style type="text/css">
	.wrap {
		width: 100%;
		height: 120%;
		position: relative;
		<!-- background-color: blue; -->
	}
	.margin-center {
		margin: 0 auto;
		width: 50%;	
	}
	.margin-img {
		margin: 0 auto;
		width: 200px;
		height: 230px;	
		<!-- background-color: black; -->
	}
</style>
</head>
<body>
	<nav class="navbar navbar-default"><!--메뉴관련 더 있음-->
  		<div class="navbar-header">
    		<button class="navbar-toggle" data-toggle="collapse" data-target=".target"><!--모바일일경우-->
    			<span class="icon-bar"></span>
    			<span class="icon-bar"></span>
    			<span class="icon-bar"></span>
    		</button>
    		<a class="navbar-brand" href="#">Shome</a>
   		</div>
 		<div class="collapse navbar-collapse target"><!--숨겨지는부분-->
    		<ul class="nav navbar-nav">
     			<li class="active"><a href="#">전등</a></li>
     			<li><a href="Statistics.jsp">통계</a></li>
    		</ul>
    		<ul class="nav navbar-nav navbar-right">
     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
            	<li><a href="Logout.jsp">로그아웃</a></li>
    		</ul>
		</div>
  	</nav>
<div class="wrap">
	<div class="margin-img">
<%
		rs.next();
		state = rs.getString("state");
		if(state.equals("Y"))
		{
	%>
			<iframe name="arduino" src="http://<%=light_IP %>/ON1" style="display: none;" width = "0" height= "0"></iframe>
			<img src="light_on.jpg" alt="light_on" width="200" height="200">
	<% 
		}
		else
		{
	%>
			<iframe name="arduino" src="http://<%=light_IP %>/OFF1" style="display: none;" width = "0" height= "0"></iframe>
			<img src="light_off.jpg" alt="light_off" width="200" height="200">
<%
		}
	}
	catch(SQLException e)
	{
	%>
		SQLException!
	<%
	}
	catch(Exception e)
	{
	%>
		Exception!
	<%
	}
	finally
	{
		if(rs!=null)
		{
			try
			{
				rs.close();
			}
			catch(SQLException e)
			{
			}
		}
		if(stmt != null)
		{
			try
			{
				stmt.close();
			}
			catch(SQLException e)
			{
			}
			if(conn != null)
			{
				try
				{
					conn.close();
				}
				catch(Exception e)
				{
				}
			}
		}
	}
	%>
	</div>
</div>
<div class="margin-center">
	<form method=post action="LightChange.jsp">
	<%
		if(state.equals("Y"))
		{
	%>
			<input type="hidden" name="state" value="<%=state%>">
			<input type="hidden" name="id" value="<%=id %>">
			
			<input class="btn btn-lg btn-info btn-block" type="submit" value="끄기">
	<%
		}
		else
		{
	%>
			<input type="hidden" name="state" value="<%=state%>">
			<input type="hidden" name="id" value="<%=id %>">
			
			<input class="btn btn-lg btn-info btn-block" type="submit" value="켜기">
	<%
		}
	%>
	</form>
</div>
</body>
</html>