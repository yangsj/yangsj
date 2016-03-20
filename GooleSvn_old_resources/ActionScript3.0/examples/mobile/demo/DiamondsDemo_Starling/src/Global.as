package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
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
		private static var _appXml:XML;
		private static var _appDomain:ApplicationDomain;
		private static var _isOpenMusic:Boolean;
		private static var _isDebug:Boolean = false;
		private static var _isOpenAutoClickProgram:Boolean = false;
		
		public function Global()
		{
		}
		
		////////////////// static /////////////////////////////////
		
		/**
		 * 绘制Bitmap图形
		 * @param $source
		 * @param $imageAlpha
		 * @param $smoothing
		 * @return 
		 * 
		 */
		public static function drawAsBitmap($source:DisplayObject, $imageAlpha:Number = 1, $smoothing:Boolean = true):Bitmap
		{
			var bitmap:Bitmap = new Bitmap(createBitmapData($source, $imageAlpha, $smoothing), "auto", $smoothing);
			
			return bitmap;
		}
		
		/**
		 * 创建BitmapData数据
		 * @param $source
		 * @param $imageAlpha
		 * @param $smoothing
		 * @return 
		 * 
		 */
		public static function createBitmapData($source:DisplayObject, $imageAlpha:Number = 1, $smoothing:Boolean = true):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData($source.width, $source.height, true, 0);
			bitmapData.draw($source, null, new ColorTransform(1,1,1,$imageAlpha) , null, null, $smoothing);
			
			return bitmapData;
		}
		
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

		/**
		 * 是否是调试状态
		 */
		public static function get isDebug():Boolean
		{
			return _isDebug;
		}

		/**
		 * @private
		 */
		public static function set isDebug(value:Boolean):void
		{
			_isDebug = value;
		}

		/**
		 * 是否启用自动点击程序（仅在调试状态下有效）
		 */
		public static function get isOpenAutoClickProgram():Boolean
		{
			if (isDebug == false) return false;
			return _isOpenAutoClickProgram;
		}

		/**
		 * @private
		 */
		public static function set isOpenAutoClickProgram(value:Boolean):void
		{
			_isOpenAutoClickProgram = value;
		}

		
	}
}