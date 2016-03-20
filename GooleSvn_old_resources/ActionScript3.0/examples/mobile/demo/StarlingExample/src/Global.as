package
{
	import flash.system.ApplicationDomain;

	public class Global
	{
		
		[Embed(source="app.xml", mimeType="application/octet-stream")]
		private static var AppXml:Class; // 应用程序中资源配置文件类
		
		
		private static var _appXml:XML;
		private static var _appDomain:ApplicationDomain;
		
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
		
		
		
	}
}