<%@LANGUAGE="JAVASCRIPT" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>form</title>
</head>
<body>
<%
var username=Request.Form("username")
var pass=Request.Form("password")
var sex=Request.Form("sex")
var like=Request.Form("like")
Response.Write("<p><h1>用户提交的个人信息</h1></p>")
Response.Write("<hr color='#0000FF'>")
Response.Write("<h2>用户名为:"+username+"</h2><br>")
Response.Write("<h2>密码为:"+pass+"</h2><br>")
Response.Write("<h2>性别为:"+sex+"</h2><br>")
Response.Write("<h2>爱好为:"+like+"</h2><br>")
%>
</body>
</html>

