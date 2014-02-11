

	
var nameArr = [];
var noLinkage = [];

main();

function main()
{
	alert("开始!!!");
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
	
	var timeline = selectItem.timeline;
	outputItemOfTimeline(timeline);
	
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
							var itemName = item2.name ? item2.name : "";
							var itemCls	 = libItem.linkageClassName ? libItem.linkageClassName : "flash.display.Sprite";
							
							if (itemName)
							{
								var boo = false;
								for each (var key in nameArr)
								{
									if (itemName == key)
									{
										boo = true;
										fl.trace("重复实例名：" + itemName);
									}
								}
								if (boo == false)
								{
									nameArr.push(itemName);
								}
							}
							
							if (!libItem.linkageClassName)
							{
								noLinkage.push("【" +libItem.name + "】已经检测到该元件中包含的元素在库中未有 连接名称 ， 请重新检查...\n");
								alert("【" +libItem.name + "】已经检测到该元件中包含的元素在库中未有 连接名称 ， 请重新检查...");
							}
						}
						else if (item2.elementType != "text")
						{
							alert("解析的元件的第一级不能包含除元件和文本框以外的元素， 请重新检查该元件中的元素...");
						}
					}
				}
			}
		}
	}
	fl.trace("******************************************");
	fl.trace("未有链接名Linkage的元件名：\n" + noLinkage);
	
	fl.trace("********************************************");
	fl.trace("所有实例名：\n" + nameArr);
		
}
