package utils
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	import ui.number.Adventure_Number_0;
	import ui.number.Level_Black_Number_0;
	import ui.number.Level_White_Number_0;


	/**
	 * 说明：Numeric
	 * @author Victor
	 * 2012-11-16
	 */

	public class Numeric
	{
		public static const NUM_DEFAULT : String = "ui.number.Adventure_Number_";
		/**
		 * 指定使用冒险模块中的数字字体
		 */
		public static const NUM_ADVENTURE : String = "ui.number.Adventure_Number_";
		/**
		 * 等级白色字样
		 */
		public static const NUM_LEVEL_WHITE : String = "ui.number.Level_White_Number_";
		/**
		 * 等级黑色字样
		 */
		public static const NUM_LEVEL_BLACK : String = "ui.number.Level_Black_Number_";


		private static var numbersDict : Dictionary;

		public function Numeric()
		{
		}


		/**
		 * 获取指定类型的数字的资源
		 * @param number 一个字符串，可以带一些资源拥有的符号:暂支持“LV”， “/”等。
		 * 等级用到的符号"LV"用字母"L"表示
		 * @param type 指定数字资源的前缀名
		 * @return
		 *
		 */
		public static function getNumeric( numString : String = "100", type : String = NUM_DEFAULT ) : Sprite
		{
			var sprite : Sprite = new Sprite();
			if ( !numbersDict )
				numbersDict = new Dictionary();

			var i : int = 0;
			var vecNum : Vector.<Class> = numbersDict[ type ] as Vector.<Class>;
			if ( !vecNum )
			{
				vecNum = new Vector.<Class>();
				for ( i = 0; i < 10; i++ )
					vecNum[ i ] = getDefinitionByName( type + i ) as Class;
			}

			var length : int = numString.length;
			for ( i = 0; i < length; i++ )
			{
				var str : String = numString.substr( i, 1 );
				var spr : Sprite;
				var cls : Class;
				if ( isNaN( Number( str )))
				{
					try
					{
						switch ( str )
						{
							case "L":
								cls = getDefinitionByName( type + "lv" ) as Class;
								break;
							case "/":
								cls = getDefinitionByName( type + "division" ) as Class;
								break;
						}
					}
					catch ( e : * )
					{
					}
				}
				else
				{
					var index : int = int( str );
					cls = vecNum[ index ] as Class;
				}
				if ( cls )
				{
					spr = ( new cls()) as Sprite;
					spr.x = sprite.width;
					sprite.addChild( spr );
				}
				cls = null;
			}

			return sprite;
		}

		private static function importNumberClass() : void
		{
			ui.number.Adventure_Number_0;
			ui.number.Adventure_Number_1;
			ui.number.Adventure_Number_2;
			ui.number.Adventure_Number_3;
			ui.number.Adventure_Number_4;
			ui.number.Adventure_Number_5;
			ui.number.Adventure_Number_6;
			ui.number.Adventure_Number_7;
			ui.number.Adventure_Number_8;
			ui.number.Adventure_Number_9;

			ui.number.Level_White_Number_0;
			ui.number.Level_White_Number_1;
			ui.number.Level_White_Number_2;
			ui.number.Level_White_Number_3;
			ui.number.Level_White_Number_4;
			ui.number.Level_White_Number_5;
			ui.number.Level_White_Number_6;
			ui.number.Level_White_Number_7;
			ui.number.Level_White_Number_8;
			ui.number.Level_White_Number_9;
			ui.number.Level_White_Number_lv;
			ui.number.Level_White_Number_division;

			ui.number.Level_Black_Number_0;
			ui.number.Level_Black_Number_1;
			ui.number.Level_Black_Number_2;
			ui.number.Level_Black_Number_3;
			ui.number.Level_Black_Number_4;
			ui.number.Level_Black_Number_5;
			ui.number.Level_Black_Number_6;
			ui.number.Level_Black_Number_7;
			ui.number.Level_Black_Number_8;
			ui.number.Level_Black_Number_9;
			ui.number.Level_Black_Number_lv;
		}


	}

}
