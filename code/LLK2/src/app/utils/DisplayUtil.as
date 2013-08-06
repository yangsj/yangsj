package app.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

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
		
		public static function getTextFiled(size:uint, color:uint, align:String = TextFormatAlign.LEFT, wordWrap:Boolean = false):TextField
		{
			var tfm:TextFormat = new TextFormat();
			tfm.align = align;
			tfm.bold = true;
			tfm.color = color;
			tfm.kerning = true;
			tfm.leading = 8;
			tfm.letterSpacing = 2;
			tfm.size = size;
			var txt:TextField = new TextField();
			txt.defaultTextFormat = tfm;
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.wordWrap = wordWrap;
			return txt;
		}

	}
}
