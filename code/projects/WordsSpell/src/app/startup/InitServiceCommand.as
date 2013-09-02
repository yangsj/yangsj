package app.startup
{
	import app.events.ServiceEvent;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.socket.ISocketManager;
	import victor.framework.socket.MessageSocket;
	import victor.framework.socket.SocketEvent;
	import app.Global;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitServiceCommand extends BaseCommand
	{
		public function InitServiceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			var socket : MessageSocket = new  MessageSocket( Global.isDebug );
			injector.mapValue(ISocketManager, socket);
			socket.addEventListener(SocketEvent.CLOSE, onSocketClose);
			
			connected();
		}
		
		private function connected():void
		{
			dispatch( new ServiceEvent( ServiceEvent.CONNECTED ));
		}
		
		private function failed():void
		{
			dispatch( new ServiceEvent( ServiceEvent.FAILED ));
		}
		
		
		/**
		 * 连接关闭
		 */
		private function onSocketClose(event : SocketEvent) : void 
		{
			dispatch( new ServiceEvent( ServiceEvent.CLOSED ));
		}
	}
}