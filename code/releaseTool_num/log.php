<?php
	include_once("config.php");
	
	function getNewFileName()
	{
		global $versionLibPath;
		$tempfileName = time().".xml";
		$exc = "svn diff ". $versionLibPath." -r head:prev --summarize --xml >>".$tempfileName;
		//echo $exc;
		 exec($exc);

		//echo "<br>";

		/*
		$tfh = fopen($tempfileName, "r+");
		$out = fread($tfh, filesize($tempfileName));
		fclose($tfh);
		*/

		$doc = new DOMDocument();
		$doc->load($tempfileName);
	  
		$items = $doc->getElementsByTagName("path");

		$fileNames = array();
		foreach($items as $i)
		{
			$lpos = strrpos($i->nodeValue, '\\');
			
			$fname = substr($i->nodeValue, $lpos + 1);
			array_push($fileNames, $fname);

			//print_r($i->nodeValue."<br />");
		}
		try
		{
			unlink($tempfileName);
		}
		catch(Exception $e)
		{
			exec("del ".$tempfileName);
		}
		
		//print_r($fileNames);
		return $fileNames;
	}

?>