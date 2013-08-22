package app.module.menu.view
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;

	import app.AppStage;
	import app.core.Alert;
	import app.core.Image;
	import app.core.components.Button;
	import app.module.AppUrl;
	import app.module.menu.events.MenuEvent;

	import framework.BaseScene;

	[Event( name = "click_menu_start", type = "app.module.menu.events.MenuEvent" )]
	[Event( name = "click_menu_help", type = "app.module.menu.events.MenuEvent" )]
	[Event( name = "click_menu_rank", type = "app.module.menu.events.MenuEvent" )]
	[Event( name = "click_menu_setting", type = "app.module.menu.events.MenuEvent" )]
	[Event( name = "click_menu_exit", type = "app.module.menu.events.MenuEvent" )]


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
		private var btnSetting:Button;
		private var container:Sprite;

		private var bgImg:Image;

		public function MenuView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();

			container = new Sprite();

			bgImg = new Image( AppUrl.getBgUrl( "a" ), onCompleteLoaded );
			addChild( bgImg );

			btnEnterGame = new Button( "开始游戏", btnEnterGameHandler );
			container.addChild( btnEnterGame );

			btnHistoryRank = new Button( "历史排行", btnHistoryRankHandler );
			container.addChild( btnHistoryRank );

			btnGameHelp = new Button( "游戏帮助", btnGameHelpHandler );
			container.addChild( btnGameHelp );

			btnSetting = new Button( "系统设置", btnSettingHandler );
			container.addChild( btnSetting );

			btnExitGame = new Button( "退出游戏", btnExitGameHandler );
			container.addChild( btnExitGame );

			btnEnterGame.y = 0;
			btnHistoryRank.y = 130;
			btnGameHelp.y = 260;
			btnSetting.y = 390;
			btnExitGame.y = 520;

			AppStage.adjustXYScaleXY( btnEnterGame );
			AppStage.adjustXYScaleXY( btnHistoryRank );
			AppStage.adjustXYScaleXY( btnGameHelp );
			AppStage.adjustXYScaleXY( btnSetting );
			AppStage.adjustXYScaleXY( btnExitGame );

			addChild( container );

			container.x = AppStage.stageWidth >> 1;
			container.y = ( AppStage.stageHeight - container.height ) >> 1;
		}

		private function onCompleteLoaded( img:Image ):void
		{
			AppStage.bgToEqualRatio( img );
		}

		private function btnExitGameHandler():void
		{
			Alert.showAlert( "退出游戏", "你确定要退出游戏吗？", "确定", NativeApplication.nativeApplication.exit, "取消" );
		}

		private function btnGameHelpHandler():void
		{
			dispatchEvent( new MenuEvent( MenuEvent.CLICK_MENU_HELP ));
		}

		private function btnHistoryRankHandler():void
		{
			dispatchEvent( new MenuEvent( MenuEvent.CLICK_MENU_RANK ));
		}

		private function btnSettingHandler():void
		{
			dispatchEvent( new MenuEvent( MenuEvent.CLICK_MENU_SETTING ));
		}

		private function btnEnterGameHandler():void
		{
			dispatchEvent( new MenuEvent( MenuEvent.CLICK_MENU_START ));
		}

	}
}
