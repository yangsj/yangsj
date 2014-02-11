

	
	var nameArr = [];
	
	/** main(); */
	
	function  main()
	{
		var doc = fl.getDocumentDOM(); 
		if(!doc)  
		{ 	
			alert("Please open a *.fla document first!(请先打开一个fla文件)");
			return "";
		}
		var selectItems = doc.library.getSelectedItems();
		if(!selectItems || selectItems.length < 1)
		{
			alert('Please select an item form the library first!(从库中点选你要检测的元件)');
			return '';
		}
	
		if(selectItems.length > 1)
		{
			alert('Dont select more than one item!(一次只能选择一个， 请选择你要检测的元件)');
			return '';
		}
		fl.outputPanel.clear();
	
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
			for (var j = 0; j < frames.length; j++)
			{
				if (j == frames[j].startFrame)
				{
					var elements = frames[j].elements;
					for (var k = 0; k < elements.length; k++)
					{
						var item2 = elements[k];
						var itemName = item2.name;
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
					}
				}
			}
		}
		fl.trace("********************************************");
		fl.trace("所有实例名：\n" + nameArr);
	}
	
	
	
	
	
	
	
	