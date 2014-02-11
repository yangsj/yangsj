fl.outputPanel.clear();
fl.outputPanel.trace('Start replacing text...');
var lib = fl.getDocumentDOM().library;
for(var i in lib)
{
	for(var j in lib[i])
	{
		if (lib[i][j].itemType=='graphic'||lib[i][j].itemType=='movie clip'||lib[i][j].itemType=='button')
		{
			for(var k in lib[i][j].timeline.layers)
			{
				for(var n in lib[i][j].timeline.layers[k].frames)
				{
					for(var m in lib[i][j].timeline.layers[k].frames[n].elements)
					{
						if(lib[i][j].timeline.layers[k].frames[n].elements[m]=='[object Text]')
						{
							var txt = lib[i][j].timeline.layers[k].frames[n].elements[m];
							var txtStr = txt.getTextString();
							fl.trace('原来：===' + txtStr);
							var oriTxt = '测试';
							var repTxt = '修改';
							var repled;
							for (var a = 0; a < txtStr.length; a++)
							{
								if (txtStr.substr(a, oriTxt.length) == oriTxt)
								{
									if (!repled)
									{
										repled = repTxt;
									}
									else
									{
										repled += repTxt;
									}
									a += oriTxt.length - 1;
								}
								else
								{
									if (!repled)
									{
										repled = txtStr.substr(a, 1);
									}
									else
									{
										repled += txtStr.substr(a, 1);
									}
								}
								txt.setTextString(repled);
								fl.trace(repled);
							}
							fl.trace('最后：===' + repled);
						}
					}
				}
			}
		}
	}
}
fl.outputPanel.trace('All text replaced.');
