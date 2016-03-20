<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<%
var  conn=Server.CreateObject("ADODB.Connection")     //创建connection对象
var path=Server.MapPath("data.mdb");                    //取得data.mdb数据库的实际路径
var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+path;  //数据源的连接字符串
conn.Open(connstr);                                    //打开连接
                   			  //SQL查询语句
sql="insert into student(student_id,student_name,student_sex,student_age,student_zhuangye,student_address,student_tel) values('200709110020','王晓华','女',23,'计算机应用','辽宁省大连市','13656894520')"
conn.Execute(sql); 
Response.Redirect("15-7.asp")
%>

