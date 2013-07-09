package core
{
	import flash.display.NativeWindow;
	import flash.display.Stage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-7-9
	 */
	public class Global
	{
		public function Global()
		{
		}
		
		private static var _stage:Stage;
		
		
		public static function get stage():Stage
		{
			return _stage;
		}

		public static function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		public static function get nativeWindow():NativeWindow
		{
			return _stage.nativeWindow;
		}

	}
}