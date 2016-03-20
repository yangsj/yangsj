package managers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 说明：BackGroundManager
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-19
	 */
	
	public class BackGroundManager
	{
		private var _backGroundContainer:Sprite;
		
		public function BackGroundManager()
		{
			if (_instance)
			{
				throw new Error("BackGroundManager Class is the instance, cannot create more!!!!");
			}
			_instance = this;
		}
		
		//////////////////// pubic functions //////////////////
		
		public function addBackGround($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			if (backGroundContainer)
			{
				backGroundContainer.addChild($dis);
			}
		}
		
		public function removeBackGround($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			if ($dis.parent)
			{
				$dis.parent.removeChild($dis);
			}
		}
		
		public function removeAll():void
		{
			if (backGroundContainer)
			{
				while (backGroundContainer.numChildren > 0) backGroundContainer.removeChildAt(0);
			}
		}
		
		////////////////// instance ///////////////
		
		private static var _instance:BackGroundManager;
		public static function get instance():BackGroundManager
		{
			if (_instance == null) new BackGroundManager();
			return _instance;
		}
		
		///////////////// getter/setter functions ///////////////////
		
		/**
		 * 场景背景图片显示容器
		 */
		public function get backGroundContainer():Sprite
		{
			return _backGroundContainer;
		}

		/**
		 * @private
		 */
		public function set backGroundContainer(value:Sprite):void
		{
			_backGroundContainer = value;
		}

	}
	
}