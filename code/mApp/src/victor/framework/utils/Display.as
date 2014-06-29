package victor.framework.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Display
	{
		
		public function Display()
		{
		}
		
		/**
		 * 安全的从父容器中移除目标对象
		 * @param target 需要移除的目标对象
		 * @return 返回移除的目标对象
		 */
		public static function removedFromParent( target:DisplayObject ):DisplayObject
		{
			if ( target && target.parent )
			{
				target.parent.removeChild( target );
			}
			return target;
		}
		
		/**
		 * 移除所有子对象
		 * @param container
		 */
		public static function removeAllChildren( container:DisplayObjectContainer, isChildren:Boolean = false ):void
		{
			if ( container )
			{
				if ( container.hasEventListener( "removeChildren" ) )
				{
					container["removeChildren"]();
				}
				else
				{
					var dis:DisplayObjectContainer;
					while ( container.numChildren > 0 )
					{
						dis = container.removeChildAt( 0 ) as DisplayObjectContainer;
						if ( isChildren ) removeAllChildren( dis, isChildren );
					}
				}
			}
		}
		
		
	}
}