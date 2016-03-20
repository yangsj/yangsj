package managers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * 说明：PanelManager
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-19
	 */
	
	public class PanelManager
	{
		private var _panelContainer:Sprite;
		
		public function PanelManager()
		{
			if (_instance)
			{
				throw new Error("PanelManger Class is the instance, cannot create more!!!!");
			}
			_instance = this;
		}
		
		////////////////// public functions ////////////
		
		public function addPanel($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			if (panelContainer)
			{
				var rect:Rectangle = $dis.getBounds($dis);
				var scale_x:Number = $dis.scaleX;
				var scale_y:Number = $dis.scaleY;
				panelContainer.addChild($dis);
				$dis.x = (panelContainer.stage.stageWidth - $dis.width) * 0.5 - rect.x * scale_x;
				$dis.y = (panelContainer.stage.stageHeight - $dis.height) * 0.5 - rect.y * scale_y;
				
				createMask();
			}
		}
		
		public function removePanel($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			
			if ($dis.parent)
			{
				$dis.parent.removeChild($dis);
			}
			if (panelContainer)
			{
				if (panelContainer.numChildren == 0) panelContainer.graphics.clear();
			}
		}
		
		public function removeAll():void
		{
			if (panelContainer)
			{
				while (panelContainer.numChildren > 0) panelContainer.removeChildAt(0);
				panelContainer.graphics.clear();
			}
		}
		
		/////////////////// private functions ////////////////
		
		private function createMask():void
		{
			if (panelContainer)
			{
				panelContainer.graphics.clear();
				panelContainer.graphics.beginFill(0x000000, 0.4);
				panelContainer.graphics.drawRect(-100,-100,2000,2000);
				panelContainer.graphics.endFill();
			}
		}
		
		////////////////// instance ///////////////
		
		private static var _instance:PanelManager;
		public static function get instance():PanelManager
		{
			if (_instance == null) new PanelManager();
			return _instance;
		}
		
		///////////////// getter/setter functions //////////////////////
		
		/**
		 * 面板显示容器
		 */
		public function get panelContainer():Sprite
		{
			return _panelContainer;
		}

		/**
		 * @private
		 */
		public function set panelContainer(value:Sprite):void
		{
			_panelContainer = value;
		}

	}
	
}