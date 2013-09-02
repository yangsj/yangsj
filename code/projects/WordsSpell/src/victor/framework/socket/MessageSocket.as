package victor.framework.socket {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import app.utils.log;
	import app.Global;
	

	/**
	 * @author fireyang
	 */
	public class MessageSocket extends SocketBase implements ISocketManager {
		private static const EVENT_PRE : String = "evt_";
		private var _eventList : Object;
		private var _event : EventDispatcher;
		// 通知回调
		private var _notifyCallbackList : Object;
		// 忽略
		private var _ignoreList : Object;
		// 不处理
		private  var _wired : Dictionary;
		private var _onceCallList : Dictionary;
		private var _beatTime : int;

		// private var _notAllowList : Array;
		public function MessageSocket(isDebug : Boolean = false) {
			this._eventList = {};
			_notifyCallbackList = {};
			_ignoreList = {};
			_wired = new Dictionary();
			_event = new EventDispatcher();
			_onceCallList = new Dictionary();
			super(isDebug);
		}

		public  function keepAlive(api : int) : Boolean {
			return _wired[api];
		}

		public  function addWired(api : int) : void {
			_wired[api] = true;
		}

		/**
		 * 注册固定数据回调事件
		 * @param api 调用的api号码
		 * @param callback 回调
		 * @param isIgnore 是否忽略解析
		 */
		public function registerDataCallback(api : uint, callback : Function, respProc : Class = null, isIgnore : Boolean = false) : void {
			if (_notifyCallbackList[api]) {
				throw new Error("指定的协议重复注册回调方法!:" + api);
			}
			_notifyCallbackList[api] = [callback, respProc];
			if (isIgnore) {
				_ignoreList[api] = isIgnore;
			}
		}

		/**
		 * 解析事件回调
		 */
		override protected function parseSocketData(buffer : ByteArray) : void {
			var respObj : SocketResp;
			respObj = PacketParse.analyze(buffer);
			var callback : Function;
			var list : Array;
			var respPorc : Class ;
			var isNotify : Boolean = false;
			var api : uint = respObj.api;
			if (respObj.type == 1) {
				// 响应
				list = _onceCallList[respObj.seq];
				delete _onceCallList[respObj.seq];
			} else if ( respObj.type == 2) {
				// 通知
				isNotify = true;
				list = _notifyCallbackList[api];
			}
			var channelStr : String = getChannel(api);
			if (list) {
				callback = list[0];
				respPorc = list[1];
				var data : ByteArray = respObj.data;
				var msg : * = new respPorc();
				// trace("cla:",PacketParse.printApi(api), respPorc, data.position, data.length);
				msg.mergeFrom(data);
				respObj.data = msg;
				if (_isDebug)
					log(channelStr, getTimer()+"|服务器返回数据[" + respObj.seq + "](" + PacketParse.printApi(api) + "):", respObj.data.toString());
			} else {
				if (_isDebug)
					log(channelStr, getTimer()+"|没有数据解包[" + respObj.seq + "]:" + PacketParse.printApi(api) + "\n\t------");
			}
			if (!isNotify) {
				if (callback == null) {
					if (_isDebug)
						log("响应没有指定回调:" + PacketParse.printApi(api) + ",type:" + respObj.type);
					return;
				}
				// 一次请求
				if (callback.length > 0) {
					callback(respObj);
				} else {
					callback();
				}
			} else {
				// 直接返回数据的byteArray;
				// if (_ignoreList[api]) {
				// callback(buffer);
				// dispatch(api);
				// return;
				// }
				if (callback is Function) {
					callback(respObj);
				} else {
					// throw new Error("\n\t" + "没有注册接口回调方法:" + api + "\n\t------");
					log("没有注册接口回调方法:" + api + "\n\t------");
				}
				dispatch(api);
				// removeNotAllow(api);
			}
			// 销毁返回对象
			SocketResp.disposeResp(respObj);
		}

		private function getChannel(api : int) : String {
			var channelStr : String = "";
			if (Global.isDebug) {
				var action : uint = PacketParse.getAction(api);
				
			}
			return channelStr;
		}

		/**
		 * 回调事件
		 */
		protected function dispatch(api : uint) : void {
			if (_eventList[api] is Function) {
				_event.dispatchEvent(new Event(EVENT_PRE + api));
			} else {
				// Helper.alert("[response]接口没有注册UI回调方法:", Protocol.getProtocolDescription(_loc_4["request"]));
				// trace("[response]接口没有注册UI回调方法:", api);
			}
		}

		/**
		 * 请求
		 * @param req 请求对象
		 * @param callback 回调成功，无参数，（数据更新另处理）
		 */
		public function call(req : SocketReq, callback : Function = null, noTimeLimit : Boolean = true) : void {
			if (this._sock.connected == false) {
				dispatchEvent(new SocketEvent(SocketEvent.CALL_ERROR));
				return;
			}
			if (hasNotAllow(req.api)) {
				return;
			}
			// 是否时间允许
			if (noTimeLimit == false) {
				addNotAllow(req.api);
			}
			var api : uint = req.api;
			if (callback is Function) {
				pendBase(api, getHandler(api, callback));
			}
			netCall(req);
		}

		/**
		 * 单次请求
		 */
		public function onceCall(req : SocketReq, callback : Function, respCla : Class) : void {
			if (this._sock.connected == false) {
				dispatchEvent(new SocketEvent(SocketEvent.CALL_ERROR));
				return;
			}
			_onceCallList[req.seq] = [callback, respCla];
			netCall(req);
		}

		/**
		 * 添加回调
		 */
		private function pendBase(api : uint, handler : Function) : void {
			if (_eventList[api] is Function) {
				cancelPendBase(api);
			}
			_eventList[api] = handler;
			_event.addEventListener(EVENT_PRE + api, handler);
		}

		/**
		 * 请求
		 */
		private function netCall(req : SocketReq) : void {
			// 序列化
			var channelStr : String = getChannel(req.api);
			log(channelStr, getTimer()+"|发送数据内容[" + req.seq + "](" + PacketParse.printApi(req.api) + "):", req.obj.toString());
			var sendData : ByteArray = PacketParse.synthesize(req);
			SocketReq.disposeReq(req);
			// FYLogger.debug("发送数据",sendData.length);
			this._sock.writeBytes(sendData, 0, sendData.length);
			this._sock.flush();
			_beatTime = getTimer();
		}

		/**
		 * 获得api
		 */
		private function getHandler(api : uint, callback : Function) : Function {
			// 回调函数
			function handler(event : Event) : void {
				if (!keepAlive(api)) {
					cancelPendBase(api);
				}
				callback();
			}
			return handler;
		}

		/**
		 * 退出
		 */
		private function cancelPendBase(api : uint) : void {
			var fun : Function = _eventList[api] as Function;
			if (fun != null) {
				var evtStr : String = EVENT_PRE + api;
				_event.removeEventListener(evtStr, fun);
			}
		}

		public function get beatTime() : int {
			return _beatTime;
		}
	}
}
