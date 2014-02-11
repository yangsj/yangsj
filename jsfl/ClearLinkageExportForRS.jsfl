var fileURL = fl.browseForFileURL("open", "Select file");

var doc = fl.openDocument(fileURL);

var libsArr = doc.library.items;

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
	
	if (item.linkageExportForRS)
	{
		item.linkageExportForRS = false;
	}
}