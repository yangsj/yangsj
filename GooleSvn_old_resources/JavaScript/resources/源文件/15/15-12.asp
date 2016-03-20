<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<% 
  var conn=Server.CreateObject("ADODB.Connection")			//建立一个connection对象变量
  var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+Server.MapPath("data.mdb") //数据源的连接字符串
  conn.Open(connstr);									//打开连接
  var sql="delete * from student where student_sex='女'"  //设置删除记录的sql语句
  conn.Execute(sql)								//执行删除语句
  Response.Redirect("15-7.asp")   //重新定向回到14-14.asp页面
%>



