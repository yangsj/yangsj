package net.victor.code.network
{
	import com.newbye.interfaces.IDisposable;
	
	public interface INetWorkConnectionProperty extends IDisposable
	{
		/**
		 * @see net.jt_tech.network.NetWorkConnectTypes
		 * @return 
		 * 
		 */		
		function get connectType():String;
		
		function get host():String;
		
		function get port():int;
		
		function get gateway():String;
		
		function get securityPolicy():*;
		
		function get otherProperties():Array;
	}
}