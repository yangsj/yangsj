var folder = fl.browseForFolderURL('选择文件夹')//这里可以打开文件夹浏览对话框.

var files = FLfile.listFolder(folder+'/*.fla','files')//files就是上面选择的文件夹里所有的fla组成的字符串.
fl.trace("Current Floder:" + folder);
fl.trace("File List:", files);

//fl.outputPanel.clear()///清空输出窗口.
fl.outputPanel.clear();
for(var i = 0;i<files.length;i++)//遍历所有文件
{
	fl.outputPanel.trace(files[i]);
	var doc = fl.openDocument(folder+'/'+files[i])///打一个文件.
	var lib = doc.library;
	fl.trace("============File--" + files[i] + "========================");
	var expSwfURI = doc.pathURI.substring(0, doc.pathURI.lastIndexOf(".fla")) + ".swf";
	
	var expSwf = expSwfURI.substring(expSwfURI.lastIndexOf("/") + 1, expSwfURI.length);
	
	var shareUrl = "" + expSwf;
	for(var j = 0; j < lib.items.length; j++)
	{
		var item = lib.items[j];
		if(item.linkageExportForRS)
		{
			fl.trace(item.name);
			item.linkageURL = shareUrl;
			fl.trace(item.linkageURL);
		}
	}
	
	doc.save();
	doc.exportSWF(expSwfURI);
	doc.close();
 
}
fl.outputPanel.save(folder + "/trace_.txt");

