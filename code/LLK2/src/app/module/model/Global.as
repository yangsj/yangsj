package app.module.model
{
	import flash.filesystem.File;
	import flash.system.Capabilities;
	
	import app.manager.LocalStoreManager;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-13
	 */
	public class Global
	{
		private static var _currentModule:uint;
		private static var _lastDownTime:Number = 0;
		private static var _switchResultVibrate:Boolean = true;
		private static var _appUpdateUrl:String;
		private static var _fileNameStr:String;
		private static var _isAutoUpdate:Boolean = true;
		
		
		public function Global()
		{
			super();
		}

		public static function get lastDownTime():Number
		{
			return _lastDownTime;
		}

		public static function set lastDownTime(value:Number):void
		{
			_lastDownTime = value;
		}
		
		/**
		 * 是否是安卓平台
		 */
		public static function get isAndroid():Boolean
		{
			return (Capabilities.manufacturer.indexOf("Android") != -1);
		}
		
		/**
		 * 是否是ios平台
		 */
		public static function get isIOS():Boolean
		{
			return (Capabilities.manufacturer.indexOf("iOS") != -1);
		}

		/**
		 * 震动开关
		 */
		public static function get switchResultVibrate():Boolean
		{
			return _switchResultVibrate;
		}

		/**
		 * @private
		 */
		public static function set switchResultVibrate(value:Boolean):void
		{
			_switchResultVibrate = value;
		}

		/**
		 * 应用更新地址
		 */
		public static function get appUpdateUrl():String
		{
			return _appUpdateUrl;
		}

		/**
		 * @private
		 */
		public static function set appUpdateUrl(value:String):void
		{
			_appUpdateUrl = value;
		}

		/**
		 * 应用名称
		 */
		public static function get fileNameStr():String
		{
			return _fileNameStr;
		}

		/**
		 * @private
		 */
		public static function set fileNameStr(value:String):void
		{
			_fileNameStr = value;
		}
		
		/**
		 * 当前安装的版本号
		 */
		public static function get currentVersion():String
		{
			var o:Object = LocalStoreManager.getData( "version" );
			if ( o )
				return o.toString();
			return "";
		}
		
		public static function set currentVersion( value:String ):void
		{
			LocalStoreManager.setData( "version", value );
		}
		
		public static function get filePath():File
		{
			return File.documentsDirectory;
		}

		/**
		 * 是否自动更新检查
		 */
		public static function get isAutoUpdate():Boolean
		{
			return _isAutoUpdate;
		}

		/**
		 * @private
		 */
		public static function set isAutoUpdate(value:Boolean):void
		{
			_isAutoUpdate = value;
		}


	}
}