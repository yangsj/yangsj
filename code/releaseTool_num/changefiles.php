<?php
	include_once("log.php");
	
	
	function changeApplicationXmlVersions($file, $versionNum, $subver)
	{
		$verStr = $versionNum ."_". $subver;
		$newFiles = getNewFileName();

		$doc = new DOMDocument();
		$doc->load($file);
		
		$assests = $doc->getElementsByTagName("asset");
		$modules = $doc->getElementsByTagName("module");
		foreach($newFiles as $nfi)
		{
			foreach($assests as $ai)
			{
				$src = $ai->getAttribute("src");
				
				if(strpos($src, $nfi) !== false)
				{
					//echo "ok<br />";
					$ai -> setAttribute("version", $verStr);
				}

				$src = $ai-> nodeValue;

				if(strpos($src, $nfi) !== false)
				{
					$ai -> setAttribute("version", $verStr);
					//echo "ok<br />";
				}
			}

			foreach($modules as $mi)
			{
				$src = $mi->getAttribute("src");
				if(strpos($src, $nfi) !== false)
				{
					$mi -> setAttribute("version", $verStr);
					//echo "ok  $nfi<br />";
				}
			}
		}

		$doc->save($file);
	}


	function changeApplicationXml($file, $versionNum, $subver)
	{
		$filename = $file;
		$appfd = fopen($filename, "r+");
		$contents = fread($appfd, filesize($filename));
		$contents = preg_replace("/version=\"[0-9]+\"/i", "version=\"".$versionNum."_".$subver."\"", $contents);
		fclose($appfd);
		
		$appfd = fopen($filename, "r+");
		fwrite($appfd, $contents);
		fclose($appfd);
	}

	function changeConfigXml($file, $lang)
	{
		$filename = $file;
		$appfd = fopen($filename, "r+");
		$contents = fread($appfd, filesize($filename));

		$contents = preg_replace("/item name=\"language\" value=\"[a-zA-z_0-9]+\"/", "item name=\"language\" value=\"".$lang."\" ", $contents);
		fclose($appfd);
		
		$appfd = fopen($filename, "w+");
		fwrite($appfd, $contents);
		fclose($appfd);
	}
	
?>