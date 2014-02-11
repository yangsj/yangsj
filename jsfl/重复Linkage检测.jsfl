/* 导出文件夹内所有文件的中的Linkage */
var folder = fl.browseForFolderURL('选择文件夹');

var files = FLfile.listFolder(folder+'/*.fla','files');
fl.outputPanel.clear();

var allLinkages = new Array();

fl.trace("<table border=1 cellpadding=1>");

for(var i = 0;i<files.length;i++)/*遍历所有文件*/
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