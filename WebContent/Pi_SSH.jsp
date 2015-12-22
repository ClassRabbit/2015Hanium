<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, SSH.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shome</title>
</head>
<body>
<%	
	String pi_IP = (String)session.getAttribute("pi_IP");
	String run = request.getParameter("run");
	String next = request.getParameter("next");
	String stop = request.getParameter("stop");
	String str = "";
	String volumUp = request.getParameter("volumUp");
	String volumDown = request.getParameter("volumDown");
	SSHCommandExecutor ssh = new SSHCommandExecutor(pi_IP,"pi","Shome");
	String state = null;
	
	Class.forName("org.gjt.mm.mysql.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try
	{
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
				"root","Shome");
		stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM music;");
		rs.next();
		state = rs.getString("state");
	}
	catch(Exception e)
	{
		
	}
	
	if(run != null)
	{
		if(state.equals("N"))
		{
			try
			{
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
						"root","Shome");
				stmt = conn.createStatement();
				stmt.executeUpdate("update music set state='Y' where state = 'N';");
			}
			catch(Exception e)
			{
				
			}
			
			ssh.setCommand("./suffleStart.sh");
			str = ssh.execute();
		}
		
		response.sendRedirect("Pi_run.jsp");
	}
	else if(next != null)
	{
		if(state.equals("Y"))
		{
			ssh.setCommand("./stopSuffleStart.sh");
			str = ssh.execute();
		}
		response.sendRedirect("Pi_next.jsp");
	}
	else if(stop != null)
	{
		if(state.equals("Y"))
		{
			try
			{
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Shome",
						"root","Shome");
				stmt = conn.createStatement();
				stmt.executeUpdate("update music set state='N' where state = 'Y';");
			}
			catch(Exception e)
			{
				
			}
			
			ssh.setCommand("./stop.sh");
			str = ssh.execute();
		}
		
		response.sendRedirect("Pi_stop.jsp");
	}
	else if(volumUp != null)
	{
		ssh.setCommand("./volumUp.sh");
		str = ssh.execute();
		response.sendRedirect("Pi_volumUp.jsp");
	}
	else  if(volumDown != null)
	{
		ssh.setCommand("./volumDown.sh");
		str = ssh.execute();
		response.sendRedirect("Pi_volumDown.jsp");
	}
	
%>

</body>
</html>