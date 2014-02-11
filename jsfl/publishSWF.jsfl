var folder = fl.browseForFolderURL('选择文件夹');

var files = FLfile.listFolder(folder+'/*.fla','files');

fl.outputPanel.clear();

for(var i = 0;i<files.length;i++)
{
	var doc = fl.openDocument(folder+'/'+files[i]);
	doc.publish();
	doc.save();
	
	var fileName = doc.name;
	var htmlName = fileName.substr(0, fileName.search(".fla"));
	
	if (fl.fileExists(folder+'/' + htmlName + ".html")) FLfile.remove(folder+'/' + htmlName + ".html");
	
	if (fl.fileExists(folder+'/' + htmlName + ".gif")) FLfile.remove(folder+'/' + htmlName + ".gif"); 
	
	if (fl.fileExists(folder+'/' + htmlName + ".jpg")) FLfile.remove(folder+'/' + htmlName + ".jpg");
	
	if (fl.fileExists(folder+'/' + htmlName + ".png")) FLfile.remove(folder+'/' + htmlName + ".png");
	
	if (fl.fileExists(folder+'/' + htmlName + ".exe")) FLfile.remove(folder+'/' + htmlName + ".exe");
	
	if (fl.fileExists(folder+'/' + htmlName + ".app")) FLfile.remove(folder+'/' + htmlName + ".app");
	
	doc.close();
}