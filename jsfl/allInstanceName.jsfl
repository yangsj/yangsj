var fileURL = fl.browseForFileURL("open", "Select file");

var doc = fl.openDocument(fileURL);

var libsArr = doc.library.items;

var instanceName;

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
	
	if (item.linkageClassName && item.itemType == 'movie clip')
	{
		diguiFun(item);
		fl.trace('==========================  ' + item.linkageClassName + '  =============================');
	}
}
fl.trace('instanceName  :: ' + '\n' +instanceName);

function diguiFun(item)
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
				var elements = frames[j].elements;
				
				for (var k = 0; k < elements.length; k++)
				{
					var item2 = elements[k];
					//fl.trace(item2.name);
					if (instanceName == undefined || !instanceName)
					{
						//instanceName = item2.name + '\n';
						//instanceName = item2.accName + '\n';
					}
					else
					{
						//instanceName += item2.name + '\n';
						//instanceName += item2.accName + '\n';
					}
					
					if (item2.libraryItem)
					{
						diguiFun(item2.libraryItem);
					}
				}
			}
		}
	}
}