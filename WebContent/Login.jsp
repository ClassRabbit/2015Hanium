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
<%
	String id = "";
	String passwd = "";
	try 
	{
		Cookie[] cookies = request.getCookies();                // 요청에서 쿠키를 가져온다
		
		if(cookies!=null) 
		{                                               // 쿠키가 Null이 아닐때,
			for(int i=0; i<cookies.length; i++) 
			{                 
				if(cookies[i].getName().equals("id")) 
				{         // 쿠키의 이름이 id 일때
 					id = cookies[i].getValue();                // 해당 쿠키의 값을 id 변수에 저장한다.
					for(int j=0; j<cookies.length; j++) 
					{          
						if(cookies[j].getName().equals("passwd")) 
						{
							passwd = cookies[j].getValue();
							request.setAttribute("cookie", "cookie");
							request.setAttribute("id", id);
							request.setAttribute("passwd", passwd);
							//request.setAttribute("remember", "remember");
%>
							<jsp:forward page = "LoginCheck.jsp" />
<%
							break;
						}
					}
					if(passwd.equals(""))
					{
						//아무짓도 안한다.
					}

				}
			}
			if(id.equals(""))
			{
				//아무짓도 안한다.
			}
		} 
		else 
		{	
			//아무짓도 안한다.
		} 
	}
	catch(Exception e) 
	{
	}

	
%>
<nav class="navbar navbar-default"><!--메뉴관련 더 있음-->
	<div class="container">
	 	<div class="navbar-header">
			<button class="navbar-toggle" data-toggle="collapse" data-target=".target"><!--모바일일경우-->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="Introduce_out.jsp">Shome</a>
		</div>
		<div class="collapse navbar-collapse target"><!--숨겨지는부분-->
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">로그인<span class="sr-only">(current)</span></a></li>
				<li><a href="Signup.jsp">회원가입 </a></li>
			</ul>
		</div>
	</div>
</nav>
<div class="container">
	<div class="margin">
      <form  method=post action="LoginCheck.jsp">
        <h2 class="form-signin-heading">Shome Controle</h2>
<%
	String success = (String)request.getAttribute("success");
	String failed = (String)request.getAttribute("failed");
	String badAccess = (String)request.getAttribute("badAccess");
	id = (String)request.getAttribute("id");
	passwd = (String)request.getAttribute("passwd");
	
	if(badAccess != null)
	{
%>
		<div class="alert alert-danger">
    		<strong>잘못된 접근!</strong> 접속 경로를 확인하세요. 
  		</div>
  		<input type="text" name="id" class="form-control" placeholder="ID" required autofocus>
        </br>
        <input type="password" name="passwd" class="form-control" placeholder="Password" required>
<%
	}
	else if(failed != null)
	{
%>
		<div class="alert alert-danger">
	    	<strong>로그인 실패!</strong> 회원 정보를 확인하세요. 
	  	</div>
	  	<input type="text" name="id" class="form-control" placeholder="ID" required autofocus>
        </br>
        <input type="password" name="passwd" class="form-control" placeholder="Password" required>
<%
	}
	else if(success != null)
	{
%>
		<div class="alert alert-success">
	    	<strong>회원 가입 성공!</strong> 
	  	</div>
	  	<input type="text" name="id" class="form-control" placeholder="ID" value="<%=id %>" required autofocus>
	  	</br>
        <input type="password" name="passwd" class="form-control" placeholder="Password" value="<%=passwd %>" required>
<%
	}

	else
	{
%>
		<input type="text" name="id" class="form-control" placeholder="ID" required autofocus>
        </br>
        <input type="password" name="passwd" class="form-control" placeholder="Password" required>
<%
	}
%>

	        <div class="checkbox">
	          <label>
	            <input type="checkbox" name="remember" value="remember"> 회원정보 저장
	          </label>
	        </div>
			<input type="submit" class="btn btn-lg btn-primary btn-block" value="로그인">
        </form>
	</div>
	<div style="height:80px;">
	</div>
</div>
</body>
</html>