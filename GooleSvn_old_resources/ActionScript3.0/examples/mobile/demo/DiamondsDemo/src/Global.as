package
{
	import flash.display.Stage;
	import flash.system.ApplicationDomain;
	
	/**
	 * 说明：Global
	 * @author victor
	 * 2012-9-15 下午2:46:21
	 */
	
	public class Global
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="app.xml", mimeType="application/octet-stream")]
		private static var AppXml:Class; // 应用程序中资源配置文件类
		
		//////// getter/setter vars ///////////////
		
		private static var _isOpenMusic:Boolean;
		private static var _appXml:XML;
		private static var _appDomain:ApplicationDomain;
		
		/////////// public vars ////////////
		
		public static var isDebug:Boolean = false;
		public static var isOpenAutoClickProgram:Boolean = false;
		public static var stage:Stage;
		
		public function Global()
		{
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		////////////////// getter/setter //////////////////////////
		
		
		public static function get appXml():XML
		{
			if (_appXml == null)
			{
				_appXml = XML(new AppXml());
			}
			return _appXml;
		}

		public static function get appDomain():ApplicationDomain
		{
			if (_appDomain == null)
			{
				return ApplicationDomain.currentDomain;
			}
			return _appDomain;
		}

		public static function set appDomain(value:ApplicationDomain):void
		{
			_appDomain = value;
		}

		/**
		 * 是否开启音效
		 */
		public static function get isOpenMusic():Boolean
		{
			return _isOpenMusic;
		}

		/**
		 * @private
		 */
		public static function set isOpenMusic(value:Boolean):void
		{
			_isOpenMusic = value;
		}
		
	}
}