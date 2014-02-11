var fileURL = fl.browseForFileURL("open", "Select file");

var doc = fl.openDocument(fileURL);

var libsArr = doc.library.items;

fl.trace('The LinkageName is adding ... ');

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
	fl.trace(item.name);
	if (item.itemType == 'movie clip' || item.itemType == 'button')
	{
		item.linkageExportForAS = true;
		item.linkageClassName = 'objects_'+ i;
	}
	
}

fl.trace('All Object LinkageName is added');