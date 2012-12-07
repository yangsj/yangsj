package network
{

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;

	import global.Global;

	import network.interfaces.IWebResponder;


	/**
	 * 说明：ServiceManager
	 * @author Victor
	 * 2012-10-22
	 */

	public class ServiceManager extends EventDispatcher
	{
		[Embed(source = "../asset/protocol.xml", mimeType = "application/octet-stream")]
		private var ProtocolXML : Class;

		private var _protocolXML : XML;

		private var _gateway : String;

		private var _netConnection : NetConnection;


		private static var _instance : ServiceManager;

		public static function get instance() : ServiceManager
		{
			if (_instance == null)
			{
				new ServiceManager();
			}
			return _instance;
		}

		public function ServiceManager(target : IEventDispatcher = null)
		{
			super(target);
			if (_instance)
			{
				throw new Error("ServiceManager已经被创建，请用ServiceManager.instance访问。");
			}
			_instance = this;

		}

		/**
		 * 初始化网络管理器。在初始化之前请先确定能有效取到用户id值。
		 * 若在不在initialization方法中传入uid值，则必须可以通过Global.uid取到有效值，
		 * 否则可能在发送请求中出错或者请求数据与当前用户数据不一致。
		 * @param uid 用户id，此处不指定则会取全局uid（Global.uid）
		 *
		 */
		public function initialization(uid : String = "") : void
		{
			if (_netConnection == null)
			{
				_netConnection = new NetConnection();
				_netConnection.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			}
			resetGateway(uid);
		}

		/**
		 * 从新设定，指定新的用户id，主要用在新注册后
		 * @param uid
		 * 
		 */
		public function resetGateway(uid : String) : void
		{
			uid = uid ? uid : Global.uid;
			_gateway = String(protocolXML.gateway[0]) + uid;
		}

		/**
		 * 连接服务器并发送请求，可以用该方法返回的值判断请求是否成功发出或网络是否是可用，也可以直接通过NetworkStatus.available的值判定网络的可用性。
		 * @param webResponder 一个IWebResponder对象，详息请见另阅：
		 * @return 返回一个发送状态（Boolean），若成功连接并发出请求返回true，否则返回false。
		 * @see network.interfaces.IWebResponder
		 * @see network.NetworkStatus
		 */
		public function send(webResponder : IWebResponder) : Boolean
		{
			if (NetworkStatus.available)
			{
				var xml : XML = protocolXML.protocols.children().(@id == webResponder.protocolID)[0];
				var command : String = String(xml.@remote);
				var pmd5 : String = String(xml.@key);
				var params : String = webResponder.getParams();
				params = pmd5 + "?" + params;

				if (_netConnection.connected == false)
				{
					_netConnection.connect(_gateway);
				}

				_netConnection.call(command, webResponder.responder, params);
				webResponder = null;
			}
			return NetworkStatus.available;
		}

		protected function netStatusHandler(event : NetStatusEvent) : void
		{
			// 网络正常
			this.dispatchEvent(new ServiceEvent(ServiceEvent.SERVICE_RIGHT));
		}

		protected function ioErrorHandler(event : IOErrorEvent) : void
		{
			// 网络异常
			this.dispatchEvent(new ServiceEvent(ServiceEvent.SERVICE_ERROR));
		}

		/**
		 * 通信配置文件信息
		 */
		public function get protocolXML() : XML
		{
			if (_protocolXML == null)
			{
				_protocolXML = XML(new ProtocolXML());
			}
			return _protocolXML;
		}

	}

}
