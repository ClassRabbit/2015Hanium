<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	session.removeAttribute("id");
	session.removeAttribute("passwd");
	session.removeAttribute("light_IP");
	response.sendRedirect("Login.jsp");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Shome 컨트롤러</title>
</head>
<body>

</body>
</html>