package managers
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * 说明：SceneManager
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-19
	 */
	
	public class SceneManager
	{
		private var _sceneContainer:Sprite;
		
		public function SceneManager()
		{
			if (_instance)
			{
				throw new Error("BackGroundManager Class is the instance, cannot create more!!!!");
			}
			_instance = this;
		}
		
		////////////////// public functions //////////////
		
		public function addChild($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			if (sceneContainer)
			{
				sceneContainer.addChild($dis);
			}
		}
		
		public function removeChild($dis:DisplayObject):void
		{
			if ($dis == null) return ;
			if ($dis.parent)
			{
				$dis.parent.removeChild($dis);
			}
		}
		
		
		////////////////// instance ///////////////
		
		private static var _instance:SceneManager;
		public static function get instance():SceneManager
		{
			if (_instance == null) new SceneManager();
			return _instance;
		}
		
		////////////////// getter/setter functions ////////////////
		
		/**
		 * 场景容器
		 */
		public function get sceneContainer():Sprite
		{
			return _sceneContainer;
		}

		/**
		 * @private
		 */
		public function set sceneContainer(value:Sprite):void
		{
			_sceneContainer = value;
		}

	}
	
}