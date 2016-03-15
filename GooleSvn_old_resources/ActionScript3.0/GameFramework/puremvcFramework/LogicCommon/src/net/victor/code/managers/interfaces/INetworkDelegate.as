package net.victor.code.managers.interfaces
{
	import flash.utils.Dictionary;
	
	import net.victor.code.network.INetworkRoute;
	import net.victor.code.protocol.interfaces.IProtocol1;
	
	import org.puremvc.as3.interfaces.INotifier;

	public interface INetworkDelegate extends INetworkRoute, INotifier
	{
		function registerProtocolCommand(protocolID:String, commandName:String):void;
		function initProtocolDict(dict:Dictionary):void;
	}
}