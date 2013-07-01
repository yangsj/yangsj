package victor.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;

	/**
	 * ……
	 * @author yangsj
	 */
	public class DisplayUtil
	{
		public function DisplayUtil()
		{
		}

		/**
		 * 从父容器中移除显示对象
		 * @param target 被移除的对象
		 * @return 是
		 *
		 */
		public static function removedFromParent( target:DisplayObject ):DisplayObject
		{
			if ( target )
			{
				if ( target.parent )
				{
					return target.parent.removeChild( target );
				}
			}
			return target;
		}

		/**
		 * 移除所有对象，并停止Movieclip时间轴
		 * @param target 容器对象
		 * @param isStopAllFrame 是否循环子级
		 */
		public static function removedAll( target:DisplayObjectContainer, isStopAllFrame:Boolean = true ):void
		{
			if ( target )
			{
				while ( target.numChildren > 0 )
				{
					var dis:DisplayObject = target.removeChildAt( 0 );
					if ( dis is MovieClip )
					{
						( dis as MovieClip ).stop();
					}
					if ( isStopAllFrame )
					{
						if ( dis is DisplayObjectContainer )
						{
							removedAll( dis as DisplayObjectContainer, isStopAllFrame );
						}
					}
				}
			}
		}

	}
}
