<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String year = "";
	String month = "";
	String day = "";
	if(session.getAttribute("year") != null) 
	{
		year = (String)session.getAttribute("year");
		month = (String)session.getAttribute("month");
		day = (String)session.getAttribute("day");
	}
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//String id = (String)request.getAttribute("id");
	String id = (String)session.getAttribute("id");
	String state = "";
	String time = "";
	String time_now = "";
	Date  begin_date = null;
	Date  end_date = null;
	long r_hour = 0;
	long r_min = 0;
	long r_sec = 0;
	long r_msec = 0;
	long resultTime = 0;
	int counter = 0;
	try
	{
		GregorianCalendar calendar = new GregorianCalendar();
		if(year.equals("%") ||  year.equals(""))
		{
			time_now += "%" + "-";
		}
		else
		{
			time_now += year + "-";
		}
		if(month.equals("%") ||  month.equals(""))
		{
			time_now += "%" + "-";
		}
		else
		{
			if(Integer.parseInt(month) <10)
			{
				time_now += "0" + month + "-";
			}
			else
			{
				time_now += month + "-";
			}
		}
		if(day.equals("%") ||  day.equals(""))
		{
			time_now += "%";
		}
		else
		{
			if(Integer.parseInt(day) <10)
			{
				time_now += "0" + day;
			}
			else
			{
				time_now += day;
			}
		}
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM light_log WHERE time like '" + time_now + "%';");
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

	.container {
		width:30%;
	}
	.wrap {
		width: 100%;
		height: 120%;
		position: relative;
		<!-- background-color: blue; -->
	}
	.margin-center {
		margin: 0 auto;
		width: 70%;	
	}
	.margin-text {
		margin: 8%;
		right: 
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
     			<li><a href="Control.jsp">리모콘</a></li>
     			<li class="active"><a href="#">통계</a></li>
    		</ul>
    		<ul class="nav navbar-nav navbar-right">
     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
            	<li><a href="Logout.jsp">로그아웃</a></li>
    		</ul>
		</div>
  	</nav>


<div class="margin-center">
	<form method=post action="StatisticsCheck.jsp">
	 	<ul class="nav nav-pills">
			<li class="container">
				<select class="form-control" name="year">
<% 
						for(int i = 2015; i<=2030; i++)
						{
							if(year.equals(""+i))
							{
%>
								<option selected value="<%=i%>"><%=i %></option>
<%
							}
							else
							{
%>
								<option value="<%=i%>"><%=i %></option>
<%
							}
						}
%>
				</select>
			</li>
			<li class="container">
				<select class="form-control" name="month">
					<option value="%">전체</option>
<% 
					for(int i = 1; i<=12; i++)
					{
						if(month.equals(""+i))
						{
%>
							<option selected value="<%=i%>"><%=i %></option>
<%
						}
						else
						{
%>
							<option value="<%=i%>"><%=i %></option>
<%
						}
					}
%>
				</select>
			</li>
			<li class="container">
				<select class="form-control" name="day">
					<option value="%">전체</option>
<% 
					for(int i = 1; i<=31; i++)
					{
						if(day.equals(""+i))
						{
%>
							<option selected value="<%=i %>"><%=i %></option>
<%
						}
						else
						{
%>
							<option value="<%=i %>"><%=i %></option>
<%
						}
					}
%>
				</select>
			</li>
			<li>
				<input class="btn btn-info" type="submit" value="검색">
			</li>
		</ul>	
	</form>
	
	
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
				while(rs.next() && counter<5)
				{
					state = rs.getString("state");
					time = rs.getString("time");
					counter++;
%>
                
         	<tr>
                    <td><%=counter %></td>
                    <td><%=state %></td>
                    <td><%=time %></td>
<%
					SimpleDateFormat simpeDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:SS");
					if(state.equals("Y"))
					{
						try {
					        begin_date = simpeDate.parse(time);
					    } catch (ParseException e) {
					        e.printStackTrace();
					    }
					}
					else
					{
						try 
						{
					        end_date = simpeDate.parse(time);
					    } 
						catch (ParseException e) 
						{
					        e.printStackTrace();
						}
						if(begin_date != null)
						{
							resultTime += end_date.getTime() - begin_date.getTime();
						}
					}    
				}
%>
			</tbody>
		</table>
			
			
<%
				r_hour = resultTime/(60*60*100);
				resultTime = resultTime%(60*60*100);
				r_min = resultTime/(60*100);
				resultTime = resultTime%(60*100);
				r_sec = resultTime/100;
				r_msec = resultTime%100;
				String resultStr = "총 사용시간은 ";
				if(r_hour > 0)
				{
					resultStr += r_hour + "시간 ";
				}
				if(r_min > 0)
				{
					resultStr += r_min + "분 ";
				}
				if(r_sec > 0)
				{
					resultStr += r_sec + "초 ";
				}
				if(r_msec > 0)
				{
					resultStr += r_msec + " ";
				}
				resultStr += "ms 입니다.";
				
%>
			<center><h3 class="margin-text"><%=resultStr %></h3></center>
			<div class="progress-bar progress-bar-danger" style="width: 80%"></div>
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