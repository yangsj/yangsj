var folder = fl.browseForFolderURL('选择文件夹')//这里可以打开文件夹浏览对话框.

var files = FLfile.listFolder(folder+'/*.fla','files')//files就是上面选择的文件夹里所有的fla组成的字符串.
fl.trace("Current Floder:" + folder);
fl.trace("File List:", files);

fl.outputPanel.clear();//清空输出窗口.

for(var i = 0;i<files.length;i++)//遍历所有文件
{
	var doc = fl.openDocument(folder+'/'+files[i]);//打一个文件.
	var lib = doc.library;
	//fl.trace(lib.items.length);
	fl.trace("============File--" + files[i] + "========================");
	
	
	for(var j = 0; j < lib.items.length; j++)
	{
		var item = lib.items[j];
		if(item.linkageImportForRS)
		{
			fl.trace(item.linkageURL);
			fl.trace(item.linkageURL);
		}
		
	}
	doc.close();
 
}

