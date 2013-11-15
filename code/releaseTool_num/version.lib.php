<?php
	//item: vernum:subnum;

	function getVersions($versionFile)
	{
		
		$fd = fopen($versionFile, "a+");
		$content = "";
		$fsize = filesize($versionFile);
		if($fsize > 0)
		{
			$content = fread($fd, $fsize);
		}
		fclose($fd);

		$ta2 = array();

		if(strlen($content) > 0)
		{
			$ta1 = explode(";", $content);
			
			foreach($ta1 as $va1)
			{
				//array_push($ta2, explode(":", $va1) );
				$vaa =  explode(":", $va1);
				if($vaa[0])
				{
					$ta2[$vaa[0]] = $vaa[1];
				}
			}
		}
		//print_r($ta2);
		ksort($ta2);
		return $ta2;
	}
	
	function writeVersToFile($versionFile, $verArray)
	{
		$verStr = "";
		//asort($verArray);
		foreach($verArray as $k => $v)
		{
			$verStr .= $k.":".$v.";";
		}

		$fd = fopen($versionFile, "r+");
		fwrite($fd, $verStr);
		fclose($fd);
	}

	//返回版本子号
	function writeVersion($versionFile, $versionNum)
	{
		//try
		//{
			$vers = getVersions($versionFile);
			$vers[$versionNum] = $vers[$versionNum];
			if($vers[$versionNum])
			{
				$vers[$versionNum] ++;
			}
			else
			{
				$vers[$versionNum] = 1;
			}

			writeVersToFile($versionFile, $vers);
		/*}
		catch(Exception $e)
		{
			echo $e;
		}*/

		return $vers[$versionNum];
	}
	//取得当前版本返回[主版本号，子版本号]
	function getCurrentVer($versionFile)
	{
		$vers = getVersions($versionFile);
		$keys = array_keys($vers);
		$lk = $keys[sizeof($keys) - 1];
		$ra=array($lk, $vers[$lk]);

		/*foreach($vers as $k => $v)
		{
			$ra = array($k, $v);
		}*/
		return $ra;
	}
	
	//print_r(getCurrentVer($versionRem));
	
?>