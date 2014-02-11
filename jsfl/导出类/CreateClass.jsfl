

var folderUrl;

/*main(true);*/

function main(openFolder)
{
	alert("请选择一个用于代码存储的目录(Please select a directory of storage for code)"); 
	folderUrl =  fl.browseForFolderURL('选择文件夹');
	
	fl.outputPanel.clear();
	
	if (openFolder)
	{
		alert("请选择一个包含Fla文件的目录(Please choose a file containing the Fla directory)"); 
		var folder = fl.browseForFolderURL('选择文件夹');
		var files = FLfile.listFolder(folder+'/*.fla','files');
		
		for(var i = 0;i<files.length;i++)/*遍历所有文件*/
		{
			var doc = fl.openDocument(folder+'/'+files[i])/*打一个文件*/
			startQuery(doc);
		}
	}
	else
	{
		alert("请选择一个Fla文件(Please select a Fla files)"); 
		var fileURL = fl.browseForFileURL("open", "Select file");
		var doc = fl.openDocument(fileURL);
		startQuery(doc);
	}
}

function startQuery(doc)
{
	var libsArr = doc.library.items;

	for (var i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		if (item.linkageExportForAS)
		{
			var importName = "";
			var superName = "";
			var className = "";
			var packageName = "";
			var textToWrite = "";
			var varsName = "";
		
			var string = item.linkageClassName;
		
			packageName = "package " + string.substr(0, string.lastIndexOf(".")) + "\n{";
			className = string.substr(string.lastIndexOf(".") + 1);
		
			if (item.linkageBaseClass)
			{
				importName = "\n\n\timport " + item.linkageBaseClass + ";";
				superName = item.linkageBaseClass.substr(item.linkageBaseClass.lastIndexOf(".") + 1);
			}
			else if (item.itemType == "movie clip")
			{
				importName = "\n\n\timport flash.display.MovieClip;";
				superName = "MovieClip";
			}
			else if (item.itemType == "button")
			{
				importName = "\n\n\timport flash.display.SimpleButton;";
				superName = "SimpleButton";
			}
			else if (item.itemType == "sound")
			{
				importName = "\n\n\timport flash.media.Sound;";
				superName = "Sound";
			}
		
			string = string.replace(/\./g, "/");
			string = string.substr(0, string.lastIndexOf("/"));
		
			if (item.timeline)
			{
				var timeline = item.timeline;
				var layers   = timeline.layers;
				for (var ii in layers)
				{
					var layer   = timeline.layers[ii];
					var frames  = layer.frames;
					for (var j = 0; j < frames.length; j++)
					{
						if (j == frames[j].startFrame)
						{
							var elements = frames[j].elements;
							for (var k = 0; k < elements.length; k++)
							{
								var item2 = elements[k];
								if (item2.name)
								{
									if(item2.libraryItem)
									{
										var libItem = item2.libraryItem;
									
										if (libItem.linkageBaseClass)
										{
											importName += "\n\timport " + libItem.linkageBaseClass + ";";
											varsName += "\n\t\tpublic var " + item2.name + ":" + libItem.linkageBaseClass.substr(libItem.linkageBaseClass.lastIndexOf(".") + 1) + ";";
										}
										else if (libItem.itemType == "movie clip")
										{
											importName += "\n\timport flash.display.MovieClip;";
											varsName += "\n\t\tpublic var " + item2.name + ":MovieClip";
										}
										else if (libItem.itemType == "button")
										{
											importName += "\n\timport flash.display.SimpleButton;";
											varsName += "\n\t\tpublic var " + item2.name + ":SimpleButton";
										}
										else if (libItem.itemType == "sound")
										{
											importName += "\n\timport flash.media.Sound;";
											varsName += "\n\t\tpublic var " + item2.name + ":Sound";
										}
									}
									else if (item2 == "[object Text]")
									{
										importName += "\n\timport flash.text.TextField;";
										varsName += "\n\t\tpublic var " + item2.name + ":TextField";
									}
								}
							}
						}
					}
				}
			}
		
			textToWrite += packageName;
			textToWrite += importName;
			textToWrite += "\n\n\tpublic class " + className + " extends "+superName + "\n\t{";
			textToWrite += varsName;
			textToWrite += "\n\n\t\tpublic function " + className + "()" + "\n\t\t{\n\t\t\tsuper();\n\t\t}";
			textToWrite += "\n\n\t}\n\}";
		
			FLfile.createFolder(folderUrl + "/" + string);
			FLfile.write(folderUrl + "/" + string + "/" + className + ".as", textToWrite);
		
		}
	}
}



