package manager.ui
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * 说明：PopManager
	 * @author Victor
	 * 2012-9-28
	 */
	
	public class UIPopManager
	{
		public static var container:Sprite;
		
		public function UIPopManager()
		{
		}
		
		/**
		 * 
		 * @param display 将要显示的现显示对象
		 * @param hasMask 是否需要一个黑色半透明的底, 默认显示
		 * @param alpha 黑色半透明底的透明度，默认为0.4
		 * 
		 */
		public static function addChild(display:DisplayObject, hasMask:Boolean=true, alpha:Number=0.4):void
		{
			if (container == null) return ;
			if (display)
			{
				container.addChild(display);
				if (hasMask)
				{
					drawBackGround(alpha);
				}
				open(display);
			}
		}
		
		public static function removeChild(display:DisplayObject):void
		{
			if (container == null) return ;
			if (display)
			{
				if (container.numChildren > 1)
				{
					drawBackGround();
				}
				else
				{
					clearBackGround();
				}
				
				close(display);
				
				display = null;
			}
		}
		
		public static function removeAll():void
		{
			if (container == null) return ;
			while (container.numChildren > 0)
			{
				container.removeChildAt(0);
			}
			clearBackGround();
		}
		
		private static function open(display:DisplayObject):void
		{
			var endx:Number = display.x;
			var endy:Number = display.y;
			var rect:Rectangle = display.getBounds(display);
			var startx:Number = endx + (rect.width * 0.5 + rect.x);
			var starty:Number = endy + (rect.height * 0.5 + rect.y);
			display.scaleX = display.scaleY = 0;
			display.x = startx;
			display.y = starty;
			TweenMax.to(display, 0.3, {x:endx, y:endy, scaleX:1, scaleY:1, ease:Elastic.easeIn, onComplete:tweenComplete, onCompleteParams:[display, false]});
		}
		
		private static function close(display:DisplayObject):void
		{
			var startx:Number = display.x;
			var starty:Number = display.y;
			var rect:Rectangle = display.getBounds(display);
			var endx:Number = startx + (rect.width * 0.5 + rect.x);
			var endy:Number = starty + (rect.height * 0.5 + rect.y);
			TweenMax.to(display, 0.3, {x:endx, y:endy, scaleX:0, scaleY:0, ease:Elastic.easeOut, onComplete:tweenComplete, onCompleteParams:[display, true]});
		}
		
		private static function tweenComplete(display:DisplayObject, isClose:Boolean=false):void
		{
			TweenMax.killTweensOf(display);
			if (isClose)
			{
				if (display.parent)
				{
					if (container == display.parent)
					{
						container.removeChild(display);
					}
					else
					{
						display.parent.removeChild(display);
					}
					if (container.numChildren > 0)
					{
						drawBackGround();
					}
					else
					{
						clearBackGround();
					}
				}
			}
		}
		
		private static function drawBackGround(alpha:Number=0.4):void
		{
			if (container == null) return ;
			
			if (alpha > 0)
			{
				if (UIPanelManager.hasMask) alpha = 0;
			}
			
			container.graphics.clear();
			container.graphics.beginFill(0x000000, alpha);
			container.graphics.drawRect(0,0,1500,1500);
			container.graphics.endFill();
		}
		
		private static function clearBackGround():void
		{
			container.graphics.clear();
		}
		
		
	}
	
}