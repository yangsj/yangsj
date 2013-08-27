package victor.framework.utils
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
			if ( target && target.parent )
			{
				return target.parent.removeChild( target );
			}
			return target;
		}

		/**
		 * 移除所有对象，并停止Movieclip时间轴
		 * @param target 容器对象
		 * @param isStopAllFrame 是否循环子级
		 */
		public static function removedAll( target:DisplayObjectContainer, isChildren:Boolean = true ):void
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
					if ( isChildren )
					{
						if ( dis is DisplayObjectContainer )
						{
							removedAll( dis as DisplayObjectContainer, isChildren );
						}
					}
				}
			}
		}
		
		public static function stopAllMovieClips( target:DisplayObjectContainer ):void
		{
			if ( target )
			{
				if ( target.hasOwnProperty( "" ))
				{
					target.stopAllMovieClips();
				}
				else
				{
					if ( target is MovieClip )
					{
						( target as MovieClip ).stop();
					}
					var numChildren:int = target.numChildren;
					for (var i:int = 0; i < numChildren; i++)
					{
						var dis:DisplayObject = target.getChildAt( i );
						if ( dis is DisplayObjectContainer )
						{
							stopAllMovieClips( dis as DisplayObjectContainer );
						}
					}
				}
			}
		}
		
		

	}
}
