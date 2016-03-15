package net.victor.code.managers
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import net.victor.code.framework.AppFacade;
	import net.victor.code.managers.interfaces.INetworkDelegate;
	import net.victor.code.network.INetWorkConnectionProperty;
	import net.victor.code.network.INetworkRoute;
	import net.victor.code.network.NetWorkError;
	import net.victor.code.network.NetWorkErrorEvent;
	import net.victor.code.network.NetWorkEvent;
	import net.victor.code.network.NetWorkRouteDefault;
	import net.victor.code.protocol.interfaces.IProtocal;
	import net.victor.code.protocol.interfaces.IProtocol1;
	import net.victor.code.response.IWebServiceResponse;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.observer.Notifier;
	
	public class NetworkDelegate extends EventDispatcher implements INetworkDelegate
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		protected var facade:IFacade = AppFacade.instance;
		
		private var _protocolDic:Dictionary;
		private var _managerName:String = "";
		
		private var _networkRouter:INetworkRoute = NetWorkRouteDefault.instance;
		
		private var _sendNum:int = 0;
		public function NetworkDelegate()
		{
			super();
			
			addEvents();
		}
		
		public function send(protocol:IProtocal,webReq:IWebServiceResponse):void
		{
			_networkRouter.send(protocol,webReq);
			_sendNum ++;
			this.sendNotification(NetworkProgressNotificationNames.ShowNetworkLoadingBarCommand);
		}
		
		public function addConnection(property:INetWorkConnectionProperty):void
		{
			_networkRouter.addConnection(property);
		}
		
		public function get managerName():String
		{
			return _managerName;
		}
		
		public function setManagerName(value:String):void
		{
			_managerName = value;
		}
		
		public function sendNotification( notificationName:String, body:Object=null, type:String=null ):void 
		{
			facade.sendNotification( notificationName, body, type );
		}
		
		public function registerProtocolCommand(protocolID:String, commandName:String):void
		{
			_protocolDic[protocolID] = commandName;
		}
		public function initProtocolDict(dict:Dictionary):void
		{
			this._protocolDic = dict;
		}
		public function dispose():void
		{
			
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		private function addEvents():void
		{
			_networkRouter.addEventListener(NetWorkEvent.ON_NET_WORK_RECEIVED_DATA, onNetData);
			_networkRouter.addEventListener(NetWorkErrorEvent.ON_NET_WORK_ERROR, onNetError);
		}
		
		private function removeEvents():void
		{
			_networkRouter.removeEventListener(NetWorkEvent.ON_NET_WORK_RECEIVED_DATA, onNetData);
			_networkRouter.removeEventListener(NetWorkErrorEvent.ON_NET_WORK_ERROR, onNetError);
		}
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function onNetData(e:NetWorkEvent):void
		{
			_sendNum --;
			if(_sendNum <= 0)
			{
				this.sendNotification(NetworkProgressNotificationNames.CloseNetworkLoadingBarCommand);
			}
			var protocol:IProtocol1 = e.netData as IProtocol1;
			if(protocol)
			{
				this.facade.sendNotification(this._protocolDic[protocol.pID], protocol);
			}
		}
		
		
		private function onNetError(e:NetWorkError):void
		{
			
		}
	}
}