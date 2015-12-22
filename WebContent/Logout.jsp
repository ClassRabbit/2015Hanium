<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	session.removeAttribute("id");
	session.removeAttribute("passwd");
	session.removeAttribute("light_IP");

	try 
	{
		Cookie[] cookies = request.getCookies();                // 요청에서 쿠키를 가져온다
		if(cookies!=null) 
		{                                               // 쿠키가 Null이 아닐때,
			
			for(int i = 0 ; i<cookies.length; i++){                            // 쿠키 배열을 반복문으로 돌린다.

			cookies[i].setMaxAge(0);                        // 특정 쿠키를 더 이상 사용하지 못하게 하기 위해서는 
			// 쿠키의 유효시간을 만료시킨다.
			response.addCookie(cookies[i]);            // 해당 쿠키를 응답에 추가(수정)한다.
			
			} 
		}
		
	}
	catch(Exception e) 
	{
	}
	response.sendRedirect("Login.jsp");
	
	

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Shome 컨트롤러</title>
</head>
<body>
</body>

</html>