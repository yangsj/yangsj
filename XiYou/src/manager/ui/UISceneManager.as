package manager.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 说明：SceneManager
	 * @author Victor
	 * 2012-9-28
	 */
	
	public class UISceneManager
	{
		public static var container:Sprite;
		
		public function UISceneManager()
		{
		}
		
		public static function addChild(display:DisplayObject):void
		{
			if (container == null) return ;
			if (display)
			{
				container.addChild(display);
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