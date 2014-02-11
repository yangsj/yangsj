
var className = "TestJsfl";
var packageName = "";
var documentsDes = "documentsDes";
var authorName = "yangsj";
var resourceInformationDes = "";
var cliplinkage = "";
var defaultClassName = "";
var linkageClassName = "";
var fileName = "";

/** main(className,packageName,documentsDes,authorName); **/

function main($className, $packageName, $documentsDes, $authorName)
{
	var doc = fl.getDocumentDOM();
	fl.outputPanel.clear();
	if (! doc)
	{
		alert('Please open a *.fla document first!(请先打开一个fla文件)');
		return '';
	}
	var selectItems = doc.library.getSelectedItems();
	if (! selectItems || selectItems.length < 1)
	{
		alert('Please select an item form the library first!(从库中点选你一个元件)');
		return '';
	}

	if (selectItems.length > 1)
	{
		alert('Dont select more than one item!(不要同时选择多个)');
		return '';
	}
	var selectItem = selectItems[0];
	if (! selectItem.linkageExportForAS)
	{
		alert('Selected clip hasnot the linkageClassName, please input linkageClassName, again!(选择的元件没有连接名称，请输入连接名称，重试!)');
		return '';
	}
	fileName = doc.name;
	fileName = fileName.substr(0,fileName.lastIndexOf("."));
	cliplinkage = selectItem.linkageClassName;
	className = $className;
	packageName = "package " + $packageName + "\n{";
	documentsDes = $documentsDes;
	authorName = $authorName;

	resourceInformationDes = "\n\t *\t\t\t资源文件【" + doc.path + "】<br>\n\t *\t\t\t元 件 名【" + selectItem.name + "】<br>\n\t *\t\t\t连 接 名【" + selectItem.linkageClassName + "】<br>\n\t *\t\t\t创建时间【" + new Date() + "】<br>\n\t *";

	var contentStr = startQuery(selectItem);

	fl.trace(contentStr);

	var url = fl.browseForFolderURL();
	var url1 = url + "/" + className + ".as";
	var url2 = url + "/说明.txt";

	var info = "\t类名：【" + className + ".as" + "】\n";
	info +=  "\t资源文件：【" + doc.path + "】\n";
	info +=  "\t元件名：【" + selectItem.name + "】\n";
	info +=  "\n\t修改或制作人：【" + authorName + "】\n";
	info += "\t生成文件时间为：【" + new Date() + "】\n";
	info +=  "--------------------------------------------------------------------------------\n\n";

	if (FLfile.write(url1,contentStr))
	{
		if (FLfile.write(url2,info,"append"))
		{
			alert('Has successfully keep two files(Class files and documentation)。(已经成功保存两个文件（类文件和说明文件）)');
		}
		else
		{
			alert('Has successfully save the file。(已经成功保存文件)');
		}
	}
	else
	{
		alert("Save the file error, please try again。(保存文件出错，请再试一次!)");
	}

}


function startQuery(item)
{
	linkageClassName = item.linkageClassName;
	if (item.linkageExportForAS)
	{
		var importName = "";
		var textToWrite = "";
		var varsName = "";
		var getFun = "";

		defaultClassName = linkageClassName.substr(linkageClassName.lastIndexOf(".") == -1 ? 0:linkageClassName.lastIndexOf(".") + 1);

		importName +=  "\n\timport flash.display.Sprite;";
		importName +=  "\n\timport pet.core.TempleteSprite;";

		if (! className)
		{
			className = defaultClassName;
		}

		var isFristClip = true;
		var isFristBtn = true;
		var isFristSound = true;
		var isFristText = true;

		if (item.timeline)
		{
			var timeline = item.timeline;
			var layers = timeline.layers;
			for (var ii in layers)
			{
				var layer = timeline.layers[ii];
				var frames = layer.frames;
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
								var boo = false;
								var type00 = "*";
								if (item2.libraryItem)
								{
									var libItem = item2.libraryItem;
									if (libItem.linkageBaseClass)
									{
										boo = true;
										type00 = libItem.linkageBaseClass.substr(libItem.linkageBaseClass.lastIndexOf(".") + 1);
										importName +=  "\n\timport " + libItem.linkageBaseClass + ";";
									}
									else if (libItem.itemType == "movie clip")
									{
										boo = true;
										type00 = "MovieClip";
										if (isFristClip)
										{
											isFristClip = false;
											importName +=  "\n\timport flash.display.MovieClip;";
										}
									}
									else if (libItem.itemType == "button")
									{
										boo = true;
										type00 = "SimpleButton";
										if (isFristBtn)
										{
											isFristBtn = false;
											importName +=  "\n\timport flash.display.SimpleButton;";
										}
									}
									else if (libItem.itemType == "sound")
									{
										boo = true;
										type00 = "Sound";
										if (isFristSound)
										{
											isFristSound = false;
											importName +=  "\n\timport flash.media.Sound;";
										}
									}
								}
								else if (item2 == "[object Text]")
								{
									boo = true;
									type00 = "TextField";
									if (isFristText)
									{
										isFristText = false;
										importName +=  "\n\timport flash.text.TextField;";
									}
								}

								if (boo)
								{
									var strName = item2.name ? item2.name:"";
									var itemDes = item2.description ? item2.description:strName;
									varsName +=  "\n\t\t/**\n\t\t* " + itemDes + "\n\t\t*/";
									varsName +=  "\n\t\tpublic var " + strName + ":" + type00 + ";";
								}
							}
						}
					}
				}
			}
		}

		textToWrite +=  packageName;
		textToWrite +=  importName;
		textToWrite +=  "\n\n\t/**\n\t * 资源信息：<br>" + resourceInformationDes + "\n\t * ……" + documentsDes + "\n\t * @author " + authorName + "\n\t */";
		textToWrite +=  "\n\tpublic class " + className + " extends TempleteSprite\n\t{";
		textToWrite +=  varsName;
		textToWrite +=  "\n\n\t\tpublic function " + className + "()" + "\n\t\t{\n\t\t\tsuper();";
		textToWrite += 	"\n\t\t\tsetSkinWithName(\"" + linkageClassName + "\");";
		textToWrite +=  "\n\t\t}";
		textToWrite +=  "\n\t\t" + getFun;
		textToWrite +=  "\n\n\t}\n\}";

		return textToWrite;
	}
	return "error";
}/** end */