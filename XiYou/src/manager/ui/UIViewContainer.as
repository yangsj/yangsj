package manager.ui
{

	import flash.display.Sprite;
	import flash.display.Stage;

	import global.Global;


	/**
	 * 说明：UIViewContainer
	 * @author Victor
	 * 2012-9-29
	 */

	public class UIViewContainer
	{
		private var _stage : Stage;

		/** 场景图层0 */
		private var _sceneContainer : Sprite;
		/** 主视图层1 */
		private var _mainContainer : Sprite;
		/** 导航菜单层2 */
		private var _naviContainer : Sprite;
		/** 面板图层3 */
		private var _panelContainer : Sprite;
		/** pop 显示图层4 */
		private var _popContainer : Sprite;
		/** 提示 图层5 */
		private var _alertContainer : Sprite;

		/** 容器 */
		private var _container : Sprite;
		/** 容器遮罩 */
		private var _containerMask : Sprite;

		private static var _instance : UIViewContainer;

		public static function get instance() : UIViewContainer
		{
			if ( _instance == null )
				throw new Error( "please create MainContainerView" );
			return _instance;
		}

		public function UIViewContainer( stage : Stage )
		{
			if ( _instance )
			{
				throw new Error( "this is the singleton, has created, and cannot create again!" );
			}
			_stage = stage;
			initContainer();
			_instance = this;
		}

		private function initContainer() : void
		{
			if ( _stage )
			{
				createObjectWithStageSize();

				_container = new Sprite();
				_containerMask = new Sprite();
				_sceneContainer = new Sprite();
				_mainContainer = new Sprite();
				_naviContainer = new Sprite();
				_panelContainer = new Sprite();
				_popContainer = new Sprite();
				_alertContainer = new Sprite();

				_stage.addChild( _container );
				_stage.addChild( _containerMask );
				_container.addChild( _sceneContainer );
				_container.addChild( _mainContainer );
				_container.addChild( _naviContainer );
				_container.addChild( _panelContainer );
				_container.addChild( _popContainer );
				_container.addChild( _alertContainer );

				var width : Number = Global.standardWidth * Global.stageScale;
				var height : Number = Global.standardHeight * Global.stageScale;
				var newx : Number = ( Global.stageWidth - width ) * 0.5;
				var newy : Number = ( Global.stageHeight - height ) * 0.5;

				_container.x = _containerMask.x = newx;
				_container.y = _containerMask.y = newy;
				_container.scaleX = _containerMask.scaleX = Global.stageScale;
				_container.scaleY = _containerMask.scaleY = Global.stageScale;

//				_sceneContainer.x = _mainContainer.x = _panelContainer.x = _popContainer.x = _alertContainer.x = newx;
//				_sceneContainer.y = _mainContainer.y = _panelContainer.y = _popContainer.y = _alertContainer.y = newy;
//
//				_sceneContainer.scaleX = _mainContainer.scaleX = _panelContainer.scaleX = _popContainer.scaleX = _alertContainer.scaleX = Global.stageScale;
//				_sceneContainer.scaleY = _mainContainer.scaleY = _panelContainer.scaleY = _popContainer.scaleY = _alertContainer.scaleY = Global.stageScale;

				UISceneManager.container = _sceneContainer;
				UIMainManager.container = _mainContainer;
				UINaviManager.container = _naviContainer;
				UIPanelManager.container = _panelContainer;
				UIPopManager.container = _popContainer;
				UIAlertManager.container = _alertContainer;

				createContainerMask();
			}

		}

		private function createObjectWithStageSize() : void
		{
			var blackColor : Sprite = new Sprite();
			blackColor.graphics.beginFill( 0x000000 );
			blackColor.graphics.drawRect( 0, 0, Global.stageWidth, Global.stageHeight );
			blackColor.graphics.endFill();
			_stage.addChild( blackColor );
		}

		private function createContainerMask() : void
		{
			_containerMask.graphics.beginFill( 0x000000 );
			_containerMask.graphics.drawRect( 0, 0, Global.standardWidth, Global.standardHeight );
			_containerMask.graphics.endFill();
			_container.mask = _containerMask;
		}



	}

}
