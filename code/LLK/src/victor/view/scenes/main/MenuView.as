package victor.view.scenes.main
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;

	import victor.GameStage;
	import victor.URL;
	import victor.components.Button;
	import victor.core.Alert;
	import victor.core.Image;
	import victor.core.SoundManager;
	import victor.view.help.HelpView;
	import victor.view.rank.RankView;
	import victor.view.scenes.game.GameLogicView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MenuView extends Sprite
	{
		private var btnEnterGame:Button;
		private var btnHistoryRank:Button;
		private var btnGameHelp:Button;
		private var btnExitGame:Button;

		private var bgImg:Image;

		private static var _instance:MenuView;

		public function MenuView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, GameStage.stageWidth, GameStage.stageHeight );
			this.graphics.endFill();

			bgImg = new Image( URL.getBgUrl( "a" ), onCompleteLoaded );
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

			GameStage.adjustXYScaleXY( btnEnterGame );
			GameStage.adjustXYScaleXY( btnHistoryRank );
			GameStage.adjustXYScaleXY( btnGameHelp );
			GameStage.adjustXYScaleXY( btnExitGame );

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
			GameStage.bgToEqualRatio( img );
		}

		private function btnExitGameHandler():void
		{
			Alert.show( "你确定要退出游戏吗？", NativeApplication.nativeApplication.exit );
		}

		private function btnGameHelpHandler():void
		{
			HelpView.instance.addDisplay();
		}

		private function btnHistoryRankHandler():void
		{
			RankView.instance.addDisplay();
		}

		private function btnEnterGameHandler():void
		{
			GameLogicView.instance.initialize();
		}

		public static function get instance():MenuView
		{
			if ( _instance == null )
				_instance = new MenuView();
			return _instance;
		}

	}
}
