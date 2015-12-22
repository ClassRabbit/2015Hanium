<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date" %>
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
<style type="text/css">
	.margin{
		margin: 0 auto;
		width: 50%;	
	}
</style>
</head>
<%
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String find_begin = "";
	String find_end = "";
	Date find_begin_D = null;
	Date find_end_D = null;
	Calendar find_begin_C = null;
	Calendar find_end_C = null;

	
	if(session.getAttribute("find_begin") != null && session.getAttribute("find_end") != null) 
	{
		find_begin = (String)session.getAttribute("find_begin");
		find_end = (String)session.getAttribute("find_end");
		
		find_begin_D = simpleDate.parse(find_begin);
		find_end_D = simpleDate.parse(find_end);
		
		find_begin_C = Calendar.getInstance();
		find_end_C = Calendar.getInstance();
		
		find_begin_C.setTime(find_begin_D);
		find_end_C.setTime(find_end_D);
	}
	else
	{
		Date today = new Date();
		
		
		find_begin = simpleDate.format(today);
		find_end = simpleDate.format(today);
		
		find_begin_D = simpleDate.parse(find_begin);
		find_end_D = simpleDate.parse(find_end);
		
		find_begin_C = Calendar.getInstance();
		find_end_C = Calendar.getInstance();
		
		find_begin_C.setTime(find_begin_D);
		find_end_C.setTime(find_end_D);
	}
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;

	String id = (String)session.getAttribute("id");
	String state = "";
	String time = "";

	int counter = 0;
	if(id == null)
	{
		response.sendRedirect("LoginCheck.jsp");
	}
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
	     			<li><a href="Control.jsp">리모콘</a></li>
	     			<li class="active"><a href="Statistics.jsp">기록</a></li>
	    		</ul>
	    		<ul class="nav navbar-nav navbar-right">
	     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
	            	<li><a href="Logout.jsp">로그아웃</a></li>
	    		</ul>
			</div>
		</div>
  	</nav>


<div class="container">
	<center><h1>선풍기</h1></center>
	</br>
<%
	if(request.getAttribute("error") != null)
	{
%>
		<div class="alert alert-danger">
			<strong>날짜 범위가 잘못되었습니다.</strong> 
		</div>
<%	
	}
%>
	<form method=post action="StatisticsCheck.jsp">
		<input type="hidden" name="from" value="fan">	
	 	<div class="row">
			<div class="col-sm-1"></div>
			<center><input type="date" class="col-sm-3" name="find_begin" value="<%=find_begin%>"></center>
			<center><span class="col-sm-1"><b>~</b></span></center>
			<center><input type="date" class="col-sm-3" name="find_end" value="<%=find_end%>"></center>
			<div class="col-sm-1"></div>
			<center><input class="btn btn-primary col-sm-2" type="submit" value="검색"></center>
		</div>
	</form>
	</br>
	<div style="height:700px; overflow: auto;">
		<table class="table table-striped table-hover ">
			<thead>
				<tr>
					<th>#</th>
                   	<th>상태</th>
                   	<th>시간</th>
               	</tr>
           	</thead>
            <tbody>
<%
			try
			{
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome","root","Shome");
				stmt = conn.createStatement();
				System.out.println(""+find_end_C.compareTo(find_begin_C));
				while(find_end_C.compareTo(find_begin_C) >= 0 )
				{
					simpleDate = new SimpleDateFormat("yyyy-MM-dd");
					rs = stmt.executeQuery("SELECT * FROM fan_log WHERE time like '" + simpleDate.format(find_end_C.getTime()) + "%' ORDER BY time DESC;");
					
					while(rs.next())
					{
						state = rs.getString("state");
						time = rs.getString("time");
						counter++;
%>
	                
	         		<tr>
	                    <td><%=counter %></td>
<%
						if(state.equals("Y"))
						{
%>
							<td>ON</td>
<%
						}
						else if(state.equals("N"))
						{
%>
							<td>OFF</td>
<%
						}
%>
	                    <td><%=time %></td>
<%
					}
					find_end_C.add(Calendar.DATE, -1);
				}
				

%> 
				</tr>
			</tbody>
		</table>
	</div>	
<%
	
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
</body>
</html>