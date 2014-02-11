var importArr	= new Array(); /* 导入包名 */
var nameArr		= new Array(); /* 变量名称 */
var desArr		= new Array(); /* 描述 */
var attrArr		= new Array(); /* 属性 */
var clsArr		= new Array(); /* 类 */
var typeArr		= new Array(); /* 类名 */
var tfAttrArr	= new Array(); /* 文本属性 */
var filterArr	= new Array(); /* 滤镜 */
var tfUseFonts	= new Array(); /* 文本框所用的字体是动画消齿（嵌入字体）或设备字体 */
var tfLineType	= new Array(); /* 文本框线条类型 "single line"、"multiline"、"multiline no wrap" 或 "password" */

var className = "";/*"TestJsfl"*/;
var packageName = "";
var documentsDes = " ";
var authorName = " ";
var changeName = " ";
var readFonts = "false";
var resourceInformationDes = " ";
var isSuccessed = false;

/*main(className,packageName,documentsDes,authorName,changeName,readFonts)*/;

function main($className, $packageName, $documentsDes, $authorName, $changeName, $readFonts)
{
	var doc = fl.getDocumentDOM(); 
	fl.outputPanel.clear();
	if(!doc)  
	{ 	
		alert('Please open a *.fla document first!(请先打开一个fla文件)');
		return '';
	}
	var selectItems = doc.library.getSelectedItems();
	if(!selectItems || selectItems.length < 1)
	{
		alert('Please select an item form the library first!(从库中点选你要导出的元件)');
		return '';
	}
	
	if(selectItems.length > 1)
	{
		alert('Dont select more than one item!(不要同时选择多个)');
		return '';
	}
	var selectItem = selectItems[0];
	
	className = $className;
	packageName = $packageName;
	documentsDes = $documentsDes;
	authorName = $authorName;
	changeName = $changeName;
	readFonts	= true;//$readFonts;
	resourceInformationDes = "\n\t *\t\t\t资源文件【" + doc.path + "】<br>\n\t *\t\t\t元 件 名【" + selectItem.name + "】<br>\n\t *\t\t\t连 接 名【" + selectItem.linkageClassName + "】<br>\n\t *";
	
	if (!className && selectItem.linkageClassName)
	{
		var tempS = selectItem.linkageClassName;
		var lndex = tempS.lastIndexOf(".") + 1;
		className = tempS.substr(lndex);
		if (!packageName)
		{
			packageName = lndex == 0 ? "" : tempS.substr(0, lndex - 1);
		}
	}
	else
	{
		alert("请输入类名称或给当前指定元件加链接名做类");
	}
	
	var timeline = selectItem.timeline;
	outputItemOfTimeline(timeline);
	
	if (isSuccessed == false)
	{
		return ;
	}
	
	fl.trace(startingStr() + analysisVars() + analysisStructure() + analysisCase() + endingStr());
	var contentStr = startingStr() + analysisVars() + analysisStructure() + analysisCase() + endingStr();
	var url = fl.browseForFolderURL();
	var url1 = url + "/"+className + ".as";
	var url2 = url + "/说明.txt";
	
	var info = "\t类名：【"  + className + ".as" + "】\n";
	info += "\t资源文件：【" + doc.path + "】\n";
	info += "\t元件名：【" + selectItem.name + "】\n";
	info += "\n\t修改或制作人：【" + authorName + "】\n";
	info += "\t本次修改内容：【" + (changeName == " " ? "本次并无修改" : changeName) + "】\n";
	info += "\t生成文件时间为：【" + new Date() + "】\n";
	info += "--------------------------------------------------------------------------------\n\n";
	
	if (FLfile.write(url1, contentStr))
	{
		if (FLfile.write(url2, info, "append"))
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
						if(item2.libraryItem)
						{
							var libItem  = item2.libraryItem;
							var itemCls	 = libItem.linkageClassName;
						
							if (itemCls)
							{
								var itemName = item2.name ? item2.name : "";
								var itemDes  = item2.description ? item2.description : "";
								nameArr.push(itemName);
								desArr.push(itemDes);
								clsArr.push(itemCls);
								attrArr.push([item2.x, item2.y, item2.width, item2.height, item2.scaleX, item2.scaleY, item2.colorAlphaPercent, item2.rotation, item2.getFilters()]);
								tfAttrArr.push([]);
								tfUseFonts.push(true);
								tfLineType.push(" ");
						
								if (item2.getFilters().length > 0)
								{
									analysisFiltersArr(item2.getFilters());
								}
								else
								{
									filterArr.push(" ");
								}
							
								if (itemCls.lastIndexOf(".") > -1)
								{
									var temparrStr = importArr.toString();
									if (temparrStr.search("import " + itemCls + ";") == -1)
									{
										importArr.push("\n\timport " + itemCls + ";");
									}
								}
								typeArr.push(itemCls);
							}
							else
							{
								alert("已经检测到该元件中包含的元素在库中未有 连接名称 ， 请重新检查...");
								return ;
							}
						}
						else if (item2.elementType == "text")
						{
							var libItem  = item2.libraryItem;
							var itemName = item2.name ? item2.name : "";
							var itemDes  = item2.description ? item2.description : "";
							var itemCls	 = "text_field";
							nameArr.push(itemName);
							desArr.push(itemDes);
							clsArr.push(itemCls);
							attrArr.push([item2.x, item2.y, item2.width, item2.height, item2.scaleX, item2.scaleY, 100, item2.rotation, item2.getFilters()]);
							tfAttrArr.push(item2.textRuns[0].textAttrs);
							tfUseFonts.push(item2.useDeviceFonts);
							typeArr.push("TextField");
							tfLineType.push(item2.lineType);
						
							var temparrStr = importArr.toString();
							if (temparrStr.search("import flash.text.TextFormat;") == -1)
							{
								importArr.push("\n\timport flash.text.TextFormat;");
								importArr.push("\n\timport flash.text.TextField;");
							}
							if (item2.getFilters().length > 0)
							{
								analysisFiltersArr(item2.getFilters());
							}
							else
							{
								filterArr.push(" ");
							}
						}
						else
						{
							alert("解析的元件的第一次不能包含除元件和文本框以外的元素， 请重新检查该元件中的元素...");
							return ;
						}
					}
				}
			}
		}
		
	}
	isSuccessed = true;
}

function analysisFiltersArr($filter)
{
	if ($filter.length > 0)
	{
		var arr = new Array();
		for each( var i in $filter)
		{
			var str = i.name.substr(0,1);
			str = str.toLocaleUpperCase() + i.name.substr(1);
			var temparrStr = importArr.toString();
			if (temparrStr.search("import flash.filters."+ str + ";") == -1)
			{
				importArr.push("\n\timport flash.filters."+ str + ";");
			}
			arr.push(str);
		}
		filterArr.push(arr);
	}
}

/* 变量声明 */
function analysisVars()
{
	var vars = "";
	var leng = nameArr.length;
	for (var i = 0; i < leng; i++)
	{
		var strName = nameArr[i] && nameArr[i].length > 0 ? nameArr[i] : "nameRes_" + i;
		vars += "\n\t\tprivate var _" + strName + ":" + typeArr[i] + ";";
	}
	return vars;
}
/* 实例变量 */
function analysisCase()
{
	var cases = "";
	var getFun = "";
	var leng = clsArr.length - 1;
	cases += "\n\t\tprivate function initVars():void";
	cases += "\n\t\t{";
	for (var i = leng; i > -1; i--)
	{
		var strName = nameArr[i] && nameArr[i].length > 0 ? nameArr[i] : "nameRes_" + i;
		if (clsArr[i])
		{
			getFun += "\n\t\t/**\n\t\t* " + desArr[i] + "\n\t\t*/";
			getFun += "\n\t\tpublic function get " + strName + "():" + typeArr[i];
			getFun += "\n\t\t{";
			getFun += "\n\t\t\treturn _" + strName + ";";
			getFun += "\n\t\t}\n";
			
			cases += "\n\t\t\tif (_" + strName + " == null)";
			cases += "\n\t\t\t{";
				
			if (clsArr[i] == "text_field")
			{
				cases += "\n\t\t\t\t_" + strName + "			= new TextField();";
				cases += "\n\t\t\t\tvar textFormat"+ i + ":TextFormat	= new TextFormat();";
				
				cases += "\n\t\t\t\ttextFormat"+ i + ".bold		= " + tfAttrArr[i].bold + ";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".color	= 0x" + tfAttrArr[i].fillColor.substr(1) + ";";
				if (readFonts == "false")
				{
					if (tfUseFonts[i] == true)
					{
						cases += "\n\t\t\t\ttextFormat"+ i + ".font	= \"" + tfAttrArr[i].face + "\";";
						cases += "\n\t\t\t\t_" + strName + ".embedFonts	= false;";
					}
					else
					{
						cases += "\n\t\t\t\ttextFormat"+ i + ".font	= CharacterStyle.typeName;";
						cases += "\n\t\t\t\t_" + strName + ".embedFonts	= true;";
					}
				}
				else
				{
					cases += "\n\t\t\t\ttextFormat"+ i + ".font	= \"" + tfAttrArr[i].face + "\";";
					/*cases += "\n\t\t\t\t_" + strName + ".embedFonts	= false;";*/
				}
				
				cases += "\n\t\t\t\ttextFormat"+ i + ".size	= \"" + tfAttrArr[i].size + "\";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".italic	= " + tfAttrArr[i].italic + ";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".align	= \"" + tfAttrArr[i].alignment + "\";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".leftMargin	= " + tfAttrArr[i].leftMargin + ";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".rightMargin	= " + tfAttrArr[i].rightMargin + ";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".leading	= " + tfAttrArr[i].lineSpacing + ";";
				cases += "\n\t\t\t\ttextFormat"+ i + ".indent	= " + tfAttrArr[i].indent + ";";
				if (tfLineType[i] == "single line")
				{
					cases += "\n\t\t\t\t_" + strName + ".multiline	= false;";
					cases += "\n\t\t\t\t_" + strName + ".wordWrap	= false;";
				}
				else if (tfLineType[i] == "multiline")
				{
					cases += "\n\t\t\t\t_" + strName + ".multiline	= true;";
					cases += "\n\t\t\t\t_" + strName + ".wordWrap	= true;";
				}
				else if (tfLineType[i] == "multiline no wrap")
				{
					cases += "\n\t\t\t\t_" + strName + ".multiline	= true;";
					cases += "\n\t\t\t\t_" + strName + ".wordWrap	= false;";
				}
				else if (tfLineType[i] == "password")
				{
					cases += "\n\t\t\t\t_" + strName + ".multiline	= false;";
					cases += "\n\t\t\t\t_" + strName + ".displayAsPassword = true;";
				}
				
				cases += "\n\t\t\t\t_" + strName + ".selectable = false;";
				cases += "\n\t\t\t\t_" + strName + ".mouseEnabled = false;";
				cases += "\n\t\t\t\t_" + strName + ".defaultTextFormat	= textFormat"+ i + ";\n";
			}
			else
			{
				cases += "\n\t\t\t\t_" + strName + "	= new " + clsArr[i] + "();";
			}
			
			cases += "\n\t\t\t\t_" + strName + ".name	= \"_" + strName + "\";";
			cases += "\n\t\t\t\t_" + strName + ".x	= " + attrArr[i][0] + ";";
			cases += "\n\t\t\t\t_" + strName + ".y	= " + attrArr[i][1] + ";";
			cases += "\n\t\t\t\t_" + strName + ".width	= " + attrArr[i][2] + ";";
			cases += "\n\t\t\t\t_" + strName + ".height	= " + attrArr[i][3] + ";";
			cases += "\n\t\t\t\t_" + strName + ".scaleX	= " + attrArr[i][4] + ";";
			cases += "\n\t\t\t\t_" + strName + ".scaleY	= " + attrArr[i][5] + ";";
			cases += "\n\t\t\t\t_" + strName + ".alpha	= " + (attrArr[i][6] * 0.01) + ";";
			cases += "\n\t\t\t\t_" + strName + ".rotation	= " + attrArr[i][7] + ";";
			
			var tempVar = attrArr[i][8];
			if (tempVar.length > 0)
			{
				var tarr2, tarr1;
				tarr2 = new Array();
				for (var j=0; j < tempVar.length; j++)
				{
					tarr1 = new Array();
					
					var strVarName = tempVar[j]["name"] + j + "" + i;
					cases += "\n\n\t\t\t\tvar _" + strVarName + ":" + filterArr[i][j] + " = new " + filterArr[i][j] + "();";
					for (var k in tempVar[j])
					{
						tarr1.push([k, tempVar[j][k]]);
					}
					for (var ii = 0; ii < tarr1.length; ii++)
					{
						if (tarr1[ii][0] == "colorArray")
						{
							var arrcolor = new Array();
							var tecolor = tarr1[ii][1];
							for (var iii = 0; iii < tecolor.length; iii++)
							{
								arrcolor.push("0x"+tecolor[iii].substr(1));
							}
							cases += "\n\t\t\t\t_" + strVarName + "[\"colors\"]	= [" + arrcolor + "];";
						}
						else if (tarr1[ii][0] == "posArray")
						{
							cases += "\n\t\t\t\t_" + strVarName + "[\"ratios\"]	= [" + tarr1[ii][1] + "];";
						}
						else
						{
							cases += "\n\n\t\t\t\tif (_" + strVarName + ".hasOwnProperty(\"" + tarr1[ii][0] +"\"))\n\t\t\t\t{";
							if (tarr1[ii][0] == "color" || tarr1[ii][0] == "shadowColor" || tarr1[ii][0] == "highlightColor")
							{
								var str = tarr1[ii][1];
								str = "0x" + str.substr(1);
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"]	= " + str + ";";
							}
							else if (tarr1[ii][0] == "name" )
							{
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"] = \"" + tarr1[ii][1] + "\";";
							}
							else if (tarr1[ii][0] == "quality")
							{
								var qua = tarr1[ii][1] == "low" ? 1 : (tarr1[ii][1] == "high" ? 3 : 2);
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"] = " + qua + ";";
							}
							else if (tarr1[ii][0] == "type")
							{
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"] = \"" + tarr1[ii][1] + "\";";
							}
							else if (tarr1[ii][0] == "colorArray")
							{
								
							}
							else if (tarr1[ii][0] == "posArray")
							{
							
							}
							else if (tarr1[ii][0] == "strength")
							{
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"] = " + (tarr1[ii][1] * 0.01) + ";";
							}
							else
							{
								cases += "\n\t\t\t\t\t_" + strVarName + "[\"" + tarr1[ii][0] + "\"] = " + tarr1[ii][1] + ";";
							}
							cases += "\n\t\t\t\t}";
						}
					}
					tarr2.push("_" + strVarName);
				}
				cases += "\n\t\t\t\t_" + strName + ".filters	= \[" + tarr2 + "\];";
			}
			
			
			cases += "\n\t\t\t}";	
			cases += "\n\t\t\taddChild(_" + strName + ");\n";
		}
	}
	cases += "\n\t\t}\n";
	return cases + getFun;
}
/* 构造函数 */
function analysisStructure()
{
	var structure = "";
	structure += "\n\n\t\tpublic function " + className + "()";
	structure += "\n\t\t{";
	structure += "\n\t\t\tsuper();";
	structure += "\n\t\t\tinitVars();";
	structure += "\n\t\t}\n";
	
	return structure;
}
/* 包和类起始 */
function startingStr()
{
	var imports = "";
	imports += "package " + packageName + "\n{";
	
	for (var i = 0; i < importArr.length; i++)
	{
		if (importArr[i])
		{
			imports += importArr[i];
		}
	}
	
	imports += "\n\timport flash.display.Sprite;\n";
	imports += "\n";
	imports += "\n\t/**\n\t * 资源信息：<br>" + resourceInformationDes + "\n\t * 文档说明：" + documentsDes + "\n\t * @author " + authorName + "\n\t */";
	imports += "\n\tpublic class " + className + " extends Sprite";
	imports += "\n\t{";
	
	return imports;
}
/* 包和类结束 */
function endingStr()
{
	var endStr = "";
	endStr += "\n\t}";
	endStr += "\n}";
	
	return endStr;
}