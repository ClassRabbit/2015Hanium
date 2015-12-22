<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.sql.*, java.util.*, java.text.*, java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	SimpleDateFormat simpeDate = new SimpleDateFormat("yyyy-MM-dd");
	String find_begin = request.getParameter("find_begin");
	String find_end = request.getParameter("find_end");
	String from = (String)request.getParameter("from");
	
	Date find_begin_D = simpeDate.parse(find_begin);
	Date find_end_D = simpeDate.parse(find_end);
	
	Calendar find_begin_C = Calendar.getInstance();
	Calendar find_end_C = Calendar.getInstance();
	
	find_begin_C.setTime(find_begin_D);
	find_end_C.setTime(find_end_D);

	
	
	if(find_end_C.compareTo(find_begin_C) == -1)
	{
		request.setAttribute("error", "error");
		if(from.equals("light"))
		{
%>
			<jsp:forward page = "Statistics_light.jsp" />
<%
		}
		else if(from.equals("fan"))
		{
%>
			<jsp:forward page = "Statistics_fan.jsp" />
<%
		}
	}
	else
	{
	
		session.setAttribute("find_begin", find_begin);
		session.setAttribute("find_end", find_end);
		
		if(from.equals("light"))
		{
			response.sendRedirect("Statistics_light.jsp");
		}
		else if(from.equals("fan"))
		{
			response.sendRedirect("Statistics_fan.jsp");
		}
	}
	
%>

</body>
</html>