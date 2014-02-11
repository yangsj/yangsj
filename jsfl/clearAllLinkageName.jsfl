var fileURL = fl.browseForFileURL("open", "Select file");

var doc = fl.openDocument(fileURL);

var libsArr = doc.library.items;

fl.trace('The LinkageName is clearing ... ');

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
	
	if (item.linkageClassName)
	{
		item.linkageExportForAS = false
	}
}

fl.trace('All Object LinkageName is cleared');