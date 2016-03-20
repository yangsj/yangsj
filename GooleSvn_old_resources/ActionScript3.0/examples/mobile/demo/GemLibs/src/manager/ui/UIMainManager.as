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
		public static var contaier:Sprite;
		
		public function UIMainManager()
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