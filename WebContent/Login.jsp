<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
<title>Shome ��Ʈ�ѷ�</title>
<style type="text/css">
	.wrap {
		width: 100%;
		height: 100%;
		position: relative;
	}
	.margin{
		margin: 0 auto;
		width: 50%;	
	}
	
</style>
</head>
<body>
<nav class="navbar navbar-default"><!--�޴����� �� ����-->
 	<div class="navbar-header">
		<button class="navbar-toggle" data-toggle="collapse" data-target=".target"><!--������ϰ��-->
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="">Shome</a>
	</div>
	<div class="collapse navbar-collapse target"><!--�������ºκ�-->
		<ul class="nav navbar-nav">
			<li class="active"><a href="#">�α���<span class="sr-only">(current)</span></a></li>
			<li><a href="Signup.jsp">ȸ������ </a></li>
		</ul>
	</div>
</nav>
<div class="wrap">
	<div class="margin">
      <form  method=post action="LoginCheck.jsp">
        <h2 class="form-signin-heading">Shome Controle</h2><p><p>
        <input type="text" name="id" class="form-control" placeholder="ID" required autofocus>
        <p>
        <input type="password" name="passwd" class="form-control" placeholder="Password" required>
<!-- 
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
-->
<p><p><p><p>
			<input type="submit" class="btn btn-lg btn-primary btn-block" value="�α���">
        </form>
	</div>
</div> <!-- /wrap -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>