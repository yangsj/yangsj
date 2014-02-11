
var fileURL1 = fl.browseForFileURL("select", "/*.fla");
var fileURL2 = fl.browseForFileURL("select", "Select file");

var doc1 = fl.openDocument(fileURL1);
var doc2 = fl.openDocument(fileURL2);

var libsArr1 = doc1.library.items;
var libsArr2 = doc2.library.items;

var arrName1 = [];
var arrName2 = [];
var arrEqual = [];
var arrOhne  = [];

var libObject1 = [];
var libObject2 = [];

fl.outputPanel.clear();

startCheck(libsArr1, 1);
startCheck(libsArr2, 2);

function startCheck(libsArr, n)
{
	for (var i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		if (item.linkageClassName && item.itemType == 'movie clip')
		{
			diguiFun(item, n);
		}
	}
}

for (var k = 0; k < arrName2.length; k++)
{
	for (var m = 0; m < arrName1.length; m++)
	{
		if (arrName2[k] == arrName1[m])
		{
			arrEqual.push(arrName2[k]);
			arrName2.splice(k, 1);
			arrName1.splice(m, 1);
			k--;
			m = 0;
			break;
		}
	}
}

fl.trace("=====================修改文件未在源文件中找到的名称===========================");
fl.trace(arrName1);
fl.trace("=====================修改文件中有，但是源文件中没有的名称===========================");
fl.trace(arrName2);

fl.trace("=====================两文件相同的名称===========================");
fl.trace(arrEqual);

function diguiFun(item, n)
{
	if (item.timeline)
	{
		var timeline = item.timeline;
		var layers   = timeline.layers;
		
		for (var i in layers)
		{
			var string = ' ';
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
					
						if (item2.name)
						{
							fl.trace("===========");
							fl.trace(item2.name);
						
							if (n == 1)
							{
								arrName1.push(item2.name);
							}
							else if (n == 2)
							{
								arrName2.push(item2.name);
							}
						
							string = item2.name;
							var libItem;
							var isRepeat = false;
						
							if(item2.libraryItem)
							{
								libItem = item2.libraryItem;
								
								if (n == 1)
								{
									for (var ii = 0; ii < libObject1.length; ii++)
									{
										if (libItem.name == libObject1[ii].name)
										{
											isRepeat = true;
											break;
										}
									}
									if (isRepeat == false)
									{
										libObject1.push(libItem);
									}
									else
									{
										isRepeat = true;
										break;
									}
								}
								else
								{
									for (var ii = 0; ii < libObject2.length; ii++)
									{
										if (libItem.name == libObject2[ii].name)
										{
											isRepeat = true;
											break;
										}
									}
									if (isRepeat == false)
									{
										libObject2.push(libItem);
									}
									else
									{
										isRepeat = true;
										break;
									}
								}
								
							}
							else
							{
								break;
							}
						
							diguiFun(libItem, n);
						}
					}
				}
			}
		}
	}
}
