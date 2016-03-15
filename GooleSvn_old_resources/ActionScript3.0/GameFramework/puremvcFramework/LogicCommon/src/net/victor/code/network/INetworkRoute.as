package net.victor.code.network
{
	import flash.events.IEventDispatcher;
	
	import net.victor.code.managers.interfaces.IManagerCernterable;
	import net.victor.code.protocol.interfaces.IProtocal;
	
	import net.victor.code.response.IWebServiceResponse;
	
	[Event(name="on_net_work_received_data", type="net.victor.code.network.NetWorkEvent")]
	[Event(name="on_net_work_error", type="net.victor.code.network.NetWorkErrorEvent")]
	public interface INetworkRoute extends IManagerCernterable, IEventDispatcher
	{
		function send(protocol:IProtocal,webReq:IWebServiceResponse):void;
		
		function addConnection(property:INetWorkConnectionProperty):void;
		
	}
}