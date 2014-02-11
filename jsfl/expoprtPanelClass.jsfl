var doc = fl.documents[0];

var libsArr = doc.library.items;

var instanceName;

fl.outputPanel.clear();

for (var i = 0; i < libsArr.length; i++)
{
	var item = libsArr[i];
	if (item.linkageClassName && item.itemType == 'movie clip')
	{
		diguiFun(item);
		fl.trace('==========================  ' + item.linkageClassName + '  =============================');
	}
}
//fl.trace('instanceName  :: ' + '\n' +instanceName);

function diguiFun(item)
{
	outputItemOfTimeline(item.timeline);
	return;
	if (item.timeline)
	{
		var timeline = item.timeline;
		
		var layers   = timeline.layers;
		
		for (var i in layers)
		{
			var string = ' ';
			
			var layer   = timeline.layers[i];
			
			var frames  = layer.frames;
			
			for (var j = 0; j < frames.length; j++)
			{
				var elements = frames[j].elements;
				
				for (var k = 0; k < elements.length; k++)
				{
					var item2 = elements[k];
					if (item2.name && string != item2.name)
					{
						fl.trace("===========");
						fl.trace(item2.name);
						fl.trace(item2.elementType);
						fl.trace(item2.symbolType);
						
						fl.trace(item2.itemType);
						fl.trace("linkageClassName:"+ item2.linkageClassName);
						fl.trace("linkageClassName:"+ item2.linkageBaseClass);
						fl.trace("instanceType:"+item2.instanceType);
						fl.trace("libraryItem:"+item2.libraryItem);
						if(item2.libraryItem)
						{
							fl.trace("libraryItem:"+item2.libraryItem.linkageClassName);
						}
						//fl.trace(item2.parameters);
						
						var varitem = "private var " + item2.name + ":";
						
						if(item2.elementType == "text") 
						{//文本框
							varitem += "TextField";
						}
						else if(item2.elementType == "instance") 
						{
							if(item2.symbolType == "movie clip")
							{
								
							}
							else if(item2.symbolType == "button")
							{
								
							}
						}
						fl.trace(varitem);
						if (item2.libraryItem)
						{
							diguiFun(item2.libraryItem);
						}
						string = item2.name;
					}
					
				}
			}
		}
	}
}

function outputItemOfTimeline(timeline)
{
	var layer, frame, elem, cls;
	var arr  = new Array();
	var importArr = new Array();
	var varArr = new Array();
	// go through all frames in all layers and search for instance variables. 	
	for( var i=0; i < timeline.layers.length; i++ ) 
	{
		layer = timeline.layers[i];
		for( var j=0; j < layer.frames.length; j++ )
		{
			frame = layer.frames[j];
			for( var k=0; k < frame.elements.length; k++ )
			{
				elem = frame.elements[ k ];
				if(elem.elementType == "text" && elem.name)
				{
					arr.push("public var " + elem.name + ":TextField;");
					importArr.push("import flash.text.TextField;");
					varArr.push(elem.name);
					continue;
				}
				if(!elem.libraryItem)
				{
					continue;
				}
				if( elem.libraryItem.linkageClassName || elem.libraryItem.linkageBaseClass )
				{
					if( elem.libraryItem.linkageBaseClass && elem.name )
					{
						cls = elem.libraryItem.linkageBaseClass.split(".").pop();
						arr.push("public var " + elem.name + " : " + cls + ";");
						importArr.push("import " + elem.libraryItem.linkageBaseClass + ";");
						varArr.push(elem.name);
					}
					else if( elem.libraryItem.linkageClassName && elem.name)
					{
						cls = elem.libraryItem.linkageClassName.split(".").pop();
						arr.push("public var " + elem.name + ":" + cls + ";");
						importArr.push("import " + elem.libraryItem.linkageClassName + ";");
						varArr.push(elem.name);
					} 				
				}
				else if( elem.name )
				{
					arr.push("public var " + elem.name + ":MovieClip;");
					importArr.push("import flash.display.MovieClip;");
					varArr.push(elem.name);
				}
			}
		}
	}  	
	
	var uniqueImtArr = unique(importArr);
	/*for( var i=0; i < uniqueImtArr.length; i++ )
	{
		fl.trace(uniqueImtArr[i]);
	} */
	var uniqueArr = unique(arr);
	
	/*for( var i=0; i < uniqueArr.length; i++ )
	{
		fl.trace(uniqueArr[i]);
	} */
	var uniqueVarArr = unique(varArr);
	
	outputClass(uniqueImtArr, uniqueArr, uniqueVarArr, "Hello");
}

function outputClass(uniqueImtArr, uniqueArr, uniqueVarArr, linkageName)
{
	fl.outputPanel.clear();
	fl.trace("package %packageName%\n{\n");
	for( var i=0; i < uniqueImtArr.length; i++ )
	{
		fl.trace("\t" + uniqueImtArr[i]);
	} 
	fl.trace("\tpublic class %className% extends %baseClassName%\n\t{\n");
	
	for( var i=0; i < uniqueArr.length; i++ )
	{
		fl.trace("\t\t" + uniqueArr[i]);
	} 
	
	fl.trace("\n\t\tpublic function %className%()\n\t\t{\n\t\t\tsuper();");
	fl.trace("\n\t\t\tvar resMc:* = createMovieClipFromSwf(\""+linkageName+"\");");
	for( var i=0; i < uniqueArr.length; i++ )
	{
		fl.trace("\t\t\t" + uniqueVarArr[i] + " = resMc." + uniqueVarArr[i] + ";");
	} 
	fl.trace("\n\t\t}\n\n\t}\n}");
	
	fl.outputPanel.save("%floder%%packageName%/%className%.as");
}

function unique(arr)
{
	var r = new Array();
	o:for(var i = 0, n = arr.length; i < n; i++)
	{
		for(var x = 0, y = r.length; x < y; x++)
		{
			if(r[x]==arr[i])
			{
				continue o;
			}
		}
		r[r.length] = arr[i];
	}
	r.sort()
	return r;
} 