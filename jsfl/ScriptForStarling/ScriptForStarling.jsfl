
var className = "";
var packageName = "";
var authorName = "";

var varsString = ""; // 变量声明部分
var initFunString = ""; // 变量创建方法部分
var templateStr = "";//模版文件内容

var doc = null;
var selectItem = null;
var selectItems = null;

//main(className,packageName,authorName); 

function main($className, $packageName, $authorName)
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
		alert('从库中点选一个元件');
		return '';
	}
	if(selectItems.length > 1)
	{
		alert('不要同时选择多个元件');
		return '';
	}
	selectItem = selectItems[0];
	if ( !$className )
	{
		var linkageClassName = selectItem.linkageClassName;
		if ( linkageClassName )
		{
			$className = linkageClassName.substr(linkageClassName.lastIndexOf(".") + 1);
		} 
		if ( !$className )
		{
			alert('类名称或元件连接名不能为空');
			return '';
		}
	}
	
	className = $className;
	packageName = $packageName;
	authorName = $authorName ? $authorName : "null";
	
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
		saveFile();
	}
	else
	{
		var st = "制作规范参见：\n";
		st += "1、需指定类名称，或者给选择的元件加一个连接名\n";
		st += "2、注意资源整理事项：\n";
		st += " 布局元件：（选择生成类文件的元件）\n";
		st += "  1）给每个图片元素添加连接名称\n";
		st += "  2）在一个元件中布局元素\n";
		st += "  3）布局元件中只能包含元件和文本框两中类型\n";
		st += " 布局元件里的元素：\n";
		st += "  4）布局元件中的元件里必须是图片，可以多帧\n";
		st += "  5）元件里的每个关键帧只能一张图片\n";
		st += "  6）布局元件中的元件里若是多帧，\n";
		st += "  7）若是多帧，实例名含\"btn\"则为(starling)Button\n";
		st += "  8）若是多帧，实例名含\"mc\"则为(starling)MovieClip\n";
		st += "  9）没有实例名的默认(starling)Image";
		alert(st);
	}
}

function saveFile()
{
	//var url = "file:///C|/Users/yangshengjin/Desktop/ScriptForStarling/ScriptForStarling_Template.txt";
	var url = fl.configURI+"/WindowSWF/ScriptForStarling_Template.txt";
 	templateStr = FLfile.read(url);
	fl.trace( templateStr );
	
	// 从已有的模版替换
	var contentStr = templateStr;
	contentStr = contentStr.replace(/{@package}/g, packageName);
	contentStr = contentStr.replace(/{@className}/g, className);
	contentStr = contentStr.replace(/{@authorName}/g, authorName);
	contentStr = contentStr.replace(/{@createTime}/g, new Date());
	contentStr = contentStr.replace(/{@vars}/g, varsString);
	contentStr = contentStr.replace(/{@initFunVars}/g, initFunString);
	fl.trace( contentStr );
	
	var url = fl.browseForFolderURL();
	var url1 = url + "/"+className + ".as";
	var url2 = url + "/说明.txt";
	
	var info = "\t类名：【"  + className + ".as" + "】\n";
	info += "\t资源文件：【" + doc.path + "】\n";
	info += "\t元件名：【" + selectItem.name + "】\n";
	info += "\n\t修改或制作人：【" + authorName + "】\n";
	info += "\t生成文件时间为：【" + new Date() + "】\n";
	info += "--------------------------------------------------------------------------------\n";
	
	if (FLfile.write(url1, contentStr))
	{
		if (FLfile.write(url2, info, "append"))
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
						var itemName = item2.name ? item2.name : "instance_" + i+"_"+j+"_"+k;
						if ( item2.instanceType == "symbol" || item2.elementType == "text" )
						{
							initFunString += "\n\t\t\tif ( " + itemName + " == null )";
							initFunString += "\n\t\t\t{";
							var clsType = "";
							if ( item2.instanceType == "symbol" )
							{
								var result = movieClip( item2 );
								if ( !result[0] ) return false;
								var ary = result[1];
								if ( ary && ary.length > 0 )
								{
									clsType = ":Image;";
									if ( itemName.substr(0, 3) == "btn" ) {
										clsType = ":Button;";
										initFunString += "\n\t\t\t\tupSkin = "+getTexture( ary[0] ) + ";";
										if ( ary.length == 2 ) {
											initFunString += "\n\t\t\t\tdownSkin = "+getTexture( ary[1] ) + ";";
											initFunString += "\n\t\t\t\t" + itemName + " = new Button( upSkin, \"\", downSkin );";
										} else {
										initFunString += "\n\t\t\t\t" + itemName + " = new Button( upSkin, \"\", null );";
										}
									}else if ( ary.length > 1 && itemName.substr(0, 2) == "mc" ) {
										clsType = ":MovieClip;";
										initFunString += "\n\t\t\t\tvec = new Vector.<Texture>();";
										for each ( var uiSkin in ary ) {
											initFunString += "\n\t\t\t\tvec.push( " + getTexture(uiSkin) + " );";
										}
										initFunString += "\n\t\t\t\t" + itemName + " = new MovieClip( vec );";
										initFunString += "\n\t\t\t\tStarling.juggler.add( " + itemName + " );";
										initFunString += "\n\t\t\t\t" + itemName + ".stop();";
									}else {
										initFunString += "\n\t\t\t\t" + itemName + "= new Image( " + getTexture( ary[0] ) + " );";
									}
								}
							}
							else
							{
								var textAttrs = item2.textRuns[0].textAttrs;
								clsType = ":TextField;";
								initFunString += "\n\t\t\t\t" + itemName + "= new TextField( "+item2.width+", "+item2.height+", \""+item2.getTextString()+"\", \""+textAttrs.face+"\", "+textAttrs.size+", 0x"+textAttrs.fillColor.substr(1) +", "+textAttrs.bold+" );";
								if ( "justify" != textAttrs.alignment ) {
									initFunString += "\n\t\t\t\t" + itemName + ".hAlign = \"" + textAttrs.alignment + "\";";
								}
								initFunString += "\n\t\t\t\t" + itemName + ".border			= " + item2.border + ";";
								initFunString += "\n\t\t\t\t" + itemName + ".italic			= " + textAttrs.italic + ";";
								initFunString += "\n\t\t\t\t" + itemName + ".kerning		= " + textAttrs.autoKern + ";";
							}
							if ( clsType ) {
								// 创建变量声明
								if ( item2.description ) {
									varsString += "\n\n\t\t/** " + item2.description + " */";
								}
								varsString += "\n\t\tpublic var " + itemName + clsType;
								//
								initFunString += "\n\t\t\t\t" + itemName + ".name		= \"" + itemName + "\";";
								initFunString += "\n\t\t\t\t" + itemName + ".x			= " + item2.x + ";";
								initFunString += "\n\t\t\t\t" + itemName + ".y			= " + item2.y + ";";
								initFunString += "\n\t\t\t}";
								initFunString += "\n\t\t\taddChild( " + itemName + " );\n";
							}
						}
						else
						{
							alert( "当前选择的布局元件只能包含元件和文本框两种元素。" );
							return false;
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

function getTexture(skin)
{
	return "Texture.fromBitmapData( new (getDefinitionByName(\"" + skin + "\") as Class)())";
}


////////////////////////////////////////

function openTemplateFla()
{
	//var url1 = "file:///C|/Users/yangshengjin/Desktop/ScriptForStarling/ScriptForStarling_Template.fla";
	var url1 = fl.configURI+"/WindowSWF/ScriptForStarling_Template.fla";
	var url2 = fl.configURI+"/ScriptForStarling_Template.fla";
	FLfile.copy(url1, url2);
	fl.openDocument( url2 );
}