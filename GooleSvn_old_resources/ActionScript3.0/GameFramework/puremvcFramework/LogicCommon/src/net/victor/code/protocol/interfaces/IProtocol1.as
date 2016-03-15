package net.victor.code.protocol.interfaces
{
	import flash.utils.ByteArray;

	/**
	 * 业务逻辑通信协议接口 
	 * @author jonee
	 * 注意单词 protocal专用哦，不是protocol哦
	 */	
	public interface IProtocol1
	{
		/**
		 * 协议类型 
		 * @see net.jt_tech.protocol.ProtocolTypes
		 */		
		function get protocolType():int;
			
		/**
		 * 协议长度 
		 * @return 
		 */		
		function get pLength():int;
		/**
		 * 协议ID 
		 * @return 
		 */		
		function get pID():String;
		
		/**
		 * 转换成字节序 
		 * @return 
		 * 
		 */		
		function toByteArray():ByteArray;
		/** 
		 * @return 
		 * 
		 */		
		function toString():String;
		
		/**
		 * 转换成具有一定格式的字符串 
		 * @return 
		 */		
		function toFormatString(format:Object=null):String;
		
	}
}