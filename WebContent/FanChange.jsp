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
	String id = (String)session.getAttribute("id");
	String light_IP = (String)session.getAttribute("fan_IP");
	String state = "";
	int counter = 0;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		state = request.getParameter("state");
		GregorianCalendar calendar = new GregorianCalendar();
		String time = String.format("%TF", calendar) + " " + String.format("%TT", calendar);
		if(state.equals("Y"))
		{
%>
			<!--<iframe name="arduino" src="http://??????/ON1" style="display: none;" width = "0" height= "0"></iframe>-->
<%
			stmt.executeUpdate("update fan set state='N' where state = 'Y';");
			stmt.executeUpdate("insert into light_log (state, time) values('N','"+time +"')");
		}
		else
		{
%>
			<!-- <iframe name="arduino" src="http://???????/OFF1" style="display: none;" width = "0" height= "0"></iframe> -->
<%
			stmt.executeUpdate("update fan set state='Y' where state = 'N';");
			stmt.executeUpdate("insert into fan_log (state, time) values('Y','"+time +"')");
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
	response.sendRedirect("Control.jsp");
	%>
</body>
</html>