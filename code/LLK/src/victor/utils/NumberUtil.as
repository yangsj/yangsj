package victor.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import number.UINumberSkin;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-3
	 */
	public class NumberUtil
	{
		private static var _dict:Dictionary;

		public function NumberUtil()
		{
		}

		public static function createNumSprite( num:* ):Sprite
		{
			var numString:String = num + "";
			if ( _dict == null )
			{
				var keys:Array = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "+", "L" ];
				var mc:MovieClip = new UINumberSkin();
				_dict = new Dictionary();
				for each ( var key:* in keys )
				{
					mc.gotoAndStop( "num_" + key );
					_dict[ "key" + key ] = BitmapUtil.cloneBitmapFromTarget( mc ).bitmapData;
				}
			}
			var tx:Number = 0;
			var sprite:Sprite = new Sprite();
			for ( var i:int = 0; i < numString.length; i++ )
			{
				var bitdata:BitmapData = _dict[ "key" + numString.substr( i, 1 )] as BitmapData;
				var bitmap:Bitmap = new Bitmap( bitdata, "auto", true );
				bitmap.x = tx;
				tx += bitmap.width;
				sprite.addChild( bitmap );
			}

			return sprite;
		}


	}
}
