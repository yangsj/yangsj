package
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageOrientation;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	import global.Global;

	import manager.LocalStoreManager;
	import manager.ui.UIMainManager;
	import manager.ui.UIPanelManager;
	import manager.ui.UIPopManager;
	import manager.ui.UISceneManager;
	import manager.ui.UIViewContainer;

	import module.status;

	import network.NetworkStatus;
	import network.ServiceManager;

	import newview.navi.MainNaviView;

	import test.TestWebResponder;

	import view.home.MainView;


//	import view.home.MainView;


	/**
	 * 说明：Main
	 * @author Victor
	 * 2012-9-29
	 */

	public class Main extends Sprite
	{

		public function Main()
		{
			if ( stage )
				initialization();
			else
				addEventListener( Event.ADDED_TO_STAGE, initialization );
		}

		protected function initialization( event : Event = null ) : void
		{
			// removed added event
			this.removeEventListener( Event.ADDED_TO_STAGE, initialization );

			// Start network state detector
			NetworkStatus.start();

			// set stage background default color
			stage.color = 0x000000;

			// set some global vars value
			setGlobalVars();

			// initialization the view containers 
			new UIViewContainer( stage );

			// initialization the service manager
			ServiceManager.instance.initialization();

			// some sets for apps
			nativeAppSets();

			// 进入主界面
			initializeMainView();
		}

		private function setGlobalVars() : void
		{
			// set global stage value
			Global.stage = stage;

			// set stage reality size value (width and height)
			if ( Global.isOnDevice )
			{
				// running on device
				if ( stage.deviceOrientation == StageOrientation.ROTATED_LEFT || stage.deviceOrientation == StageOrientation.ROTATED_RIGHT )
				{
					// 横向
					Global.stageWidth = stage.fullScreenHeight > stage.fullScreenWidth ? stage.fullScreenHeight : stage.fullScreenWidth;
					Global.stageHeight = stage.fullScreenHeight < stage.fullScreenWidth ? stage.fullScreenHeight : stage.fullScreenWidth;
				}
				else
				{
					// 纵向
					Global.stageWidth = stage.fullScreenWidth;
					Global.stageHeight = stage.fullScreenHeight;
				}
				// 20121204 Chenzhe 修改 HIGH->MEDIUM : 在移动设备上HIGH还是开销太大
				stage.quality = StageQuality.MEDIUM;
			}
			else
			{
				// running on pc with air run , on pc debugging app
				Global.stageWidth = stage.stageWidth;
				Global.stageHeight = stage.stageHeight;
				stage.quality = StageQuality.BEST;
			}

			// set a global vars uid
			Global.uid = "12";
		}

		private function initializeMainView() : void
		{
//			UIMainManager.addChild(new MainView());
			MainNaviView.instance.show();
		}

		private function nativeAppSets() : void
		{
			// handle the key down
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
		}

		protected function onKeyDownHandler( event : KeyboardEvent ) : void
		{
			var keyCode : uint = event.keyCode;
			switch ( keyCode )
			{
				case Keyboard.HOME:

					break;
				case Keyboard.BACK:

					break;
				case Keyboard.SEARCH:

					break;
			}

		}

	}

}
