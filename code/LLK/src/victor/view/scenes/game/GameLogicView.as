package victor.view.scenes.game
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import ui.components.UILevelNextArrow;
	import ui.components.UILevelNextWord;
	import ui.components.UIReadyGoAnimation;
	import ui.components.UITimeupAnimation;
	
	import victor.GameStage;
	import victor.URL;
	import victor.core.Image;
	import victor.core.SoundManager;
	import victor.data.LevelConfig;
	import victor.data.LevelVo;
	import victor.utils.DisplayUtil;
	import victor.utils.MovieClipUtil;
	import victor.view.EffectPlayCenter;
	import victor.view.events.GameEvent;
	import victor.view.scenes.game.logic.GameLogicComp;
	import victor.view.scenes.game.logic.TimeClockComp;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class GameLogicView extends Sprite
	{
		private var gameLogicComp:GameLogicComp;
		private var timeClockComp:TimeClockComp;

		private var isStopLast10Second:Boolean = false;

		private var bgImage:Image;

		private var curLevel:int = 1;

		public function GameLogicView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, GameStage.stageWidth, GameStage.stageHeight );
			this.graphics.endFill();

			gameLogicComp = new GameLogicComp();
			addChild( gameLogicComp );
			gameLogicComp.mouseEnabled = false;

			timeClockComp = new TimeClockComp();
			timeClockComp.completeCallBackFunction = timeCompleteFun;
			addChild( timeClockComp );
		}

		public function initialize():void
		{
			timeClockComp.resetScore();

			readyGo();

			gameLogicComp.addEventListener( GameEvent.ADD_TIME, addTimeHandler );
			gameLogicComp.addEventListener( GameEvent.DISPEL_SUCCESS, dispelSuccessHandler );
			gameLogicComp.addEventListener( GameEvent.ADD_SCORE, addScoreHandler );

			timeClockComp.addEventListener( GameEvent.CTRL_TIME, ctrlTimeHandler );

			NativeApplication.nativeApplication.addEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.addEventListener( Event.DEACTIVATE, deactivateHandler );
		}

		protected function deactivateHandler( event:Event ):void
		{
			timeClockComp.ctrlTime();
			isStopLast10Second = SoundManager.isPlayLast10Second;
			if ( isStopLast10Second )
				SoundManager.stopLast10Second();
		}

		protected function activateHandler( event:Event ):void
		{
			timeClockComp.ctrlTime();
			if ( isStopLast10Second )
				SoundManager.resetLast10Second();
			isStopLast10Second = false;
		}

		protected function ctrlTimeHandler( event:GameEvent ):void
		{
			gameLogicComp.mouseChildren = ( Boolean( event.data ));
		}

		protected function addScoreHandler( event:GameEvent ):void
		{
			timeClockComp.addScore( int( event.data ));
		}

		protected function dispelSuccessHandler( event:GameEvent ):void
		{
			var mc1:MovieClip = new UILevelNextArrow();
			mc1.x = GameStage.stageWidth >> 1;
			mc1.y = GameStage.stageHeight >> 1;
			addChild( mc1 );
			GameStage.adjustScaleXY( mc1 );
			MovieClipUtil.playMovieClip( mc1, complete );
			function complete():void
			{
				if ( mc1 && mc1.parent )
					mc1.parent.removeChild( mc1 );
			}
			var mc2:MovieClip = new UILevelNextWord();
			mc2.x = GameStage.stageWidth >> 1;
			mc2.y = GameStage.stageHeight >> 1;
			addChild( mc2 );
			GameStage.adjustScaleXY( mc2 );
			MovieClipUtil.playMovieClip( mc2, complete2 );

			timeClockComp.stopTimer();
			
			SoundManager.stopLast10Second();

			curLevel++;
			function complete2():void
			{
				if ( mc2 && mc2.parent )
					mc2.parent.removeChild( mc2 );
				readyGo();
			}
		}

		protected function addTimeHandler( event:GameEvent ):void
		{
			timeClockComp.addTime( int( event.data ));
		}

		/**
		 * 开始准备
		 */
		private function readyGo():void
		{
			if ( curLevel >= LevelConfig.maxLevel )
			{
				curLevel = 1;
				EffectPlayCenter.instance.playSuccessAccessAllGuanQia();
			}
			var levelVo:LevelVo = LevelConfig.getCurLevelVo( curLevel );
			timeClockComp.setLevelVo( levelVo );
			gameLogicComp.initialize();
			timeClockComp.initialize();
			gameLogicComp.startAndReset( levelVo );

			EffectPlayCenter.instance.playReadyGo( timeClockComp.startTimer );

			if ( bgImage )
			{
				DisplayUtil.removedFromParent( bgImage );
				bgImage.dispose();
			}

			bgImage = new Image( URL.getBgUrl( int( Math.random() * 10 )), onCompleteLoaded );
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
			gameLogicComp.mouseChildren = false;
			EffectPlayCenter.instance.playTimeup( exit );
		}

		private function exit():void
		{
			if ( parent )
				parent.removeChild( this );

			NativeApplication.nativeApplication.removeEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.removeEventListener( Event.DEACTIVATE, deactivateHandler );
		}

	}
}
