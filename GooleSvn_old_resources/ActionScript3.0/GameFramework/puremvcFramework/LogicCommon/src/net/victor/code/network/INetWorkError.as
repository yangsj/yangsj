package net.victor.code.network
{
	import com.newbye.interfaces.IDisposable;
	
	public interface INetWorkError extends com.newbye.interfaces.IDisposable
	{
		function get protocolID():String;
		function get errorType():*;
		function get description():String;
	}
}