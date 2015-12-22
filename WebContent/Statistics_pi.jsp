<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="SSH.*" %>
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
<title>Shome</title>
</head>
<%
	String pi_IP = (String)session.getAttribute("pi_IP");
	SSHCommandExecutor ssh = new SSHCommandExecutor(pi_IP,"pi","Shome");
	ssh.setCommand("ls /media/pi/SHOME/mp3/*.mp3");
	String result = ssh.execute();
	int count = ssh.countOccurrences(result,".mp3");
	request.setAttribute("count", count);
%>
<body>
<%
	if(count == 0)
	{
%>
		</br>
		<div class="alert alert-danger">
			<strong><center><h1>뮤직</h1></center></strong> 
			<center>연결 상태 : Disconnected</center>
			<br>
	  	</div>
	  	
	  	<center>USB 연결이 안되었거나 mp3파일이 없습니다.</center>
<%
	}
	else
	{
%>	
		</br>
		<div class="alert alert-success">
	    	<strong><center><h1>뮤직</h1></center></strong> 
			<center>연결 상태 : Connected</center>
			<br>
	  	</div>
	  	
		<center></strong>mp3 파일 갯수 : <%=count %></center>
<%
	}
%>
</body>
</html>