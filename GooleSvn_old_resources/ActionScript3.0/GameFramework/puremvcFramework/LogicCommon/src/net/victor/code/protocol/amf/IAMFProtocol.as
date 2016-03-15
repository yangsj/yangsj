package net.victor.code.protocol.amf
{
	import net.victor.code.protocol.interfaces.IProtocol1;
	
	public interface IAMFProtocol extends IRemotable, IProtocol1
	{
		function get remoteMethod():String;
	}
}