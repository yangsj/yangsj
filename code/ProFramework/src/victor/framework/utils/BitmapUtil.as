package victor.framework.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.text.TextField;

	/**
	 * ……
	 * @author yangsj
	 */
	public class BitmapUtil
	{
		public function BitmapUtil()
		{
		}

		public static function cloneBitmapFromTarget( target:DisplayObject ):Bitmap
		{
			var bitdata:BitmapData;
			try
			{
				bitdata = new BitmapData( target.width, target.height, true, 0 );
				bitdata.draw( target, null, null, null, null, true );
			}
			catch ( e:Error )
			{
				var txt:TextField = new TextField();
				txt.text = "invalid bitmap";
				return drawBitmapFromTextFeild( txt );
			}
			return new Bitmap( bitdata, "auto", true );
		}

		public static function drawBitmapFromTextFeild( textFeild:TextField ):Bitmap
		{
			textFeild.width = textFeild.textWidth + 10;
			textFeild.height = textFeild.textHeight + 10;
			var bitdata:BitmapData = new BitmapData( textFeild.width, textFeild.height, true, 0 );
			bitdata.draw( textFeild, null, null, null, null, true );
			return new Bitmap( bitdata, "auto", true );
		}

		/**
		 * 销毁指定的位图资源
		 * @param target
		 */
		public static function disposeBitmapFromTarget( bitmap:Bitmap ):void
		{
			if ( bitmap )
			{
				if ( bitmap.parent )
					bitmap.parent.removeChild( bitmap );
				if ( bitmap.bitmapData )
					bitmap.bitmapData.dispose();
				bitmap.bitmapData = null;
			}
		}

	}
}
