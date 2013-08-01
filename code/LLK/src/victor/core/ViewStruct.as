package victor.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;

	import victor.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class ViewStruct
	{
		private static var numCount:uint = 0;
		
		public static const BACKGROUND:uint = numCount++;
		public static const SCENE:uint = numCount++;
		public static const MAIN:uint = numCount++;
		public static const PANEL:uint = numCount++;
		public static const ALERT:uint = numCount++;

		private static var container:Sprite;

		public function ViewStruct()
		{
		}

		public static function initialize( stage:Stage ):void
		{
			if ( container == null )
			{
				var spr:Sprite;
				container = new Sprite();
				stage.addChild( container );
				for ( var i:int = 0; i < numCount; i++ )
				{
					spr = new Sprite();
					container.addChild( spr );
				}
			}
		}

		public static function addChild( child:DisplayObject, containerType:uint ):void
		{
			if ( child )
			{
				if ( containerType < container.numChildren )
				{
					var spr:Sprite = container.getChildAt( containerType ) as Sprite;
					spr.addChild( child );
				}
				else
				{
					throw new Error( "在addChild时指定的containerType值不在允许范围。" );
				}
			}
		}

		public static function removeChild( child:DisplayObject ):void
		{
			DisplayUtil.removedFromParent( child );
		}


	}
}
