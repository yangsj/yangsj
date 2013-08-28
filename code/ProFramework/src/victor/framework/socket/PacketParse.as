package victor.framework.socket {

	import flash.utils.ByteArray;

	/**
	 * @author fireyang
	 */
	public class PacketParse {
		private static var _seq : int = 1;
		// 保留验证
		private static var _checkKey : uint;

		/*
		 * 
		请求:
		+---------------------------------------+
		|                header                 |
		+---------+-----------------------------+
		| length  | type    | body              | 
		+---------+---------+-------------------+
		|short_int| uint32_t| body of length    |
		+---------+---------+-------------------+

		response message format:
		+------------------------------+-------------------+
		|           header             | length            |
		+---------+---------+------------------------------+
		| length  | type    | code     | body              | 
		+---------+---------+------------------------------+
		| uint32_t| uint32_t| uint32_t | body of length    |
		+---------+---------+------------------------------+
		 */
		/**
		 * 发请求压包
		 * @param req 请求对象
		 */
		public static function synthesize(req : SocketReq) : ByteArray {
			var msg : * = req.obj;
			var mData : ByteArray = new ByteArray();
			// 1.请求api
			var api : uint = req.api;
			// 2.type
			api = api << 2;
			// 2字节的msgId
			mData.writeShort(api);
			// 3.代码（2字节）
			var code : uint = 0;
			mData.writeShort(code);
			// 4.保留(2字节)
			var reserved : uint = _checkKey;
			mData.writeShort(reserved);
			// 5.顺序(4字节)
			mData.writeUnsignedInt(req.seq);
			// 请求数据
			var msgData : ByteArray = new ByteArray();
			msg.writeTo(msgData);
			msgData.position = 0;
			// 写入数据体
			mData.writeBytes(msgData, 0, msgData.length);
			// 包头
			var data : ByteArray = new ByteArray();
			// 包长度（2字节）
			data.writeShort(mData.length + 2);
			mData.position = 0;
			data.writeBytes(mData, 0, mData.length);
			return data;
		}

		/**
		 * 反向序列化
		 * @param buffer server端推回的数据流
		 * @param cla server对应的解包类
		 */
		public static function analyze(buffer : ByteArray) : SocketResp {
			// 解析数据
			buffer.position = 0;
			// 读取api(2字节)
			var api : uint = buffer.readShort();
			var type : uint = api & 3;
			api = api >> 2;
			var res : SocketResp = SocketResp.creat();
			res.api = api;
			res.type = type;
			var seq : uint = 0;
			// trace("api2:",PacketParse.getModule(api),PacketParse.getAction(api),type);
			if (type == 1) {
				// 3.代码
				var code : uint = buffer.readShort();
				// 保留
				var reserved : uint = buffer.readShort();
				// 时序
				seq = buffer.readUnsignedInt();
				// var msg : Message = new cla();
				// msg.mergeFrom(buffer);
				// res.data = msg;
			} else if (type == 2) {
				// 通知消息
				// var msg : Message = new cla();
				// res.data = buffer.readBytes(bytes);
			}
			// var data:ByteArray = new ByteArray();
			// buffer.readBytes(data,buffer.position,buffer.length-buffer.position);
			// trace("analyze2:",data.length,data.position);
			// FYLogger.debug("analyze", PacketParse.printApi(api), type, seq, buffer.position, buffer.length);
			res.seq = seq;
			var data : ByteArray = new ByteArray();
			var pos : uint = buffer.position;
			var len : uint = buffer.length - pos;
			data.writeBytes(buffer, pos, len);
			data.position = 0;
			res.data = data;
			return res;
		}

		public static function getModule(api : uint) : uint {
			var m : int = api;
			m = m >> 10;
			return m;
		}

		public static function getAction(api : uint) : uint {
			var value : int = api;
			// 后10位
			value = value & 0x3ff;
			return value;
		}

		/**
		 * 获取api
		 */
		public static function getApi(m : uint, action : uint) : uint {
            var module:uint = m << 10;
			var api : uint = module + action;
			return api;
		}

		public static function printApi(api : uint) : String {
			return PacketParse.getModule(api) + "-" + PacketParse.getAction(api);
		}

		public static function getSeq() : uint {
			return _seq++;
		}

		public static function setSeq(value : int) : void {
			_seq = value;
		}

		/**
		 * 设置校验
		 */
		public static function setCheckKey(checkKey : uint) : void {
			_checkKey = checkKey;
		}
	}
}
