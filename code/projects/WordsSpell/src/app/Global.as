package app
{
	import flash.system.Capabilities;
	import app.utils.appStage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class Global
	{
		public function Global()
		{
		}
		
		/**
		 * 是否是调试状态
		 */
		public static function get isDebug():Boolean
		{
			return Capabilities.isDebugger;
		}
		
/////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////          game url        ////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
		
		private static var _serverURL:String = "";
		
		public static function get serverURL():String
		{
			if ( _serverURL == "" )
			{
				_serverURL = appStage.loaderInfo.url;
				_serverURL = _serverURL.replace(/\\/g, "/");
				_serverURL = _serverURL.substring(0, _serverURL.lastIndexOf("/") + 1);
			}
			return _serverURL;
		}
		
		public static function set serverURL( value:String ):void
		{
			_serverURL = value;
		}
		
	}
}