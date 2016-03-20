package core.manager
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class SceneManager
	{
		
		public static var sceneContainer:Sprite;
		
		public static function addChild($display:DisplayObject):void
		{
			if (sceneContainer == null || $display == null) return ;
			
			sceneContainer.addChild($display);
		}
		
		public static function removeChild($display:DisplayObject):void
		{
			if ($display == null) return ;
			
			if ($display.parent)
			{
				$display.removeFromParent(true);
			}
		}
		
		public static function removeAll():void
		{
			if (sceneContainer == null) return ;
			
			while (sceneContainer.numChildren > 0) 
			{
				sceneContainer.getChildAt(0).removeFromParent(true);
			}
		}
		
		
		
		
	}
}