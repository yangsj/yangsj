package manager.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 说明：UIMainManager
	 * @author Victor
	 * 2012-9-29
	 */
	
	public class UIMainManager
	{
		public static var container:Sprite;
		
		public function UIMainManager()
		{
		}
		
		public static function addChild(display:DisplayObject):void
		{
			if (container == null) return ;
			if (display)
			{
				container.addChild(display);
			}
			display = null;
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
		}
		
		
		
	}
	
}