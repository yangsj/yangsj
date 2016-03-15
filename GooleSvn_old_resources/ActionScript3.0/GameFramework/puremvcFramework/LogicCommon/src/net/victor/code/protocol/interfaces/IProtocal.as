package net.victor.code.protocol.interfaces
{
	import flash.utils.ByteArray;

	public interface IProtocal
	{
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
		 * 协议的MD5 
		 * @return 
		 */		
		function getMD5():String;
		/**
		 * 协议的远程方法
		 * @return 
		 */		
		function getRemoteMethod():String;

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