package manager.ui
{

	import flash.display.Sprite;
	import flash.display.Stage;


	/**
	 * 说明：UIViewContainer
	 * @author Victor
	 * 2012-9-29
	 */

	public class UIViewContainer
	{
		private var _stage : Stage;

		/** 场景图层 */
		private var _sceneContainer : Sprite;
		/** 主视图层 */
		private var _mainContainer : Sprite;
		/** 面板图层 */
		private var _panelContainer : Sprite;
		/** pop 显示图层 */
		private var _popContainer : Sprite;
		/** 提示 图层 */
		private var _alertContainer : Sprite;

		private static var _instance : UIViewContainer;

		public static function get instance() : UIViewContainer
		{
			if (_instance == null)
				throw new Error("please create MainContainerView");
			return _instance;
		}

		public function UIViewContainer(stage : Stage)
		{
			if (_instance)
			{
				throw new Error("this is the singleton, has created, and cannot create again!");
			}
			_stage = stage;
			initContainer();
			_instance = this;
		}

		private function initContainer() : void
		{
			if (_stage)
			{
				_sceneContainer = new Sprite();
				_mainContainer = new Sprite();
				_panelContainer = new Sprite();
				_popContainer = new Sprite();
				_alertContainer = new Sprite();

				_stage.addChild(_sceneContainer);
				_stage.addChild(_mainContainer);
				_stage.addChild(_panelContainer);
				_stage.addChild(_popContainer);
				_stage.addChild(_alertContainer);
//
//				var width : Number = Global.STANDARD_WIDTH * Global.stageScale;
//				var height : Number = Global.STANDARD_HEIGHT * Global.stageScale;
//				var newx : Number = (Global.stageWidth - width) * 0.5;
//				var newy : Number = (Global.stageHeight - height) * 0.5;
//
//				_sceneContainer.x = _mainContainer.x = _panelContainer.x = _popContainer.x = _alertContainer.x = newx;
//				_sceneContainer.y = _mainContainer.y = _panelContainer.y = _popContainer.y = _alertContainer.y = newy;
//
//				_sceneContainer.scaleX = _mainContainer.scaleX = _panelContainer.scaleX = _popContainer.scaleX = _alertContainer.scaleX = Global.stageScale;
//				_sceneContainer.scaleY = _mainContainer.scaleY = _panelContainer.scaleY = _popContainer.scaleY = _alertContainer.scaleY = Global.stageScale;
//				
				UISceneManager.contaier = _sceneContainer;
				UIMainManager.contaier = _mainContainer;
				UIPanelManager.container = _panelContainer;
				UIPopManager.container = _popContainer;
			}

		}



	}

}
