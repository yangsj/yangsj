<%@ LANGUAGE=JavaScript %>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>form</title>
</head>
<body>
提交的用户信息为：<%=Request.Form("text1")%>
<form action="15-2.asp" method="post"> 
  <p>提交信息：
    <input name="text1" type="text" value="" size="50"> 
    <input name="提交" type="submit" value="提交"> 
  </p>
  </form> 

</body>
</html>


