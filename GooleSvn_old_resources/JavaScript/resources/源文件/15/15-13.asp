<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<!--#include file="adojavas.inc"-->   
<% 
  var conn=Server.CreateObject("ADODB.Connection")			//建立一个connection对象变量
  var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+Server.MapPath("data.mdb") //数据源的连接字符串
  conn.Open(connstr);									//打开连接
  sql="select * from student"; 							//SQL查询语句
  rs=Server.CreateObject("ADODB.Recordset"); 				//创建Recordset对象
  rs.Open(sql,conn,1,1);									//打开记录集
%>
<html>
<head>
<title>分页显示</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body>
<table width="100%" border="1" cellspacing="2" cellpadding="2" class="border">
  <tr>
    <td height="25" width="20%">学号</td>
    <td height="25" width="20%">学生姓名</td>
    <td height="25" width="20%">学生性别</td>
    <td height="25" width="20%">年龄</td>
    <td height="25" width="20%">专业</td>
  </tr>
  <%
rs.PageSize =5;								//设置每一页所显示的记录数	
var x,page=1;
maxpage=rs.PageCount;						//统计页数
page=Request.QueryString("page").item;		//提取分页的页码
if (page==null)								//如果page为null则设置page为1
{
page=1;
}
else
{
page=parseInt(page);						//将page转换为整型
if (page<1){page=1;}							//设定页码的值
if(page>maxpage){ page=maxpage;}
}
rs.AbsolutePage=page;
if (page==maxpage){x=rs.RecordCount-(maxpage-1)* rs.PageSize;}	//指定每一页的记录数					
else{x= rs.PageSize }
for(var i=1;i<=x;i++)							//循环输出数据
 {
if (!rs.EOF) 
 {
Response.Write("<tr>");
Response.Write("<td>"+rs("student_id")+"</td>");
Response.Write("<td>"+rs("student_name")+"</td>");
Response.Write("<td>"+rs("student_sex")+"</td>");
Response.Write("<td>"+rs("student_age")+"</td>");
Response.Write("<td>"+rs("student_zhuangye")+"</td>");
Response.Write("</tr>");
rs.MoveNext;
  }
}
Response.Write("<tr>")
Response.Write("<td height='25' colspan='5'>");
if (!(1==page)) 								//输出页码超链接
{ 
Response.Write("<A HREF=15-13.asp?page=1>第一页</A>&nbsp;&nbsp;"); 
Response.Write("<A HREF=15-13.asp?page=" + (page-1) + ">上一页</A>&nbsp;&nbsp;"); 
} 
if (!(rs.PageCount==page)) 
{ 
Response.Write("<A HREF=15-13.asp?page=" + (page+1) + ">下一页</A>&nbsp;&nbsp;"); 
Response.Write("<A HREF=15-13.asp?page=" + rs.PageCount + ">最后一页</A>&nbsp;&nbsp;"); 
} 
Response.Write("页数:<font color='Red'>"+page+"/"+rs.PageCount+"</font></p>");
Response.Write("</td><tr>");
Response.Write("</table>");
rs.Close;
rs=null;
conn.Close;
conn=null;
%>

</body>
</html>

