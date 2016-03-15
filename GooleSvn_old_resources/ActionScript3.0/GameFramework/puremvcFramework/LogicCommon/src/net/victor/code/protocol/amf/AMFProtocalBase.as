package net.victor.code.protocol.amf
{
	
	import com.newbye.utils.getObjectFields;
	
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	
	import net.victor.code.protocol.ProtocolTypes;
	
	public class AMFProtocalBase implements IAMFProtocol
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function AMFProtocalBase()
		{
		}
		
		public function get protocolType():int
		{
			return ProtocolTypes.PROTOCOL_TYPE_AMF3;
		}
		
		public function get pLength():int
		{
			return 0;
		}
			
		public function get pID():String
		{
			return "id";
		}
		
		/**
		 * 加setter 防止远程对像只读异常 
		 * @param value
		 * 
		 */		
		public function set pID(value:String):void
		{
			
		}
		/**
		 * 加setter 防止远程对像只读异常 
		 * @param value
		 * 
		 */		
		public function set pLength(value:int):void
		{
			
		}
		/**
		 * 加setter 防止远程对像只读异常 
		 * @param value
		 * 
		 */		
		public function set protocolType(value:int):void
		{
			
		}
		
		
		public function toByteArray():ByteArray
		{
			return null;
		}
		
		public function toString():String
		{
			var str:String = this.pID + "  ";
			
			var keys:Array = getObjectFields(this);
			for each(var k:* in keys)
			{
				str += k.toString() + ": " + this[k]+ "; ";
			}
			return str;
		}
		
		public function toFormatString(format:Object=null):String
		{
			return "";
		}
		
		public function get remoteMethod():String
		{
			return "Gateway.response";
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}