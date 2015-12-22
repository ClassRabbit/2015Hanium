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
	String failed_NAME = "";
	String failed_SQL = "";
	String failed_EXC = "";
	String failed = "";
	String success = "";
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String light = request.getParameter("light");
	String fan = request.getParameter("fan");
	String pi = request.getParameter("pi");

	int counter = 0;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM profile where id = '"+id+"';");
		if(rs.next())
		{	
			request.setAttribute("failed_NAME", "failed_NAME");
			request.setAttribute("light", light);
			request.setAttribute("fan", fan);
			request.setAttribute("pi", pi);
			failed = "failed";
		}
		else
		{
			request.setAttribute("success", "success");
			request.setAttribute("id", id);
			request.setAttribute("passwd", passwd);
			success = "success";
			stmt.executeUpdate("insert into profile(id, passwd, light, fan, pi) values('"+id+"', '"+passwd+"', '"+light+"', '"+fan+"', '"+pi+"');");
		}
	}
	catch(SQLException e)
	{
		request.setAttribute("failed_SQL", "failed_SQL");
		failed = "failed";
%>
		SQLException!
<%
	}
	catch(Exception e)
	{
		request.setAttribute("failed_EXC", "failed_EXC");
		failed = "failed";
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
	if(failed.equals("failed"))
	{
%>
		<jsp:forward page = "Signup.jsp" />
<%
	}
	else if(success.equals("success"))
	{
%>
		<jsp:forward page = "Login.jsp" />
<%	
	}
%>
</body>
</html>