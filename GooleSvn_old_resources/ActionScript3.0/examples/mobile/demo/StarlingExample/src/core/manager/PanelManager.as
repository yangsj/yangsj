package core.manager
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class PanelManager
	{
		public static var panelContainer:Sprite;
		
		public static function addPanel($display:DisplayObject):void
		{
			if (panelContainer == null || $display == null) return ;
			
			panelContainer.addChild($display);
			
			$display.x = ($display.stage.stageWidth - $display.width) * 0.5;
			$display.y = ($display.stage.stageHeight- $display.height)* 0.5;
		}
		
		public static function removePanel($display:DisplayObject):void
		{
			if ($display == null) return ;
			if ($display.parent)
			{
				$display.removeFromParent(true);
			}
		}
		
		public static function removeALl():void
		{
			if (panelContainer == null) return ;
			
			while (panelContainer.numChildren > 0) 
			{
				panelContainer.getChildAt(0).removeFromParent(true);
			}
		}
		
		
	}
}