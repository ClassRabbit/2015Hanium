<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
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
	String light_IP = "";
	String fan_IP = "";
	int counter = 0;
	try
	{
		id = request.getParameter("id");
		passwd = request.getParameter("passwd");
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome","root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM profile where id = '"+id+"' and passwd = '"+passwd+"';");
		if(rs.next())
		{	
			session.setAttribute("id",id); 
			light_IP = rs.getString("light");
			session.setAttribute("id",id); 
			session.setAttribute("passwd",passwd);
			session.setAttribute("light_IP",light_IP); 
			session.setAttribute("fan_IP",fan_IP); 
			response.sendRedirect("Control.jsp");
		}
		else
		{
%>
			<script type="text/javascript">
				alert("입력하신 정보가 없습니다.");
			</script>
<%
			response.sendRedirect("Login.jsp");
		}
		
	}
	catch(SQLException e)
	{
	%>
		SQLException!
	<%
	}
	catch(Exception e)
	{
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
%>
</body>
</html>