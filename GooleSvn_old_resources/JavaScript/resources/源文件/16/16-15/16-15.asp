<%@ LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<head>
<title>Ajax＋Asp实现树形菜单</title>
<script language="javascript">
var xmlHttp; //定义一个全局变量

//主函数，用于层和图标的样式及执行AJAX
//id,层id
//rid,数据在表中的id
//pid,图id
function DivDisplay(id,rid,pid)
{
	if (GetId(id).style.display=='')
	{
		GetId(id).style.display='none';
		GetId(pid).src = 'images/closed.gif';
	}
	else
	{
		GetId(id).style.display='';
		GetId(pid).src = 'images/opened.gif';
		if (GetId(id).innerHTML=='')
		{
			ShowChild(id,rid);
		}
	}
}

//创建XMLHttpRequest对象
function CreateXMLHttpRequest()
{
	if (window.ActiveXObject)
	{
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	else if (window.XMLHttpRequest) 
	{
		xmlHttp = new XMLHttpRequest();
	}
}

//Ajax处理函数
//id,层id
//rid,数据在表中的id
function ShowChild(id,rid)
{
	CreateXMLHttpRequest();
	if(xmlHttp)
	{
		xmlHttp.open('POST','admin.asp',true);
		xmlHttp.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		var SendData = 'id='+rid;
		xmlHttp.send(SendData);
		xmlHttp.onreadystatechange=function()
		{
		   if(xmlHttp.readyState==4)
		   {
			 if(xmlHttp.status==200)
			 {
				GetId(id).innerHTML = xmlHttp.responseText;
			 }
			 else
			 {
				GetId(id).innerHTML='出错：'+xmlHttp.statusText;
			 }
		   }
		   else
		   {
				GetId(id).innerHTML="正在提交数据...";
			}
	  	}
		
	 }
	 else
	 {
	 	GetId(id).innerHTML='抱歉，您的浏览器不支持XMLHttpRequest，请使用IE6以上版本！';
	 }
}



//取得页面对象
//id,层id
function GetId(id)
{
	return document.getElementById(id);
} 
</script>
</head>

<body>
<%
'连接数据库
dim conn,connstr,db
db="database/tree.mdb"
Set conn = Server.CreateObject("ADODB.Connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db)
conn.Open connstr

'显示根目录
sql="select * from t_column where c_Depth=0 "
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
do while not rs.eof
	if rs("c_childnum")>0 then
		response.Write("<img id='p"&rs("c_Id")&"' src=""images/closed.gif"" width=""30"" height=""15"" onclick=""DivDisplay('c"&rs("c_id")&"','"&rs("c_id")&"','p"&rs("c_id")&"')"" style=""cursor : hand;"" align=""absmiddle"">")
	else
		response.Write("<img src=""images/nofollow2.gif"" width=""30"" height=""15"" align=""absmiddle"" >")
	end if
	response.Write("<b>")
	response.Write(rs("c_Name"))
	if rs("c_childnum")>0 then response.Write("("&rs("c_childnum")&")") 
	response.Write("</b>")
	response.Write("<br>")
	if rs("c_childnum")>0 then
		response.Write("<div id='c"&rs("c_Id")&"' style='display:none;'></div>")
	end if
	rs.movenext
loop
rs.close
set rs=nothing
conn.close
Set conn = Nothing
%>
</body>
</html>
