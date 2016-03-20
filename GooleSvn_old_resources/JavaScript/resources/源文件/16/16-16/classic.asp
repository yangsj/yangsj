<%
Dim conn,rs
Dim connstr
Dim sqlCmd


'创建数据库连接对象并打开
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.jet.oledb.4.0;data source=" & server.mappath("GuestBook.mdb")
conn.open connstr
'用于从数据库中获取数据的sql语句
sqlCmd="select title,author,date,content from data order by date desc"
'创建数据集对象
set rs=server.createobject("adodb.recordset")

if Request.form("title")<>"" then
	'如果是页面提交数据则将提交的数据加入数据库
	rs.open sqlCmd,conn,1,3
	rs.addnew
	rs("title")=request.form("title")
	rs("author")=request.form("author")
	rs("content")=request.form("content")
	rs.update
    rs.close
end if


set rs=server.createobject("adodb.recordset")

	'否则直接从数据库中获取数据
	rs.open sqlCmd,conn,1,1
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Classic GuestBook</title>
<style type="text/css">
<!--
body			{	font-size:0.75em;text-align:center;}
dl				{	margin:0;}
dt				{	background-color:#666;color:#fff;margin:1px;padding:0 3px;}
dd				{	margin:3px;}
div				{	margin:auto;line-height:150%;text-align:left;width:400px;border:1px solid #666;}
#postBox		{	margin-top:10px;}
dd.button		{	text-align:center;}
dd.button input	{	margin:0 20px;}
//-->
</style>
</head>

<body>
<div id="msgList">
	<%
		'遍历记录集生成Html代码，从而将数据显示于页面
		while not rs.eof
	%>
	<dl>
		<dt>标题：<%=rs("title")%></dt>
		<dd>作者：<%=rs("author")%> &nbsp;日期：<%=rs("date")%></dd>
		<dd><%=rs("content")%></dd>
	</dl>
	<%
		rs.movenext
		wend
		'关闭数据库连接及记录集，释放资源
		rs.close
		conn.close
		set rs=nothing
		set conn=nothing
	%>
</div>
<div id="postBox">
	<form action="classic.asp" method="post">
		<dl>
			<dt>发表您的留言</dt>
			<dd>标题：<input type="text" maxlength="150" size="45" name="title"/></dd>
			<dd>作者：<input type="text" maxlength="50" size="45" name="author"/></dd>
			<dd>内容：<textarea rows="10" cols="45" name="content"></textarea></dd>
			<dd class="button">
				<input type="submit" value="提交"/>
				<input type="reset" value="重填"/>
			</dd>
		</dl>
	</form>
</div>
</body>
</html>