package net.victor.code.network
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.getClassByAlias;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import net.victor.code.errors.LCErrorTypes;
	import net.victor.code.protocol.DefaultProtocalParamConvertStrategy;
	import net.victor.code.protocol.ProtocolTypes;
	import net.victor.code.protocol.amf.IAMFProtocol;
	import net.victor.code.protocol.interfaces.IProtocal;
	import net.victor.code.response.IWebServiceResponse;

	public class NetWorkRouteDefault extends EventDispatcher implements INetworkRoute
	{
		/////////////////////////////////////////static /////////////////////////////////

		static private var _instance:INetworkRoute=null;

		static public function get instance():INetworkRoute
		{
			if (null == _instance)
			{
				_instance=new NetWorkRouteDefault();
			}
			return _instance;
		}


		/////////////////////////////////////////vars /////////////////////////////////

		private var _managerName:String;

		private var _amfConnection:NetConnection;
		private var _amfProperty:INetWorkConnectionProperty;
		private var _amfResponder:Responder;

		private var _defaultProtocalParamsConvert:DefaultProtocalParamConvertStrategy=new DefaultProtocalParamConvertStrategy();

		private var delimiters:Vector.<String>;

		private var serviceConstName:String="";

		public function NetWorkRouteDefault(target:IEventDispatcher=null)
		{
			super(target);
			if (_instance)
			{
				throw new Error(LCErrorTypes.SINGLETON_ERROR);
			}
			else
			{
				delimiters=new Vector.<String>();
				delimiters.push('?', ';', '&', '+', '@', '*');
				_instance=this;
			}

		}

		public function send(protocol:IProtocal, webRequset:IWebServiceResponse):void
		{
			sendAMFRequest(protocol, webRequset);
		}

		public function get managerName():String
		{
			return _managerName;
		}

		public function addConnection(property:INetWorkConnectionProperty):void
		{
			if (null == property)
			{
				return;
			}
			switch (property.connectType)
			{
				case NetWorkConnectTypes.AMF:
					_amfConnection=new NetConnection();
					_amfProperty=property;
					_amfConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusEventHandler);
					_amfConnection.addEventListener(IOErrorEvent.IO_ERROR, ioErrorEventHandler);
					break;
			}
		}

		public function setManagerName(value:String):void
		{
			_managerName=value;
		}
		
		protected function sendAMFRequest(protocal:IProtocal, webRequset:IWebServiceResponse):void
		{
			if (!_amfConnection.connected)
			{
				_amfConnection.connect(_amfProperty.gateway);
				trace(_amfProperty.gateway);
			}
			_amfResponder=new Responder(webRequset.onCompleteListener, webRequset.onErrorListener);
			var params:Array=_defaultProtocalParamsConvert.convertProtocalParam(protocal);
			var pmd5:String=protocal.getMD5();
			var pRemoteMethod:String=protocal.getRemoteMethod();
			var parame:String=pmd5;

			if (params.length > 0)
			{
				parame=pmd5 + delimiters[0] + formatParameter(params);
			}
			trace("【" + parame + "】has been send out successful");

			serviceConstName=protocal.pID;
			
			_amfConnection.call(pRemoteMethod, _amfResponder, parame);
			webRequset=null;
			_amfResponder=null;
		}

		private function netStatusEventHandler(e:NetStatusEvent):void
		{
			trace(e);
		}

		private function ioErrorEventHandler(e:IOErrorEvent):void
		{
			trace(e);
		}

		protected function formatParameter($args:Array, $deepth:int=1):String
		{
			var length:int=$args.length;
			var params:Array=[];
			var i:int;
			for (i=0; i < length; i++)
			{
				var data:Object=$args[i];
				if ($args[i] is Array)
				{
					params.push(formatParameter($args[i], $deepth + 1))
				}
				else if ($args[i] is Boolean || $args[i] is uint || $args[i] is Number || $args[i] is int || $args[i] is String)
				{
					params.push(encodeURI(String($args[i])));
				}
				else
					throw Error('暂不支持Array，Boolean，uint，int，Number，String以外的数据类型');
			}

			return params.join(delimiters[$deepth]);
		}


		/////////////////////////////////////////private ////////////////////////////////



		/////////////////////////////////////////events//////////////////////////////////
	}


}
