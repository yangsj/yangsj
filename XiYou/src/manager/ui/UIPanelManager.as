package manager.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 说明：PanelManager
	 * @author Victor
	 * 2012-9-28
	 */
	
	public class UIPanelManager
	{
		public static var container:Sprite;
		
		private static var _hasMask:Boolean = false;
		
		public function UIPanelManager()
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
			}
		}
		
		public static function removeChild(display:DisplayObject):void
		{
			if (container == null) return ;
			if (display)
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
				}
				if (container.numChildren > 0)
				{
					drawBackGround();
				}
				else
				{
					clearBackGround();
				}
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
		
		private static function drawBackGround(alpha:Number=0.4):void
		{
			if (container == null) return ;
			
			container.graphics.clear();
			container.graphics.beginFill(0x000000, alpha);
			container.graphics.drawRect(0,0,1500,1500);
			container.graphics.endFill();
			
			_hasMask = alpha > 0 ? true : false;
		}
		
		private static function clearBackGround():void
		{
			container.graphics.clear();
			_hasMask = false;
		}
		
		////////////////// getters/setters ///////////////////////////////////////////
		
		public static function get hasMask():Boolean
		{
			return _hasMask;
		}
		
		
	}
	
}