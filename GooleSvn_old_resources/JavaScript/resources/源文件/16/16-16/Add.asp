<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Dim conn,rs
Dim connstr
Dim sqlCmd

'创建数据库连接对象并打开
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.jet.oledb.4.0;data source=" & server.mappath("16-16.mdb")
conn.open connstr

'将提交的数据加入数据库
sqlCmd="insert into data(title,author,content) values('" & request.form("title") & "','" & request.form("author") & "','" & request.form("content") & "')"
conn.execute(sqlCmd)

'返回服务器时间
Response.write(Date)
%>
