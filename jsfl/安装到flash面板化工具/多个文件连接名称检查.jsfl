
var arrSign = ["`", "~", "!", "#", "%", "&", "=", "/", ",", "<", ">",":", ";", "{", "}", "《", "》", "？", "·", "~", "@", "：", "“", "‘", "｛", "｝", "【", "】", "（", "）", "'", " "];
var arr = [36,65509,94,42,124,65311];
var arr2 = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];

alert("开始!!!!!");

/* 导出文件夹内所有文件的中的Linkage */
var folder = fl.browseForFolderURL('选择文件夹');
var files = FLfile.listFolder(folder+'/*.fla','files');
fl.outputPanel.clear();
var allLinkages = new Array();

for(var i = 0;i<files.length;i++)/*遍历所有文件*/
{
	/*fl.outputPanel.trace(files[i]);*/
	var doc = fl.openDocument(folder+'/'+files[i])/*打一个文件*/
	main(doc);
}


function main(doc)
{
	var errorMc = [doc.name+":\n"];
	var docLib = doc.library;
	var libItems = docLib.items;
	var leng = libItems.length;
	
	for (var i = 0; i < leng; i++)
	{
		var item = libItems[i];
		if (item.linkageExportForAS)
		{
			var linkageClass = item.linkageClassName;
			
			var tep = linkageClass.lastIndexOf(".") >= 0 ? linkageClass.substr(linkageClass.lastIndexOf(".")+1, 1) : linkageClass.substr(0, 1);
			
			var strArr2 = arr2.toString();
			
			if (strArr2.search(tep) == -1)
			{
				errorMc.push(item.name + " :  类名部分首字母 不是 【大写字母】\n");
			}
			
			
			var len = arrSign.length;
			for (var j = 0; j < len; j++)
			{
				if ( linkageClass.search(arrSign[j]) != -1 )
				{
					errorMc.push(item.name + " :  包含特殊字符【  " + arrSign[j] + "  】 "+　linkageClass.search(arrSign[j]) + "\n");
				}
			}
			
			for (j = 0; j < linkageClass.length; j ++)
			{
				var n = linkageClass.charCodeAt(j)
				for (var k = 0; k < arr.length; k++)
				{
					if (n == arr[k])
					{
						errorMc.push(item.name + " :  包含特殊字符【  " + String.fromCharCode(n) + "  】 \n");
					}
				}
			}
		}
	}
	
	if (errorMc.length > 0)
	{
		fl.trace(errorMc);
	}
	else
	{
		fl.trace("未找到特殊字符");
	}
}