package app.module.menu.view
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import framework.BaseScene;
	
	import app.AppStage;
	import app.module.AppUrl;
	import app.core.Alert;
	import app.core.Image;
	import app.core.SoundManager;
	import app.core.components.Button;
	import app.module.menu.events.MenuEvent;
	
	[Event(name="click_menu_start", type="app.module.menu.events.MenuEvent")]
	[Event(name="click_menu_help", type="app.module.menu.events.MenuEvent")]
	[Event(name="click_menu_rank", type="app.module.menu.events.MenuEvent")]
	[Event(name="click_menu_exit", type="app.module.menu.events.MenuEvent")]


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MenuView extends BaseScene
	{
		private var btnEnterGame:Button;
		private var btnHistoryRank:Button;
		private var btnGameHelp:Button;
		private var btnExitGame:Button;

		private var bgImg:Image;

		public function MenuView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();

			bgImg = new Image( AppUrl.getBgUrl( "a" ), onCompleteLoaded );
			addChild( bgImg );

			btnEnterGame = new Button( "开始游戏", btnEnterGameHandler );
			btnEnterGame.x = 320;
			btnEnterGame.y = 320;
			addChild( btnEnterGame );

			btnHistoryRank = new Button( "历史排行", btnHistoryRankHandler );
			btnHistoryRank.x = 320;
			btnHistoryRank.y = 450;
			addChild( btnHistoryRank );

			btnGameHelp = new Button( "游戏帮助", btnGameHelpHandler );
			btnGameHelp.x = 320;
			btnGameHelp.y = 580;
			addChild( btnGameHelp );

			btnExitGame = new Button( "退出游戏", btnExitGameHandler );
			btnExitGame.x = 320;
			btnExitGame.y = 710;
			addChild( btnExitGame );

			AppStage.adjustXYScaleXY( btnEnterGame );
			AppStage.adjustXYScaleXY( btnHistoryRank );
			AppStage.adjustXYScaleXY( btnGameHelp );
			AppStage.adjustXYScaleXY( btnExitGame );

			SoundManager.playBgMusic();
			NativeApplication.nativeApplication.addEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.addEventListener( Event.DEACTIVATE, deactivateHandler );
		}

		protected function deactivateHandler( event:Event ):void
		{
			SoundManager.stopBgMusic();
		}

		protected function activateHandler( event:Event ):void
		{
			SoundManager.playBgMusic();
		}

		private function onCompleteLoaded( img:Image ):void
		{
			AppStage.bgToEqualRatio( img );
		}

		private function btnExitGameHandler():void
		{
			Alert.show( "你确定要退出游戏吗？", NativeApplication.nativeApplication.exit );
		}

		private function btnGameHelpHandler():void
		{
			dispatchEvent( new MenuEvent(MenuEvent.CLICK_MENU_HELP));
		}

		private function btnHistoryRankHandler():void
		{
			dispatchEvent( new MenuEvent(MenuEvent.CLICK_MENU_RANK));
		}

		private function btnEnterGameHandler():void
		{
			dispatchEvent( new MenuEvent(MenuEvent.CLICK_MENU_START));
		}

	}
}
