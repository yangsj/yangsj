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
		public static var contaier:Sprite;
		
		public function UISceneManager()
		{
		}
		
		public static function addChild(display:DisplayObject):void
		{
			if (contaier == null) return ;
			if (display)
			{
				contaier.addChild(display);
			}
		}
		
		public static function removeChild(display:DisplayObject):void
		{
			if (contaier == null) return ;
			if (display)
			{
				if (display.parent)
				{
					if (contaier == display.parent)
					{
						contaier.removeChild(display);
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
			if (contaier == null) return ;
			while (contaier.numChildren > 0)
			{
				contaier.removeChildAt(0);
			}
		}
		
	}
	
}