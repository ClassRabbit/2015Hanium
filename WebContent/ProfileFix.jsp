<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//String id = (String)request.getAttribute("id");
	String id = (String)session.getAttribute("id");
	String passwd = (String)session.getAttribute("passwd");
	String light_IP = (String)session.getAttribute("light_IP");
	String fan_IP = (String)session.getAttribute("fan_IP");
	String pi_IP = (String)session.getAttribute("pi_IP");
	String success = (String)request.getAttribute("success");
	String failed_SQL = (String)request.getAttribute("failed_SQL");
	String failed_EXC = (String)request.getAttribute("failed_EXC");
	int counter = 0;
	if(id == null)
	{
		response.sendRedirect("LoginCheck.jsp");
	}	  	
%>
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
	     			<li><a href="Statistics.jsp">기록</a></li>
	    		</ul>
	    		<ul class="nav navbar-nav navbar-right">
	     			<li class="active"><a href="ProfileFix.jsp"><%=id %></a></li>
	            	<li><a href="Logout.jsp">로그아웃</a></li>
	    		</ul>
			</div>
		</div>
  	</nav>

<div class="container">
	<div class="margin">
      <form  method=post action="ProfileFixCheck.jsp">
        <center><h2 class="form-signin-heading">Shome 회원 정보 수정</h2></center>
<%      	
      	if(success != null)
		{
%>
			<div class="alert alert-success">
	    		<strong>회원 정보 수정 완료!</strong> 
	  		</div>
<%	
		}
		if(failed_SQL != null)
		{
%>
			<div class="alert alert-danger">
		    	<strong>회원 정보 수정 실패!</strong> 입력 값이 잘못되었습니다.
		  	</div>
<%	
		}
		if(failed_EXC != null)
		{
%>
			<div class="alert alert-danger">
		    	<strong>회원 정보 수정 실패!</strong> 내부 오류입니다.
		  	</div>
<%	
		}
%>
        <h3>아이디</h3>
        <input type="text" name="id" class="form-control" value="<%=id %>" placeholder="" required autofocus readonly>
        <h3>비밀번호</h3>
        <input type="password" name="passwd" class="form-control" value="<%=passwd %>" placeholder="" required>
        <h3>전등 IP</h3>
        <input type="text" name="light_IP" class="form-control" value="<%=light_IP %>" placeholder="">
		<h3>선풍기 IP</h3>
        <input type="text" name="fan_IP" class="form-control"  value="<%=fan_IP %>" placeholder="">
        <h3>라즈베리 파이 IP</h3>
        <input type="text" name="pi_IP" class="form-control"  value="<%=pi_IP %>" placeholder="">
		</br>
		<center><input type="submit" class="btn btn-lg btn-primary btn-block" value="회원 정보 수정"></center>
        </form>
	</div>
	<div style="height:80px;">
	</div>
</div>
</body>
</html>