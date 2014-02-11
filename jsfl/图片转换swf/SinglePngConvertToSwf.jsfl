
var folder;
var savePath;
var files;
var doc;
var library;
var libsArr;
var i = 0;
var quality = 0;

function main(qualityParam)
{
	qualityParam = parseInt(qualityParam);
	quality = qualityParam != 0 ? (qualityParam < 40 ? 40 : qualityParam) : 0;
	doc = fl.getDocumentDOM();
	if (doc)
	{
		fl.outputPanel.clear();
		fl.trace("指定的图片品质：" + quality + "___"+ qualityParam);
		startRun();
	}
	else
	{
		alert("请先创建一个<*.fla>, 并且打开");
	}
}

function startRun()
{
	/* 导出文件夹内所有文件的中的Linkage */
	alert("请选择一个图片目录！点击确定继续");
	folder = fl.browseForFolderURL('选择文件夹');
	
	alert("请选导出的资源存放目录！点击确定继续");
	savePath = fl.browseForFolderURL('选择文件夹');
	
	if (folder)
	{
		folder = folder + "/";
		files = FLfile.listFolder(folder+'/*.png','files');
		files = files.concat(FLfile.listFolder(folder+'/*.jpg','files'));
	
		library = doc.library;
		libsArr = library.items;
	
		fl.outputPanel.clear();
		
		deleteLibraryAll();
		importFileFromSelectedFolderToLibrary();
		convertSymbolLibraryAll();
		selectedFolderToSaveSwfAndDeleteAll();
	}

}

/** 删除库中原有的所有资源 */
function deleteLibraryAll()
{
	for (i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		if (item)
		{
			library.deleteItem(item.name);
			fl.trace(item.name);
		}
	}
}

/** 将所选择的目录下的图片资源导入到库中 */
function importFileFromSelectedFolderToLibrary()
{
	for(i = 0; i< files.length;i++)
	{
		fl.outputPanel.trace(folder+files[i]);
		doc.importFile(folder+files[i]);
	}
}

/** 将导入到库中的图片资源转换为元件 */
function convertSymbolLibraryAll()
{
	library = doc.library;
	libsArr = library.items;
	for (i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		if (item.itemType == 'bitmap')
		{
			if (item.compressionType == "photo" && quality > 0)
			{
				item.quality = quality;
			}
			doc.addItem({x:0,y:0}, item);
			doc.convertToSymbol("movie clip", item.name.substr(0, item.name.length - 4) , "top left");
		}
	}
}

/** 选择一个存储导出的swf文件，同时先将该目录下是原始文件删除 */
function selectedFolderToSaveSwfAndDeleteAll()
{
	if (savePath)
	{
		savePath = savePath + "/";
		files = FLfile.listFolder(savePath+'/*.swf','files');
		for (i = 0; i < files.length; i++)
		{
			var url = savePath + files[i];
			if (FLfile.exists(url))
			{
				FLfile.remove(url);
			}
		}
		exportSwf();
	}	
	//doc.close(false);
}

/** 将元件导出swf */
function exportSwf()
{
	library = doc.library;
	libsArr = library.items;
	for (i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		if (item.itemType == 'movie clip')
		{
			var url = savePath + item.name + ".swf";
			fl.trace(url);
			item.exportSWF(url);
		}
	}
	alert("成功导出资源！");
}
