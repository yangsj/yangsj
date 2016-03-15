package net.victor.project.commands.base
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	import net.victor.project.protocol.GetPrtcAttr;
	import net.victor.code.protocol.interfaces.IProtocal;

	public class WebProtocalBase implements IProtocal
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		public function WebProtocalBase()
		{
		}
		
		public function get pLength():int
		{
			return this.toString().length;
		}
		
		public function get pID():String
		{
			
			throw new Error("You must use override to rewrite this Class  Completely");
			return null;
		}
		
		public function toByteArray():ByteArray
		{
			return null;
		}
		public function getMD5():String
		{
			var gpa:GetPrtcAttr=new GetPrtcAttr(pID);
			
			return gpa.getKey();
		}
		
		public function getRemoteMethod():String
		{
			var gpa:GetPrtcAttr=new GetPrtcAttr(pID);
			
			return gpa.getRemoteMethod();
		}
		public function toString():String
		{
			var str:String = this.pID;
			for(var k:* in this)
			{
				str += k.toString() + this[k];
			}
			return str;
		}
		
		public function toFormatString(format:Object=null):String
		{
			var str:String = "[" + this.pID + "]::";
			
			var keys:* = describeType(this).child("variable").attribute("name");
			for each(var k:String in keys)
			{
				str += k + ":" + this[k] + ";";
			}
			return str;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}