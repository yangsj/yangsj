package core
{
	import core.main.manager.LocalStoreManager;
	import core.main.systemIcon.SystemIconMenuType;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-10
	 */
	public class Setting
	{

		public function Setting()
		{
		}

		public static function getValueBtType( type:String ):*
		{
			switch ( type )
			{
				case SystemIconMenuType.PLAY_MODE_SUB_LOOP:
					return playLoop;
					break;
				case SystemIconMenuType.PLAY_MODE_SUB_RANDOM:
					return playRandom;
					break;
				case SystemIconMenuType.PLAY_MODE_SUB_SINGLE:
					return playSingle;
					break;
				case SystemIconMenuType.SETTING_SUB_AUTO_PLAY:
					return autoPlay;
					break;
				case SystemIconMenuType.SETTING_SUB_AUTO_LOGIN:
					return autoLogin;
					break;
				case SystemIconMenuType.SETTING_SUB_ALWAYS_IN_FRONT:
					return alwaysInFront;
					break;
				case SystemIconMenuType.SETTING_SUB_ALWAYS_IN_BACK:
					return alwaysInBack;
					break;
				default:
					return 0;
			}
		}

		public static function setValueBtType( type:String, value:* ):void
		{
			switch ( type )
			{
				case SystemIconMenuType.PLAY_MODE_SUB_LOOP:
					playLoop = value;
					break;
				case SystemIconMenuType.PLAY_MODE_SUB_RANDOM:
					playRandom = value;
					break;
				case SystemIconMenuType.PLAY_MODE_SUB_SINGLE:
					playSingle = value;
					break;
				case SystemIconMenuType.SETTING_SUB_AUTO_PLAY:
					autoPlay = value;
					break;
				case SystemIconMenuType.SETTING_SUB_AUTO_LOGIN:
					autoLogin = value;
					break;
				case SystemIconMenuType.SETTING_SUB_ALWAYS_IN_FRONT:
					alwaysInFront = value;
					break;
				case SystemIconMenuType.SETTING_SUB_ALWAYS_IN_BACK:
					alwaysInBack = value;
					break;
				default:
			}
		}

		/**
		 * 获取音量大小值
		 */
		public static function get currentVoice():Number
		{
			return Number( LocalStoreManager.getData( "currentVoice" ));
		}

		/**
		 * @private
		 */
		public static function set currentVoice( value:Number ):void
		{
			LocalStoreManager.setData( "currentVoice", value );
		}

		/**
		 * 总是在最前的
		 */
		public static function get alwaysInFront():Boolean
		{
			return Boolean( LocalStoreManager.getData( "alwaysInFront" ));
		}

		/**
		 * @private
		 */
		public static function set alwaysInFront( value:Boolean ):void
		{
			LocalStoreManager.setData( "alwaysInFront", value );
		}

		/**
		 * 总是在最后的
		 */
		public static function get alwaysInBack():Boolean
		{
			return Boolean( LocalStoreManager.getData( "alwaysInBack" ));
		}

		/**
		 * @private
		 */
		public static function set alwaysInBack( value:Boolean ):void
		{
			LocalStoreManager.setData( "alwaysInBack", value );
		}

		/**
		 * 开机自动启动
		 */
		public static function get autoLogin():Boolean
		{
			return Boolean( LocalStoreManager.getData( "autoLogin" ));
		}

		/**
		 * @private
		 */
		public static function set autoLogin( value:Boolean ):void
		{
			LocalStoreManager.setData( "autoLogin", value );
		}

		/**
		 * 启动后自动播放
		 */
		public static function get autoPlay():Boolean
		{
			return Boolean( LocalStoreManager.getData( "autoPlay" ));
		}

		/**
		 * @private
		 */
		public static function set autoPlay( value:Boolean ):void
		{
			LocalStoreManager.setData( "autoPlay", value );
		}

		/**
		 * 是否是循环播放模式
		 */
		public static function get playLoop():Boolean
		{
			return Boolean( LocalStoreManager.getData( "playLoop" ));
		}

		/**
		 * @private
		 */
		public static function set playLoop( value:Boolean ):void
		{
			LocalStoreManager.setData( "playLoop", value );
		}

		/**
		 * 是否是随机播放模式
		 */
		public static function get playRandom():Boolean
		{
			return Boolean( LocalStoreManager.getData( "playRandom" ));
		}

		/**
		 * @private
		 */
		public static function set playRandom( value:Boolean ):void
		{
			LocalStoreManager.setData( "playRandom", value );
		}

		/**
		 * 是否是单曲播放模式
		 */
		public static function get playSingle():Boolean
		{
			return Boolean( LocalStoreManager.getData( "playSingle" ));
		}

		/**
		 * @private
		 */
		public static function set playSingle( value:Boolean ):void
		{
			LocalStoreManager.setData( "playSingle", value );
		}


	}
}
