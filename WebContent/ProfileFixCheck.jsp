<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shome 컨트롤러</title>
</head>
<body>
<%
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String light_IP = request.getParameter("light_IP");
	String fan_IP = request.getParameter("fan_IP");
	String pi_IP = request.getParameter("pi_IP");
	int counter = 0;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		stmt.executeUpdate("update profile set passwd='"+passwd+"', light='"+light_IP+"', fan='"+fan_IP+"', pi='"+pi_IP+"' where id='"+id+"';"); 
		session.setAttribute("id",id); 
		session.setAttribute("passwd",passwd);
		session.setAttribute("light_IP",light_IP); 
		session.setAttribute("fan_IP",fan_IP);
		session.setAttribute("pi_IP",pi_IP);
		request.setAttribute("success", "success");
%>	
		<jsp:forward page = "ProfileFix.jsp" />
<%
	}
	catch(SQLException e)
	{
		request.setAttribute("failed_SQL", "failed_SQL");
	%>
		SQLException!
		<jsp:forward page = "ProfileFix.jsp" />
	<%
	}
	catch(Exception e)
	{
		request.setAttribute("failed_EXC", "failed_EXC");
	%>
		Exception!
		<jsp:forward page = "ProfileFix.jsp" />
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