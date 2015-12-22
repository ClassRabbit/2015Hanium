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
	    		<a class="navbar-brand" href="#">Shome</a>
	   		</div>
	 		<div class="collapse navbar-collapse target"><!--숨겨지는부분-->
	    		<ul class="nav navbar-nav">
	     			<li><a href="Control.jsp">리모콘</a></li>
	     			<li><a href="Statistics.jsp">기록</a></li>
	    		</ul>
	    		<ul class="nav navbar-nav navbar-right">
	     			<li><a href="ProfileFix.jsp"><%=id %></a></li>
	            	<li><a href="Logout.jsp">로그아웃</a></li>
	    		</ul>
			</div>
		</div>
  	</nav>
	<div class="container">
		<center><h1>Shome 사용 설명서</h1></center>
		<h3>1. 상단 바</h3>
		<img alt="intro_img_0" src="./img/intro_0.jpg" style="width:100%">
		<br>
		<b>로그인 전</b>
		<ul>
			<li>Shome : 사용 설명서를 확인할 수 있습니다.</li>
			<li>로그인 : 로그인 페이지로 이동합니다. 로그인 후 Shome 컨트롤러를 사용할 수 있습니다.</li>
			<li>회원가입 : 회원가입 페이지로 이동합니다. 회원가입을 진행할 수 있습니다.</li>
		</ul>
		<br>
		<img alt="intro_img_1" src="./img/intro_1.jpg" style="width:100%">
		<br>
		<b>로그인 후</b>
		<ul>
			<li>Shome : 사용 설명서를 확인할 수 있습니다.</li>
			<li>리모콘 : 리모콘 페이지로 이동합니다. 전반적인 컨트롤을할 수있습니다.</li>
			<li>기록 : 기록 페이지로 이동합니다. 사용기록, 총 전력 소비량을 확인할 수 있습니다.</li>
			<li>User : 회원 정보 수정 페이지로 이동합니다. 비밀번호, IP주소를 수정할 수 있습니다.</li>
		</ul>
		<br>
		
		<h3>2. 리모콘</h3>
		<center>
			<img alt="intro_img_2" src="./img/intro_2.jpg" style="width:100%; max-width:900px;">
		</center>
		<br>
		<ul>
			<li>클릭을 통하여 기기 작동할 수 있습니다.</li>
			<li><b>원활한 작동을 위해선 정확한 기기 IP를 회원 정보에 기재 해놓으셔야 합니다.</b></li>
		</ul>
		<br>
		
		<h3>3. 기록</h3>
		<center>
			<img alt="intro_img_3" src="./img/intro_3.jpg" style="width:100%; max-width:900px;">
		</center>
		<br>
		<ul>
			<li>기기의 상태와 총 사용 시간, 총 사용 전력을 확인할 수있습니다.</li>
			<li>자세히 보기를 통하여 해당 기기의 날짜별 사용 로그를 확인할 수 있습니다.</li>
			<li>뮤직 USB의 연결 상태, 담겨있는 mp3파일의 수를 확인할 수 있습니다.</li>
			<li><b>뮤직을 사용할 경우 USB의 이름은 SHOME, mp3 파일은 SHOME/mp3/ 안에 넣으셔야 인식이 가능합니다.</b></li>
		</ul>
		<br>
		<h3>4. 자세히 보기</h3>
		<center>
			<img alt="intro_img_4" src="./img/intro_4.jpg" style="width:100%; max-width:900px;">
		</center>
		<br>
		<ul>
			<li>기간을 설정하여 기기의 사용 로그를 검색할 수 있습니다.</li>
		</ul>
		<br>
	</div>
</body>
</html>