package datas
{


	/**
	 * 说明：User
	 * @author Victor
	 * 2012-10-2
	 */

	public class User
	{
		/** id */
		public var uid : String;

		/** 名称 */
		public var name : String;

		/** 头像地址 */
		public var picture : String;

		/** 等级属性 */
		public var level : int;

		/** 经验值 */
		public var exp : Number;

		/** 仙灵值 */
		public var immortal : int;


		///////////////////////////////////////////////////////////////////////////
		
		private var _data : Object;

		public function User()
		{
			_instance = this;
		}

		private static var _instance:User;
		public static function get instance():User
		{
			if (_instance == null) new User();
			return _instance;
		}


		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			_data = value;

			setData(_data);
		}

		public function refresh($data : Object) : void
		{
			setData($data);
			change($data);
		}

		private function setData($data : Object) : void
		{
			if ($data)
			{
				for (var key : String in $data)
				{
					if (this.hasOwnProperty(key))
					{
						this[key] = $data[key];
					}
				}
			}
		}

		private function change($data:Object):void
		{
			if (data == null) _data = {};
			if ($data)
			{
				for (var key:String in $data)
				{
					if (_data.hasOwnProperty(key))
					{
						_data[key] = $data[key];
					}
				}
			}
		}


	}

}
