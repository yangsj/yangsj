
var files = [];
var folderList = [];

/** main(); */

function main()
{
	/* 导出文件夹内所有文件的中的Linkage */
	var folder = fl.browseForFolderURL('选择文件夹');
	
	files = FLfile.listFolder(folder+'/*.fla','files');
	folderList = FLfile.listFolder(folder, 'directories');
	
	while (folderList.length > 0)
	{
		var tempFolder = folderList.pop();
		var list1 = FLfile.listFolder(folder + "/" + tempFolder+'/*.fla','files');
		var list2 = FLfile.listFolder(folder + "/" + tempFolder, 'directories');
		if (list2.length > 0)
		{
			for each (var fol in list2)
				folderList.push(tempFolder + "/" + fol); 
		}
		for each (var fls in list1)
			files.push(tempFolder + "/" + fls);
	}
	
	fl.outputPanel.clear();
	
	var allLinkages = new Array();

	fl.trace("<table border=1 cellpadding=1>");

	var length = files.length;
	for(var i = 0;i < length;i++)/*遍历所有文件*/
	{
		/*fl.outputPanel.trace(files[i]);*/
		var doc = fl.openDocument(folder+'/'+files[i])/*打一个文件*/
		var lib = doc.library;
		fl.trace("<tr><td colspan=5><h2>" + files[i] + "</h2></td></tr>");

		for(var j = 0; j < lib.items.length; j++)
		{
			var item = lib.items[j];
			if(item.linkageExportForAS)
			{
				
				fl.trace("<tr>");
				fl.trace("<td>" + item.name + "</td>");
				
				fl.trace("<td>" + item.linkageClassName + "</td>");
				
				if(allLinkages.indexOf(item.linkageClassName) > 0)
				{
					fl.trace("<td style='color:red;'>发现重复的Linkage命名</td>");
				}
				else
				{
					fl.trace("<td>&nbsp;</td>");
				}
				fl.trace("</tr>");
				
				allLinkages.push(item.linkageClassName);
			}
		}
		doc.close();
	 
	}
	fl.trace("</talbe>");
	fl.outputPanel.save(folder + "/All_Linkages.html");
}
