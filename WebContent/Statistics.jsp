<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date" %>
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
	String today_S = "";
	Date today_D = new Date();
	Calendar today_C = Calendar.getInstance();	
	today_S = simpleDate.format(today_D);
	today_C.setTime(today_D);

	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String id = (String)session.getAttribute("id");
	String state = "";
	String time = "";
	int counter = 0;

	String time_now = "";
	Date  begin_date = null;
	Date  end_date = null;
	long r_hour = 0;
	long r_min = 0;
	long r_sec = 0;
	long r_msec = 0;
	long resultTime = 0;
	long resultTimeTmp = 0;
	double lightUse = 0;
	double fanUse = 0;
	double resultUse = 0;
	String resultStr;
	
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
	     			<li class="active"><a href="#">기록</a></li>
	    		</ul>
	    		<ul class="nav navbar-nav navbar-right">
	     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
	            	<li><a href="Logout.jsp">로그아웃</a></li>
	    		</ul>
			</div> 
		</div>
  	</nav>
  	
   <div class="container">
	<div class="row">
    	<div class="col-sm-4" >
			
			</br>
<%
				try
				{
					conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
							"root","Shome");
					stmt = conn.createStatement();
					rs = stmt.executeQuery("SELECT * FROM light_log ORDER BY time DESC LIMIT 1;");
					while(rs.next())
					{
						state = rs.getString("state");
						if(state.equals("Y"))
						{
%>
							<div class="alert alert-info">
								<strong><center><h1>전등</h1></center></strong> 
								<center>현재 전등이 켜저있습니다.</center>
								<br>
							</div>
<%
						}
						else if(state.equals("N"))
						{
%>
							<div class="alert alert-warning">
								<strong><center><h1>전등</h1></center></strong> 
								<center>현재 전등이 꺼저있습니다.</center>
								<br>
							</div>
<%
						}
					}

	    		simpleDate = new SimpleDateFormat("yyyy-MM-dd");
				rs = stmt.executeQuery("SELECT * FROM light_log WHERE time like '" + simpleDate.format(today_C.getTime()) + "%'");
				resultTime = 0;
				while(rs.next())
				{
					state = rs.getString("state");
					time = rs.getString("time");
					counter++;
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
							resultTime += (end_date.getTime() - begin_date.getTime());
							begin_date = null;
							end_date = null;
						}
					}    
				}
			
				if(resultTime == 0)
				{
					resultStr = "오늘은 아직 사용 기록이 없습니다.";
				}
				else
				{
					r_hour = resultTime/(60*60*1000);
					resultTime = resultTime%(60*60*1000);
					r_min = resultTime/(60*1000);
					resultTime = resultTime%(60*1000);
					r_sec = resultTime/1000;
					r_msec = resultTime%1000;
					resultStr = "오늘 사용한 총 시간은 ";
%>
					<center><%=resultStr%></center>
<%
					resultStr = "";
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
						resultStr += r_msec + "ms";
					}
%>
					<b><center><%=resultStr%></center></b>
<%
					resultStr = null;
					resultStr = " 입니다.";
				}
				
%>
	       	<center><%=resultStr %></center>
	       	</br>
<%
				begin_date = null;
				end_date = null;
				simpleDate = new SimpleDateFormat("yyyy-MM");
				rs = stmt.executeQuery("SELECT * FROM light_log WHERE time like '" + simpleDate.format(today_C.getTime()) + "%'");
				resultTime = 0;
				while(rs.next())
				{
					state = rs.getString("state");
					time = rs.getString("time");
					counter++;
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
							resultTime += (end_date.getTime() - begin_date.getTime());
							begin_date = null;
							end_date = null;
						}
					}    
				}
			
				if(resultTime == 0)
				{
					resultStr = "이번 달은 아직 사용 기록이 없습니다.";
				}
				else
				{
					resultTimeTmp = resultTime;
					r_hour = resultTime/(60*60*1000);
					resultTime = resultTime%(60*60*1000);
					r_min = resultTime/(60*1000);
					resultTime = resultTime%(60*1000);
					r_sec = resultTime/1000;
					r_msec = resultTime%1000;
					resultStr = "이번 달 사용한 총 시간은 ";
%>
					<center><%=resultStr%></center>
<%
					resultStr = "";
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
						resultStr += r_msec + "ms";
					}
%>
					<b><center><%=resultStr%></center></b>
<%
					resultStr = null;
					resultStr = " 입니다.";
				}
				
%>
	       	<center><%=resultStr %></center>
	       	</br>
<%
				resultTime = 0;
				if(resultTimeTmp == 0)
				{
					resultStr = "이번 달 전구(8W) 사용 전력 : ";
%>
					<center><%=resultStr%><b>0.00</b>kWh</center>
<%
				}
				else
				{
					lightUse = ((8 * r_hour) + (8 * r_min /60))/1000;
					lightUse += (((8) + (8 * r_min /60))%1000)*(0.001);
					resultStr = "이번 달 전구(8W) 사용 전력 : ";
%>
					<center><%=resultStr%></center>
					<center><b><%=Double.parseDouble( String.format( "%.3f" , lightUse ) )%></b>kWh</center>

					</br>
<%
				}
%>

	    <center><button type="button" class="btn btn-primary" onclick="location.href='Statistics_light.jsp'">자세히 보기</button></center>
    	</br>
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
    	<div class="col-sm-4" >
		</br>
<%
			try
			{
				simpleDate = new SimpleDateFormat("yyyy-MM-dd");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
						"root","Shome");
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT * FROM fan_log ORDER BY time DESC LIMIT 1;");
				while(rs.next())
				{
					state = rs.getString("state");
					if(state.equals("Y"))
					{
%>
						<div class="alert alert-info">
							<strong><center><h1>선풍기</h1></center></strong> 
							<center>현재 선풍기이 켜저있습니다.</center>
							<br>
						</div>
<%
					}
					else if(state.equals("N"))
					{
%>
						<div class="alert alert-warning">
							<strong><center><h1>선풍기</h1></center></strong> 
							<center>현재 선풍기이 꺼저있습니다.</center>
							<br>
						</div>
<%
					}
				}
				
				begin_date = null;
				end_date = null;
				simpleDate = new SimpleDateFormat("yyyy-MM-dd");
				rs = stmt.executeQuery("SELECT * FROM fan_log WHERE time like '" + simpleDate.format(today_C.getTime()) + "%'");
				resultTime = 0;
				while(rs.next())
				{
					state = rs.getString("state");
					time = rs.getString("time");
					counter++;
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
							resultTime += (end_date.getTime() - begin_date.getTime());
							begin_date = null;
							end_date = null;
						}
					}    
				}
			
				if(resultTime == 0)
				{
					resultStr = "오늘은 아직 사용 기록이 없습니다.";
				}
				else
				{
					r_hour = resultTime/(60*60*1000);
					resultTime = resultTime%(60*60*1000);
					r_min = resultTime/(60*1000);
					resultTime = resultTime%(60*1000);
					r_sec = resultTime/1000;
					r_msec = resultTime%1000;
					resultStr = "오늘 사용한 총 시간은 ";
%>
					<center><%=resultStr%></center>
<%
					resultStr = "";
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
						resultStr += r_msec + "ms";
					}
%>
					<b><center><%=resultStr%></center></b>
<%
					resultStr = null;
					resultStr = " 입니다.";
				}
				
%>
	       	<center><%=resultStr %></center>
	       	</br>
<%
				begin_date = null;
				end_date = null;
				simpleDate = new SimpleDateFormat("yyyy-MM");
				rs = stmt.executeQuery("SELECT * FROM fan_log WHERE time like '" + simpleDate.format(today_C.getTime()) + "%'");
				resultTime = 0;
				while(rs.next())
				{
					state = rs.getString("state");
					time = rs.getString("time");
					counter++;
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
							resultTime += (end_date.getTime() - begin_date.getTime());
							begin_date = null;
							end_date = null;
						}
					}    
				}
			
				if(resultTime == 0)
				{
					resultStr = "이번 달은 아직 사용 기록이 없습니다.";
				}
				else
				{
					resultTimeTmp = resultTime;
					r_hour = resultTime/(60*60*1000);
					resultTime = resultTime%(60*60*1000);
					r_min = resultTime/(60*1000);
					resultTime = resultTime%(60*1000);
					r_sec = resultTime/1000;
					r_msec = resultTime%1000;
					resultStr = "이번 달 사용한 총 시간은 ";
%>
					<center><%=resultStr%></center>
<%
					resultStr = "";
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
						resultStr += r_msec + "ms";
					}
%>
					<b><center><%=resultStr%></center></b>
<%
					resultStr = null;
					resultStr = " 입니다.";
				}
				
%>
	       	<center><%=resultStr %></center>
	       	</br>
	       	
	       	<%
				resultTime = 0;
				if(resultTimeTmp == 0)
				{
					resultStr = "이번 달 선풍기(2.5W) 사용 전력 : ";
%>
					<center><%=resultStr%><b>0.00</b>kWh</center>
<%
				}
				else
				{
					fanUse = (((2.5) * r_hour) + ((2.5) * r_min /60))/1000;
					fanUse += ((((2.5) * r_hour) + ((2.5) * r_min /60))%1000)*(0.001);
					resultStr = "이번 달 선풍기(2.5W) 사용 전력 : ";
%>
					<center><%=resultStr%></center>
					<center><b><%=Double.parseDouble( String.format( "%.3f" , fanUse ) )%></b>kWh</center>

					</br>
<%
				}
%>
	       	<center><button type="button" class="btn btn-primary" onclick="location.href='Statistics_fan.jsp'">자세히 보기</button></center>
    		</br>
    	</div>
    	<div class="col-sm-4" >
    		<iframe src=Statistics_pi.jsp style="border:none; height: 250px; width: 100%"></iframe>
    	
    	</div>
  	</div>
  	<div>
<% 
	resultUse = lightUse + fanUse;
%>
		</br>
		<div style="height:80px;">
			<h4 style="margin-top:50px">
	  			<center>총 사용 전력 : <b><%=Double.parseDouble( String.format( "%.3f" , resultUse))%></b>kWh</center>
	  		</h4>
		</div>
		
  		<br>
  	</div>
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
</body>
</html>