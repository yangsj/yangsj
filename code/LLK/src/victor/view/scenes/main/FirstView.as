package victor.view.scenes.main
{
	import flash.display.Sprite;

	import victor.GameStage;
	import victor.components.Button;
	import victor.core.Image;
	import victor.URL;
	import victor.view.scenes.game.GameLogicView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class FirstView extends Sprite
	{
		private var btnEnterGame:Button;
		private var btnHistoryRank:Button;
		private var btnGameHelp:Button;

		private var bgImg:Image;

		private var gameLogicView:GameLogicView;

		public function FirstView()
		{
			this.graphics.beginFill(0);
			this.graphics.drawRect(0,0,GameStage.stageWidth, GameStage.stageHeight);
			this.graphics.endFill();
			
			bgImg = new Image( URL.getBgUrl( "a" ), onCompleteLoaded );
			addChild( bgImg );

			btnEnterGame = new Button( "开始游戏", btnEnterGameHandler );
			btnEnterGame.x = 320;
			btnEnterGame.y = 380;
			addChild( btnEnterGame );

			btnHistoryRank = new Button( "历史排行", btnHistoryRankHandler );
			btnHistoryRank.x = 320;
			btnHistoryRank.y = 520;
			addChild( btnHistoryRank );

			btnGameHelp = new Button( "游戏帮助", btnGameHelpHandler );
			btnGameHelp.x = 320;
			btnGameHelp.y = 660;
			addChild( btnGameHelp );

			GameStage.adjustXYScaleXY( btnEnterGame );
			GameStage.adjustXYScaleXY( btnHistoryRank );
			GameStage.adjustXYScaleXY( btnGameHelp );
		}

		private function onCompleteLoaded( img:Image ):void
		{
//			GameStage.bgToStretch(img);
			GameStage.bgToEqualRatio( img );
		}

		private function btnGameHelpHandler():void
		{

		}

		private function btnHistoryRankHandler():void
		{

		}

		private function btnEnterGameHandler():void
		{
			gameLogicView ||= new GameLogicView();
			addChild( gameLogicView );
			gameLogicView.initialize();
		}
	}
}
