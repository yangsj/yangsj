<%@ LANGUAGE=JavaScript %>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>form</title>
</head>
<body>
提交的用户信息为：<%=Request.QueryString("text1")%>
<form action="15-3.asp" method="get"> 
  <p>提交信息：
    <input name="text1" type="text" value="" size="50"> 
    <input name="提交" type="submit" value="提交"> 
  </p>
  </form> 
</body>
</html>
