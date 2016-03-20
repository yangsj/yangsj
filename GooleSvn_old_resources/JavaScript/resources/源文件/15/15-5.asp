<%@LANGUAGE="JAVASCRIPT" CODEPAGE="936"%>
<%
  var conn=Server.CreateObject("ADODB.Connection")    //建立一个connection对象变量
  var connstr="DRIVER={Microsoft Access Driver (*.mdb)};DBQ="+Server.MapPath("data.mdb") //数据源的连接字符串
  conn.Open(connstr);                                  //连接数据库
  if (conn.state==1 )                                      //判断是否建立连接
  { 
   Response.Write("和数据建立了连接");
   }
  else
   {
   Response.Write("没有连接到数据库");
   }
   conn.Close;                                           //关闭连接
   conn=null;                                            //释放内存
%>

