<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=gb2312">
		<title>Release Flash</title>
	</head>
	<style>
		input, select
		{
			width:100px;
			
		}
		li
		{
			width:250px;
		}
		li span
		{
			width:100px;
		}
	</style>
	<script language="javascript">
		function formChange()
		{
			versionNum = releaseFlash.versionNum.value;
			verlan = releaseFlash.versionLan.value;

			resultInforDiv = document.getElementById("resultInfor");


			resultInforDiv.innerHTML = "ver_" + versionNum + "_" + verlan + "&nbsp;";

		}
		
		function submitCommit()
		{
			if(releaseFlash.versionNum.value != "")
			{
				if(confirm("你确定要提交版本  (ver_" + versionNum + "_" + verlan + ")  吗？"))
				{
					return true;
				}
				return false;
			}
			else
			{
				alert("版本号不能为空");
				return false;
			}
		}
	</script>
	<body>
		<?php
			include_once("config.php");
			$curver = getCurrentVer($versionRem);
			session_start();
			$_SESSION["start"] = "start"; 
		?>
		<form name="releaseFlash" action="commitApp.php" method="post">
			<h1>Flash 版本提交</h1>
			<h4>当前版本号为：<?php echo $curver[0];?>, 当前版本子号为：<?php echo $curver[1];?></h4>
			<ul>
				<li><span>版本号：</span><input name="versionNum" type="text" value="<?php echo $curver[0];?>" onKeyUp="formChange()" /></li>
				<li>
					更新内容:<textarea name="versionLog" style="height:150px;width:300px;"></textarea>
				</li>
			</ul>
			<div>!!完整版本号为（与版本文件夹相同）：<span id="resultInfor" style="color:red;"></span></div>
			<br />
			<input type="reset" value="重置" onclick="{releaseFlash.reset();}" />
			<input type="submit" value="发布" onclick="{return submitCommit()}" />
		</form>
	</body>
</html>
<script>
formChange();
</script>