<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Shome 컨트롤러</title>
</head>
<%
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String id = (String)session.getAttribute("id");
	String light_state = "";
	String fan_state = "";
	String light_IP = (String)session.getAttribute("light_IP");
	String fan_IP = (String)session.getAttribute("fan_IP");
	int counter = 0;
	if(id == null)
	{
		response.sendRedirect("LoginCheck.jsp");
	}
	else
	{
		try
		{
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
					"root","Shome");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM light;");
%>



<body>
	<nav class="navbar navbar-default"><!--메뉴관련 더 있음-->
		<div class="container">
	  		<div class="navbar-header">
	    		<button class="navbar-toggle" data-toggle="collapse" data-target=".target"><!--모바일일경우-->
	    			<span class="icon-bar"></span>
	    			<span class="icon-bar"></span>
	    			<span class="icon-bar"></span>
	    		</button>
	    		<a class="navbar-brand" href="Introduce_in.jsp">Shome</a>
	   		</div>
	 		<div class="collapse navbar-collapse target"><!--숨겨지는부분-->
	    		<ul class="nav navbar-nav">
	     			<li class="active"><a href="#">리모콘</a></li>
	     			<li><a href="Statistics.jsp">기록</a></li>
	    		</ul>
	    		<ul class="nav navbar-nav navbar-right">
	     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
	            	<li><a href="Logout.jsp">로그아웃</a></li>
	    		</ul>
			</div>
		</div>
  	</nav>
			

<%
			rs.next();
			light_state = rs.getString("state");
			if(light_state.equals("Y"))
			{
%>
				<iframe name="arduino" src="http://<%=light_IP %>/ON1" style="display: none;" width = "0" height= "0"></iframe>
<% 
			}
			else
			{
%>
				<iframe name="arduino" src="http://<%=light_IP %>/OFF1" style="display: none;" width = "0" height= "0"></iframe>
<%
			}
			rs = stmt.executeQuery("SELECT * FROM fan;");
			rs.next();
			fan_state = rs.getString("state");
			if(fan_state.equals("Y"))
			{
%>
				<iframe name="arduino" src="http://<%=fan_IP %>/ON2" style="display: none;" width = "0" height= "0"></iframe>
<% 
			}
			else
			{
%>
				<iframe name="arduino" src="http://<%=fan_IP %>/OFF2" style="display: none;" width = "0" height= "0"></iframe>
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
	}
%>
<div class="container">
	<div class="row">
		<div class="col-md-6">
			<div class="row">
			<div class="col-md-6">
			</div>
			<div class="col-md-6">
			<form method=post action="LightChange.jsp">
<%
				if(light_state.equals("Y"))
				{
%>
					<input type="hidden" name="state" value="<%=light_state%>">
					<center><input type="image" src="img/light_on.jpg" name="Submit" value="Submit" ></center>
		
<%
				}
				else
				{
%>
					<input type="hidden" name="state" value="<%=light_state%>">		
					<center><input type="image" src="img/light_off.jpg" name="Submit" value="Submit"></center>
		
<%
				}
%>
			</form>
			</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="row">
			<div class="col-md-6">
			<form method=post action="FanChange.jsp">
<%
				if(fan_state.equals("Y"))
				{
%>
					<input type="hidden" name="state" value="<%=fan_state%>">		
					<center><input type="image" src="img/fan_on.jpg" name="Submit" value="Submit"  align="middle"></center>
		
<%
				}
				else
				{
%>
					<input type="hidden" name="state" value="<%=fan_state%>">			
					<center><input type="image" src="img/fan_off.jpg" name="Submit" value="Submit"  align="middle"></center>
		
<%
				}
%>
			</form>
			</div>
			<div class="col-md-6">
			</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
		</div>
		<div class="col-md-1">
		</div>
		<div class="col-md-1">
		</div>
		<div class="col-md-1">
		</div>
		<div class="col-md-1">
			<center><iframe src=Pi_volumUp.jsp style="border:none; height: 60px; width: 60px"></iframe></center>
			<center><iframe src=Pi_volumDown.jsp style="border:none; height: 60px; width: 60px"></iframe></center>
		</div>
		<div class="col-md-1">
			<center><iframe src=Pi_run.jsp style="border:none; height: 100px; width: 100px"></iframe></center>
		</div>
		<div class="col-md-1">
			<center><iframe src=Pi_next.jsp style="border:none; height: 100px; width: 100px"></iframe></center>
		</div>
		<div class="col-md-1">
			<center><iframe src=Pi_stop.jsp style="border:none; height: 100px; width: 100px"></iframe></center>
		</div>
	</div>
	
	<div style="height:80px;">
	</div>
</div>

</body>
</html>