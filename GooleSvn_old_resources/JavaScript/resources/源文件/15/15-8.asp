<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<% 
  var conn=Server.CreateObject("ADODB.Connection")			//建立一个connection对象变量
  var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+Server.MapPath("data.mdb") //数据源的连接字符串
  conn.Open(connstr);									//打开连接
  sql="select * from student"; 							//SQL查询语句
  rs=Server.CreateObject("ADODB.Recordset"); 				//创建Recordset对象
  rs.Open(sql,conn,1,1);									//打开记录集
  var i=0;  											//定义一个循环变量 
%>

<html>
<head>
<title>输出数据表的字段名称</title>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<% for(i=0;i<=rs.Fields.Count-1;i++)                       //循环输出字段名称
{
Response.Write(rs(i).Name+"&nbsp;&nbsp;" )//提取字段名称

}
rs.Close();                                             //关闭记录集
rs=null;
conn.Close();                                          //关闭数据库
conn=null;
%>
</body>
</html>

