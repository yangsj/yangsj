<?php
	include_once("config.php");
	session_start();
	if(!$_SESSION["start"])
	{
		die("<h1>不能刷新重复发布</h1><a href='index.php'>开始发布</a>");
	}

	$versionNum = $_POST["versionNum"];
	$versionLog = $_POST["versionLog"];

	$versionLog = "此版本更新内容：" . $versionLog;

	if(!$versionNum)
	{
		die("<script>alert('版本号或版本语言不能为空.');history.back();</script>");

	}
	$fullVersion = "ver_".$versionNum;
	echo "<h2>正在提交版本$fullVersion</h2>";
	echo "<hr />";

	echo "<h2>第一步、更新版本库到本地：</h2><div style='color:gray;font-size:8px;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	$svnupdateVers = "svn update ".$versionLibPath." --username ".$svnUser." --password ".$svnPwd;
	system($svnupdateVers);
	echo "</div>";

	$fullversionPath = $versionLibPath.$fullVersion."\\";

	echo $fullversionPath;
	
	$createPathCmd  = "if not exist ".$fullversionPath." md ".$fullversionPath;
	//echo "<h4 style='color:green;'> exec CMD:".$createPathCmd."</h4>";
	system($createPathCmd);
	
	//svn 添加文件夹
	echo "<h4 style='color:green;'>";
	$svnaddFloder = "svn add ". $fullversionPath . " --force";
	system($svnaddFloder);
	echo "</h4>";

	//svn 提交文件夹
	echo "<h4 style='color:green;font-size:8px;'>";
	$svncommitFloder = "svn commit ".$fullversionPath." --username ".$svnUser." --password ".$svnPwd." --message ".$versionLog;
	echo "提交命令行：";
	echo $svncommitFloder;
	//system($svncommitFloder);
	echo "</h4>";
	
	//copy 文件
	//echo "<br>====================================================================================================<br>";
	echo "<h2>第二步、复制文件到版本目录</h2><br>";
	//echo "=====================================================================================================<br>";
	
	echo "<div style='font-size:9px;color:gray;width:800px;height:150px;overflow:scroll;border:1px solid gray;'>";

	system("xcopy /Y ".$releaseFloader."*.swf ".$fullversionPath);
	system("xcopy /Y ".$releaseFloader."application.xml ".$fullversionPath);

	echo "<br />";echo "<br />";

	system("xcopy /S/Y ".$releaseFloader."assets\*.swf ".$fullversionPath."assets\\");

	echo "</div>";
	echo "<br>";
	
	/////////////////////////////////////////////////////////////////
	//设置语言版本
	include_once("changefiles.php");
	$subver = writeVersion($versionRem, $versionNum);
	////////////////////////////////////////////////////////////////


	//echo "<br>========================================================================================================<br>";
	echo "<h2>第三步、提交文件到版本库</h2><br>";
	//echo "===========================================================================================================<br>";

	echo "<div style='font-size:9px;color:blue;width:800px;height:150px;overflow:scroll;border:1px solid gray;'>";
	$svnAddFiles = "svn add ".$fullversionPath."*.* --force";
	system($svnAddFiles);
	echo "</div>";

	echo "<h3 style='font-size:12px;'>";
	echo $svncommitFloder;
	echo "</h3>";


	echo "<div style='font-size:9px;color:green;width:800px;height:100px;overflow:scroll;border:1px solid gray;'>";
	system($svncommitFloder);

	$svncommitVersionRem = "svn commit ".$versionRem." --username ".$svnUser." --password ".$svnPwd." --message ".$versionLog;
	//echo $svncommitVersionRem;
	system($svncommitVersionRem);
	echo "</div>";


	///////更改资源版本信息
	echo "<h3 style='font-size:12px;'>更改资源版本信息</h3>";
	$filename5 = $fullversionPath."\\application.xml";
	$filename6 = $releaseFloader."\\application.xml";
	//echo $filename;
	changeApplicationXmlVersions($filename5, $versionNum, $subver);
	changeApplicationXmlVersions($filename6, $versionNum, $subver);

	system($svncommitFloder);

	echo "<br><h1>发布成功</h1><br>";

	$_SESSION["start"] = null;
?>