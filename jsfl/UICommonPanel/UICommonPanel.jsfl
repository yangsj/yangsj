
var className = "Alert";
var packageName = "";
var authorName = "";
var importStr = "";
var isSwc = "";
var skinName = "";

var varsString = ""; // 变量声明部分
var initFunString = ""; // 变量创建方法部分
var templateStr = "";//模版文件内容

var doc = null;
var selectItems = null;

var arrClass;
var arrInfo;

//main(className,packageName,authorName,false); 

function main($className, $packageName, $authorName, $isSwc)
{
	doc = fl.getDocumentDOM(); 
	fl.outputPanel.clear();
	if(!doc)  
	{ 	
		alert('请先打开一个fla文件');
		return '';
	}
	selectItems = doc.library.getSelectedItems();
	if(!selectItems || selectItems.length < 1)
	{
		alert('从库中至少选中一个元件');
		return '';
	}
	if(selectItems.length > 1 && $className)
	{
		alert('同时选择多个元件时不能指定类名');
		return '';
	}
	
	packageName = $packageName;
	authorName = $authorName ? $authorName : "null";
	isSwc = $isSwc;// ? "true" : "false";
	
	arrClass = [];
	arrInfo = [];
	
	if (　selectItems.length == 1 )
	{
		loopSelected( selectItems[0], $className );
	}
	else if ( selectItems.length > 1 && !$className )
	{
		for each ( var item in selectItems )
		{
			if ( item )
			{
				loopSelected(item, "");
			}
		}
	}
	
	saveFileToLocal();
}

function loopSelected(selectItem, $className)
{
	skinName = selectItem.linkageClassName;
	if ( !skinName )
	{
		alert('元件连接名不能为空');
		return '';
	}
	if ( !$className )
	{
		if ( skinName )
		{
			$className = skinName.substr(skinName.lastIndexOf(".") + 1);
		} 
		if ( !$className )
		{
			alert('类名称或元件连接名不能为空');
			return '';
		}
	}
	if ( skinName.lastIndexOf(".") != -1 )
	{
		importStr += "import " + skinName + ";\n\t";
	}
	
	className = $className;
	
	var leng = className.length;
	var headStr1 = "ABCDEFGHIJKLMNOPQRSTUVWXZY_$";
	var headStr2 = "ABCDEFGHIJKLMNOPQRSTUVWXZY_$abcdefghijklmnopqrstuvwxzy";
	var classStr = headStr2 + "0123456789";
	for ( var i = 0; i < leng; i++ )
	{
		var s = className.charAt(i);
		if ( i == 0 )
		{
			if ( headStr2.indexOf( s ) == -1 )
			{
				alert("类名必须以字母、\"_\"或\"$\"开头。");
				return " ";
			}
			else if ( headStr1.indexOf( s ) == -1 )
			{
				alert( "警告：根据约定，ActionScript 类型名以大写字母开头。(确认继续)" );
			}
		}
		else if ( classStr.indexOf( s ) == -1 )
		{
			alert("类名只能包含字母、数字、\"_\"或\"$\"。");
			return " ";
		}
	}
	
	if ( outputItemOfTimeline(selectItem.timeline) )
	{
		saveFile(selectItem);
	}
	else
	{
		var st = "请查看帮助";
		alert(st);
	}
}

function saveFile(selectItem)
{
	//var url = "file:///D|/work/yangsj/yangsj/jsfl/UICommonPanel/Class_Template.txt";
	var url = fl.configURI+"/WindowSWF/UICommonPanel/Class_Template.txt";
 	templateStr = FLfile.read(url);
	
	// 从已有的模版替换
	var contentStr = templateStr;
	contentStr = contentStr.replace(/{@package}/g, packageName);
	contentStr = contentStr.replace(/{@className}/g, className);
	contentStr = contentStr.replace(/{@authorName}/g, authorName);
	contentStr = contentStr.replace(/{@createTime}/g, new Date());
	contentStr = contentStr.replace(/{@vars}/g, varsString);
	contentStr = contentStr.replace(/{@boolean}/g, isSwc);
	contentStr = contentStr.replace(/{@skinName}/g, skinName);
	contentStr = contentStr.replace(/{@import}/g, importStr);
	//fl.outputPanel.trace( contentStr );
	
	var info = "\t类名：【"  + className + ".as" + "】\n";
	info += "\t资源文件：【" + doc.path + "】\n";
	info += "\t元件名：【" + selectItem.name + "】\n";
	info += "\n\t修改或制作人：【" + authorName + "】\n";
	info += "\t生成文件时间为：【" + new Date() + "】\n";
	info += "--------------------------------------------------------------------------------\n";
	
	arrClass.push( [className, contentStr] );
	arrInfo.push( info );
}

function saveFileToLocal()
{
	var length = arrClass.length;
	if ( length > 0 )
	{
		var url = fl.browseForFolderURL();
		for ( var i = 0; i < length; i++ )
		{
			var url1 = url + "/" + arrClass[i][0] + ".as";
			var url2 = url + "/说明.txt";
			var cls = arrClass[i][1];
			fl.outputPanel.trace( url1 );
			fl.outputPanel.trace( url2 );
			fl.outputPanel.trace( "******************" );
			fl.outputPanel.trace( cls );
			if (FLfile.write(url1, cls))
			{
				if (FLfile.write(url2, arrInfo[i], "append"))
				{
					alert('类文件和日志文件成功保存');
				}
				else
				{
					alert('已经成功保存文件');
				}
				
			}
			else
			{
				alert("保存文件出错，请再试一次!");
			}
		}
	}
}

function outputItemOfTimeline(timeline)
{
	var layers   = timeline.layers;
	for (var i in layers)
	{
		var layer   = timeline.layers[i];
		var frames  = layer.frames;
		if (layer.layerType != "guide" && layer.layerType != "guided") 
		{
			for (var j = 0; j < frames.length; j++)
			{
				if (j == frames[j].startFrame)
				{
					var elements = frames[j].elements;
					for (var k = 0; k < elements.length; k++)
					{
						var item2 = elements[k];
						var itemName = item2.name;
						if ( itemName )
						{
							var libItemType  = item2.libraryItem ? item2.libraryItem.itemType : "text";
							var clsType = "";
							if ( libItemType == "movie clip" )
							{
								clsType = "MovieClip";
							}
							else if ( libItemType == "button" )
							{
								clsType = "SimpleButton";
							}
							else if ( libItemType == "sound" )
							{
								clsType = "Sound";
							}
							else if ( libItemType == "bitmap" )
							{
								clsType = "Bitmap";
							}
							else if ( libItemType == "text" )
							{
								clsType = "TextField";
							}
							if ( clsType ) {
								// 创建变量声明
								if ( item2.description ) {
									varsString += "\n\n\t\t/** " + item2.description + " */";
								}
								varsString += "\n\t\tpublic var " + itemName + ":" + clsType + ";";
							}
							else
							{
								alert( "非法元素" );
								return false;
							}
						}
					}
				}
			}
		}
	}
	return true;
}



function movieClip( item )
{
	var libraryItem = item.libraryItem;
	var timeline = libraryItem.timeline;
	var layer   = timeline.layers[0];
	var ary = [];
	var frames  = layer.frames;
	if (layer.layerType != "guide" && layer.layerType != "guided") 
	{
		for (var j = 0; j < frames.length; j++)
		{
			if (j == frames[j].startFrame)
			{
				var elements = frames[j].elements;
				if ( elements.length > 1 )
				{
					alert( "警告：布局元件中实例名为【" + item.name + "】的元素库中名称【" +libraryItem.name+ "】的第" + (j + 1) + "个关键帧出现多个元素将只有一个元素有效。" );
				}
				var item2 = elements[0];
				if ( item2.instanceType != "bitmap" )
				{
					alert("不能出现元件套元件！！！");
					return [false, ary];
				}
				ary.push(item2.libraryItem.linkageClassName);
			}
		}
	}
	return [true, ary];
}


////////////////////////////////////////

function openTemplateFla()
{
	//var url1 = "file:///D|/work/yangsj/yangsj/jsfl/UICommonPanel/UICommonPanel_Template.fla";
	var url1 = fl.configURI+"/WindowSWF/UICommonPanel/UICommonPanel_Template.fla";
	var url2 = fl.configURI+"/UICommonPanel_Template.fla";
	FLfile.copy(url1, url2);
	fl.openDocument( url2 );
}