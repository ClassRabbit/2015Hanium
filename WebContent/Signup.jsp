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
			<a class="navbar-brand" href="">Shome</a>
		</div>
		<div class="collapse navbar-collapse target"><!--숨겨지는부분-->
			<ul class="nav navbar-nav">
				<li><a href="Login.jsp">로그인 </a></li>
				<li class="active"><a href="#">회원가입<span class="sr-only">(current)</span></a></li>
			</ul>
		</div>
	</div>
</nav>

<div class="container">
	<div class="margin">
		<form  method=post action="SignupCheck.jsp">
			<center><h2 class="form-signin-heading">Shome 회원가입</h2><p></center>
<%
	String failed_NAME = (String)request.getAttribute("failed_NAME");
	String failed_SQL = (String)request.getAttribute("failed_SQL");
	String failed_EXC = (String)request.getAttribute("failed_EXC");
	String light = (String)request.getAttribute("light");
	String fan = (String)request.getAttribute("fan");
	String pi = (String)request.getAttribute("pi");
	if(failed_NAME != null)
	{
%>
			<div class="alert alert-danger">
	    		<strong>회원 가입 실패!</strong> 아이디가 중복되었습니다.
	  		</div>
	        <h3>아이디</h3>
	        <input type="text" name="id" class="form-control" placeholder="" required autofocus>
	        <h3>비밀번호</h3>
	        <input type="password" name="passwd" class="form-control" placeholder="" required>
	        <h3>전등 IP</h3>
	        <input type="text" name="light" class="form-control" placeholder=""  value="<%=light %>">
			<h3>선풍기 IP</h3>
	        <input type="text" name="fan" class="form-control" placeholder=""  value="<%=fan %>">
			<h3>라즈베리 파이 IP</h3>
	        <input type="text" name="pi" class="form-control" placeholder=""  value="<%=pi %>">
<%
	}
	else if(failed_SQL != null)
	{
%>
			<div class="alert alert-danger">
	    		<strong>회원 가입 실패!</strong> 입력 값이 잘못되었습니다.
	  		</div>
	        <h3>아이디</h3>
	        <input type="text" name="id" class="form-control" placeholder="" required autofocus>
	        <h3>비밀번호</h3>
	        <input type="password" name="passwd" class="form-control" placeholder="" required>
	        <h3>전등 IP</h3>
	        <input type="text" name="light" class="form-control" placeholder="">
			<h3>선풍기 IP</h3>
	        <input type="text" name="fan" class="form-control" placeholder="">
			<h3>라즈베리 파이 IP</h3>
	        <input type="text" name="pi" class="form-control" placeholder="">
<%		
	}
	else if(failed_EXC != null)
	{
%>
			<div class="alert alert-danger">
	    		<strong>회원 가입 실패!</strong> 내부 오류입니다.
	  		</div>
	        <h3>아이디</h3>
	        <input type="text" name="id" class="form-control" placeholder="" required autofocus>
	        <h3>비밀번호</h3>
	        <input type="password" name="passwd" class="form-control" placeholder="" required>
	        <h3>전등 IP</h3>
	        <input type="text" name="light" class="form-control" placeholder="">
			<h3>선풍기 IP</h3>
	        <input type="text" name="fan" class="form-control" placeholder="">
	        <h3>라즈베리 파이 IP</h3>
	        <input type="text" name="pi" class="form-control" placeholder=""">
<%	
	}
	else
	{
%>
			<h3>아이디</h3>
	        <input type="text" name="id" class="form-control" placeholder="" required autofocus>
	        <h3>비밀번호</h3>
	        <input type="password" name="passwd" class="form-control" placeholder="" required>
	        <h3>전등 IP</h3>
	        <input type="text" name="light" class="form-control" placeholder="">
			<h3>선풍기 IP</h3>
	        <input type="text" name="fan" class="form-control" placeholder="">
	        <h3>라즈베리 파이 IP</h3>
	        <input type="text" name="pi" class="form-control" placeholder="">
<%
	}
%>
			</br>
			<center><input type="submit" class="btn btn-lg btn-primary" value="회원가입"></center>
        </form>
	</div>
	<div style="height:80px;">
	</div>
</div>

</body>
</html>