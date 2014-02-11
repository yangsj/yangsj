var openFoler = "false";

var folder;
var files;
var fileURL1;
var doc1;
var libsArr1;
var arrName1 = [];
var libObject1 = [];
var nameStr1 = "resources";
var nameStr2 = "F:/Works/ep_flash/EmpressPlan/output/cn_1111/common/";

/*startChangePath("false", nameStr1, nameStr2);*/

function startChangePath (openFoler, namePath1, namePath2)
{
	if (openFoler && namePath1 && namePath2)
	{
		nameStr1 = namePath1;
		nameStr2 = namePath2;
		
		fl.outputPanel.clear();

		if (openFoler == "true")
		{
			folder = fl.browseForFolderURL("?????t?D");
			files = FLfile.listFolder(folder+"/*.fla","files");

			for(var i = 0;i < files.length; i++)
			{
				initSet(folder+"/"+files[i]);
			}
		}
		else
		{
			fileURL1 = fl.browseForFileURL("select", "/*.fla");
			initSet(fileURL1);
		}
	}
	else
	{
		return;
	}
}

function initSet(fileURL1)
{
	doc1 = fl.openDocument(fileURL1);
	libsArr1 = doc1.library.items;
	startCheck(libsArr1);
	doc1.save();
	doc1.close();
}


function startCheck(libsArr)
{
	for (var i = 0; i < libsArr.length; i++)
	{
		var item = libsArr[i];
		try
		{
			if (item.itemType != "font" && item.itemType != "folder" && item.sourceFilePath)
			{
				var string = item.sourceFilePath;
				var num = string.lastIndexOf(nameStr1);
				if (num >= 0)
				{
					num = num + nameStr1.length + 1;
					var pathName = "file:///" + nameStr2 + "/" + string.substr(num);
					if (fl.fileExists(pathName))
					{
						item.sourceFilePath = pathName;
					}
					else
					{
						fl.trace(doc1.name + "  ||| " + item.name + " || " + pathName);
					}
				}
			}
		}
		catch(e)
		{
			fl.trace("??t??￡o" + doc1.name + item.name);
			fl.trace(e);
		}
	}
}

