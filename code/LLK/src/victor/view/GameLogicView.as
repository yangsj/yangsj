package victor.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	import ui.components.UIReadyGoAnimation;
	import ui.components.UITimeupAnimation;

	import victor.GameStage;
	import victor.core.Image;
	import victor.utils.MovieClipUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class GameLogicView extends Sprite
	{
		private var gameLogicComp:GameLogicComp;
		private var timeClockComp:TimeClockComp;

		private var bgImage:Image;

		public function GameLogicView()
		{
			gameLogicComp = new GameLogicComp();
			addChild( gameLogicComp );
			gameLogicComp.mouseEnabled = false;

			timeClockComp = new TimeClockComp();
			timeClockComp.completeCallBackFunction = timeCompleteFun;
			addChild( timeClockComp );
		}

		public function initialize():void
		{
			gameLogicComp.initialize();
			timeClockComp.initialize();
			readyGo();
			gameLogicComp.startAndReset();
		}

		/**
		 * 开始准备
		 */
		private function readyGo():void
		{
			var mc:MovieClip = new UIReadyGoAnimation();
			mc.x = 640 >> 1;
			mc.y = 960 >> 1;
			addChild( mc );
			MovieClipUtil.playMovieClip( mc, complete );
			function complete():void
			{
				mc.parent.removeChild( mc );
				timeClockComp.startTimer();
			}
			if ( bgImage && bgImage.parent )
				bgImage.parent.removeChild( bgImage );

			bgImage = new Image( URL.getBgUrl( 0 ), onCompleteLoaded );
			addChildAt( bgImage, 0 );
		}

		private function onCompleteLoaded( img:Image ):void
		{
			GameStage.bgToEqualRatio( img );
		}

		/**
		 * 时间到
		 */
		private function timeCompleteFun():void
		{
//			gameLogicComp.mouseChildren = false;
			var mc:MovieClip = new UITimeupAnimation();
			mc.x = 640 >> 1;
			mc.y = 960 >> 1;
			addChild( mc );
			MovieClipUtil.playMovieClip( mc, complete );
			function complete():void
			{
				mc.parent.removeChild( mc );
				exit();
			}
		}

		private function exit():void
		{
			if ( parent )
				parent.removeChild( this );
		}

	}
}
