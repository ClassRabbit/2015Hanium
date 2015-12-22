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
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	String light = request.getParameter("light");
	String fan = request.getParameter("fan");

	int counter = 0;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM profile where id = '"+id+"';");
		if(rs.next())
		{	
%>
			<script type="text/javascript">
				alert("중복된 아이디가 있습니다!");
				
			</script>
<%
			//request.setAttribute("id", id );
			response.sendRedirect("Signup.jsp");
		}
		else
		{
			stmt.executeUpdate("insert into profile(id, passwd, light, fan) values('"+id+"', '"+passwd+"', '"+light+"', '"+fan+"');");
%>
			<script type="text/javascript">
				alert("회원가입에 성공하셨습니다!");
				
			</script>
<%
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
	response.sendRedirect("Login.jsp");
	%>
</body>
</html>