package net.victor.code.protocol
{
	

	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	
	import net.victor.code.protocol.interfaces.IProtocal;

	public class DefaultProtocalParamConvertStrategy
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function DefaultProtocalParamConvertStrategy()
		{
		}
		
		public function convertProtocalParam(protocal:IProtocal):Array
		{
			var ra:Array = [];
			var vlist:XMLList = describeType(protocal).child("variable");
			var metadata:XMLList = vlist.child("metadata");

			var cls:Class = getDefinitionByName(getQualifiedClassName(protocal)) as Class;
			if(cls.hasOwnProperty("fields"))
			{
				for each(var ki:* in cls["fields"])
				{
					if(protocal[ki] !== null && protocal[ki] !== "undefined")
					{
						ra.push(protocal[ki]);
					}
				}
			}
			else
			{
				if(metadata && metadata.length() > 0)
				{
					var varray:Array = [];
					for each(var vi:* in vlist)
					{
						varray.push(vi);
					}
					//按变量定义的顺序排序
					varray.sort(sortOnPos);

					var keys:Array = [];
					for each(var vxi:XML in varray)
					{
						keys.push(vxi.attribute("name").toString());
					}
					for each(var k:* in keys)
					{
						if(protocal[k] !== null && protocal[k] !== "undefined")
						{
							ra.push(protocal[k]);
						}
					}
				}
			}
			return ra;
		}
		
		private function sortOnPos(x1:XML, x2:XML):int
		{
	
			var pos1:int = x1.child("metadata").child("arg").(@key=="pos").attribute("value");
			var pos2:int = x2.child("metadata").child("arg").(@key=="pos").attribute("value");
			if(pos1 > pos2)
			{
				return 1;
			}
			else
			{
				return -1;
			}
			
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}