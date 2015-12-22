<%@ page language="java" contentType="text/html; charset=EUC-KR"
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
	String id = "";
	String passwd = "";
	String remember = "";
	String light_IP = "";
	String fan_IP = "";
	String pi_IP = "";
	String failed = "";
	String badAccess = "";
	int counter = 0;
	
	id = (String)request.getAttribute("id");
	if(id == null && request.getParameter("id") == null)
	{
		request.setAttribute("badAccess", "badAccess");
%>
		<jsp:forward page = "Login.jsp" />
		
<%
		return;
	}
	else
	{
		try
		{
			String s_cookie = (String)request.getAttribute("cookie");
			if(s_cookie != null)
			{
				id = (String)request.getAttribute("id");
				passwd = (String)request.getAttribute("passwd");
				//remember = (String)request.getAttribute("remember");
			}
			else
			{
	
				id = request.getParameter("id");
				passwd = request.getParameter("passwd");
				remember = request.getParameter("remember");
			}
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome","root","Shome");
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM profile where id = '"+id+"' and passwd = '"+passwd+"';");
			if(rs.next())
			{	
				session.setAttribute("id",id); 
				light_IP = rs.getString("light");
				fan_IP = rs.getString("fan");
				pi_IP = rs.getString("pi");
				session.setAttribute("id",id); 
				session.setAttribute("passwd",passwd);
				session.setAttribute("light_IP",light_IP); 
				session.setAttribute("fan_IP",fan_IP); 
				session.setAttribute("pi_IP",pi_IP); 
				
				
				if(remember != null)
				{
					Cookie cookie = new Cookie("id", id);
					cookie.setMaxAge(24*60*60);			//하루
					response.addCookie(cookie);
					cookie = new Cookie("passwd", passwd);
					cookie.setMaxAge(24*60*60);			//하루
					response.addCookie(cookie);
				}
				response.sendRedirect("Control.jsp");
			}
			else
			{
				request.setAttribute("failed", "failed");
%>	
				<jsp:forward page = "Login.jsp" />
<%
			}
		
		}
		catch(SQLException e)
		{
			request.setAttribute("failed", "failed");
%>	
			<jsp:forward page = "Login.jsp" />
			SQLException!
<%
		}
		catch(Exception e)
		{
			request.setAttribute("failed", "failed");
%>	
			<jsp:forward page = "Login.jsp" />
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
	}
%>
</body>
</html>