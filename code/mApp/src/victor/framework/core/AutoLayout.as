package victor.framework.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import victor.framework.constant.ScreenType;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-13
	 */
	public class AutoLayout
	{
		
		public static function layout( target:DisplayObjectContainer ):void
		{
			if ( target )
			{
				var length:int = target.numChildren;
				var disChild:DisplayObject;
				var scale:Number = ScreenType.scale;
				var scaleX:Number = ScreenType.scaleX;
				var scaleY:Number = ScreenType.scaleY;
				for ( var i:int = 0; i < length; i++ )
				{
					disChild = target.getChildAt( i );
					disChild.scaleX *= scale;
					disChild.scaleY *= scale;
					disChild.x *= scaleX;
					disChild.y *= scaleY;
				}
			}
		}
		
	}
}