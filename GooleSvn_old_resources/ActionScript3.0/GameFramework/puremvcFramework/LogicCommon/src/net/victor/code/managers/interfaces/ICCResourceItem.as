package net.victor.code.managers.interfaces
{
	import com.newbye.interfaces.IDisposable;
	
	public interface ICCResourceItem extends IDisposable
	{
		function get id():String;
		function get url():String;
		function get version():String;
		function get loadpolicy():String;
	}
}