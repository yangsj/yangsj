
var folder;
var files;
var isChangeFonts = true;
var fontsCheckName = "Pop Warner,HYLingXinJ";
var fontsReplaceName = "Verdana,Verdana";
var checkFontsArr = [];
var replaceFonrsArr = [];

/*main(fontsCheckName, fontsReplaceName);*/

function main($fontsCheckName, $fontsReplaceName, $isChangeFonts)
{
	fontsCheckName = $fontsCheckName;
	fontsReplaceName = $fontsReplaceName;
	isChangeFonts = $isChangeFonts;
	checkFontsArr = fontsCheckName.split(",");
	replaceFonrsArr = fontsReplaceName ? fontsReplaceName.split(",") : [];
	
	fl.outputPanel.clear();
	folder = fl.browseForFolderURL('选择文件夹');
	files = FLfile.listFolder(folder+'/*.fla','files');
	/*遍历所有文件*/
	for(var i = 0;i<files.length;i++)
	{
		/*打一个文件*/
		var doc = fl.openDocument(folder+'/'+files[i])
		var lib = doc.library;
		for(var j = 0; j < lib.items.length; j++)
		{
			var selectItem = lib.items[j];
			if (selectItem.itemType == "movie clip")
			{
				var timeline = selectItem.timeline;
				outputItemOfTimeline(timeline);
				doc.save();
			}
			
		}
		doc.close();
	}
	fl.trace("check and change over.........................................");
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
						if (item2.elementType == "text")
						{
							var libItem  = item2.libraryItem;
							if (fontsCheckName.search(item2.textRuns[0].textAttrs.face) > -1)
							{
								/* 动画消除锯齿"standard" 、设备字体"device" */
								item2.fontRenderingMode = "standard";
								/* 更改字体 */
								if (isChangeFonts)
								{
									var n1 = checkFontsArr.indexOf(item2.textRuns[0].textAttrs.face);
									item2.textRuns[0].textAttrs.face = replaceFonrsArr[n1];
								}
							}
						}
					}
				}
			}
		}
		
	}
}
