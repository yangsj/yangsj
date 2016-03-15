package net.victor.code.protocol
{
	import flash.net.ObjectEncoding;

	/**
	 * 协议类型定义 
	 * @author jonee
	 * 
	 */	
	public class ProtocolTypes
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		/**
		 * AMF0 
		 */		
		static public const PROTOCOL_TYPE_AMF0:int = 1;
		/**
		 * AMF3 
		 */		
		static public const PROTOCOL_TYPE_AMF3:int = 2;
		/**
		 * socket/tcp 
		 */		
		static public const PROTOCOL_TYPE_TCP:int = 3;
		/**
		 * http/json 
		 */		
		static public const PROTOCOL_TYPE_JSON:int = 4;
		/**
		 * http/text 
		 */		
		static public const PROTOCOL_TYPE_HTTP:int = 5;
	}
}