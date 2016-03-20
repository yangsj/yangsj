<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<% 
  var conn=Server.CreateObject("ADODB.Connection")			//建立一个connection对象变量
  var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+Server.MapPath("data.mdb") //数据源的连接字符串
  conn.Open(connstr);									//打开连接
  sql="select * from student"; 							//SQL查询语句
  rs=Server.CreateObject("ADODB.Recordset"); 				//创建Recordset对象
rs.Open(sql,conn,2,3);                                  //打开记录集
rs.AddNew
rs("student_id")="200709110021"
rs("student_name")="周宏明"
rs("student_pass")="200709110021"
rs("student_sex")="男"
rs("student_age")=22
rs("student_zhuangye")="计算机应用"
rs("student_address")="西藏"
rs("student_tel")="13548796321"
rs.Update
Response.Redirect("15-7.asp")
%>

