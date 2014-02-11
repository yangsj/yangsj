var lib = fl.getDocumentDOM().library; 
for(var i in lib)
{ 
	for(var j in lib[i])
	{ //遍历所有库元件 
		if(lib[i][j].itemType=="graphic"||lib[i][j].itemType=="movie clip")
		{ //判断，只有图形元件和影片元件里含有文本 
			for(var k in lib[i][j].timeline.layers)
			{ //遍历图层 
				for(var n in lib[i][j].timeline.layers[k].frames)
				{ //遍历所有帧 
					for(var m in lib[i][j].timeline.layers[k].frames[n].elements)
					{ //遍历所有帧里的可视元素 
						if(lib[i][j].timeline.layers[k].frames[n].elements[m] == "[object Text]")
						{ //只有文本才执行下面的操作 
							if(lib[i][j].timeline.layers[k].frames[n].elements[m].getTextString()=="愚蠢的熊猫")
							{ //获取你需要操作的字符 
								lib[i][j].timeline.layers[k].frames[n].elements[m].setTextString("聪明的兔子"); //替换字符 
							}
						}
					}
				}
			}
		}
	}
} 

