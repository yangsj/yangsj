<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
Dim conn,rs
Dim connstr
Dim sqlCmd

'创建数据库连接对象并打开
set conn=server.createobject("adodb.connection")
connstr="Provider=Microsoft.jet.oledb.4.0;data source=" & server.mappath("16-16.mdb")
conn.open connstr
'用于从数据库中获取数据的sql语句
sqlCmd="select title,author,date,content from data order by date desc"
'创建数据集对象
set rs=server.createobject("adodb.recordset")


'从数据库中获取数据
rs.open sqlCmd,conn,1,1

%>
<html>
<head>
<title>Ajax＋Asp实现留言本</title>
<style type="text/css">
<!--
body			{	font-size:0.75em;text-align:center;}
dl				{	margin:0;}
dt				{	background-color:#00ee00;color:#fff000;margin:1px;padding:0 3px;}
dd				{	margin:3px;}
div				{	margin:auto;line-height:150%;text-align:left;width:400px;border:1px solid #666000;}
#postBox		{	margin-top:10px;}
dd.button		{	text-align:center;}
dd.button input	{	margin:0 20px;}
//-->
</style>

<script type="text/javascript">
<!--
//将用户输入异步提交到服务器
function ajaxSubmit(){
	//获取用户输入
	var title=document.forms[0].title.value;
	var author=document.forms[0].author.value;
	var content=document.forms[0].content.value;
	//创建XMLHttpRequest对象
	var xmlhttp;
	try{
		xmlhttp=new XMLHttpRequest();
	}catch(e){
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	//创建请求结果处理程序
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4){
			if (xmlhttp.status==200){
				var date=xmlhttp.responseText;
				addToList(date);
			}else{
				alert("error");
			}
		}
	}
	//打开连接，true表示异步提交
	xmlhttp.open("post", "Add.asp", true);
	//当方法为post时需要如下设置http头
	xmlhttp.setRequestHeader('Content-type','application/x-www-form-urlencoded');
	//发送数据
	xmlhttp.send("title="+escape(title)+"&author="+escape(author)+"&content="+escape(content));
}

//将用户输入显示到页面
function addToList(date){
	//获取留言列表div容器
	var msg=document.getElementById("msgList");
	//创建dl标记及其子标记
	var dl=document.createElement("dl");
	var dt=document.createElement("dt");
	var dd=document.createElement("dd");
	var dd2=document.createElement("dd");
	//将结点插入到相应的位置
	msg.insertBefore(dl,msg.firstChild);
	dl.appendChild(dt);
	dl.appendChild(dd);
	dl.appendChild(dd2);
	//填充留言内容
	dt.innerHTML="标题："+document.forms[0].title.value;
	dd.innerHTML="作者："+document.forms[0].author.value+" &nbsp;日期："+date;
	dd2.innerHTML=document.forms[0].content.value;
	//清空用户输入框
	document.forms[0].title.value="";
	document.forms[0].author.value="";
	document.forms[0].content.value="";
}
//-->
</script>
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
	<form name="theForm" method="post">
		<dl>
			<dt>编辑并提交您的留言</dt>
			<dd>标题：<input type="text" maxlength="150" size="45" name="title"/></dd>
			<dd>作者：<input type="text" maxlength="50" size="45" name="author"/></dd>
			<dd>内容：<textarea rows="5" cols="45" name="content"></textarea></dd>
			<dd class="button">
				<input type="button" onClick="ajaxSubmit()" value="提交"/>
				<input type="reset" value="重填"/>
			</dd>
		</dl>
	</form>
</div>
</body>
</html>