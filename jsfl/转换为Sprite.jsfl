var fileURL = fl.browseForFileURL("open", "Select file");
var doc = fl.openDocument(fileURL);
fl.outputPanel.clear();

var libsArr = doc.library.items;

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
		
	if (item.itemType == "movie clip")
	{
		if (item.linkageExportForAS)
		{
			if (item.timeline.frameCount == 1)
			{
				item.linkageBaseClass = "flash.display.Sprite";
			}
		}
	}
}