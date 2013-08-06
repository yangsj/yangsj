package app.module.main.view
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import framework.BaseScene;
	
	import app.EffectControl;
	import app.AppStage;
	import app.module.AppUrl;
	import app.core.Alert;
	import app.core.Image;
	import app.core.SoundManager;
	import framework.ViewStruct;
	import app.data.LevelConfig;
	import app.data.LevelVo;
	import app.module.main.events.MainEvent;
	import app.module.main.view.child.LogicComp;
	import app.module.main.view.child.MenuComp;
	import app.utils.DisplayUtil;
	import app.utils.MovieClipUtil;
	
	import ui.components.UILevelNextArrow;
	import ui.components.UILevelNextWord;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MainView extends BaseScene
	{
		private var gameLogicComp:LogicComp;
		private var timeClockComp:MenuComp;

		private var isStopLast10Second:Boolean = false;

		private var bgImage:Image;

		private var curLevel:int = 1;

		private static var _instance:MainView;

		public function MainView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, AppStage.stageWidth, AppStage.stageHeight );
			this.graphics.endFill();

			gameLogicComp = new LogicComp();
			addChild( gameLogicComp );
			gameLogicComp.mouseEnabled = false;

			timeClockComp = new MenuComp();
			timeClockComp.completeCallBackFunction = timeCompleteFun;
			addChild( timeClockComp );

			gameLogicComp.addEventListener( MainEvent.ADD_TIME, addTimeHandler );
			gameLogicComp.addEventListener( MainEvent.DISPEL_SUCCESS, dispelSuccessHandler );
			gameLogicComp.addEventListener( MainEvent.ADD_SCORE, addScoreHandler );
			gameLogicComp.addEventListener( MainEvent.BACK_MENU, backMenuHandler );

			timeClockComp.addEventListener( MainEvent.CTRL_TIME, ctrlTimeHandler );
		}

		protected function initialize():void
		{
			NativeApplication.nativeApplication.addEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.addEventListener( Event.DEACTIVATE, deactivateHandler );

			timeClockComp.resetScore();

			readyGo();
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

		protected function backMenuHandler( event:MainEvent ):void
		{
			timeClockComp.stopTimer();
			Alert.show( "你确定要返回吗？", exit, timeClockComp.ctrlTime );
		}

		protected function ctrlTimeHandler( event:MainEvent ):void
		{
			gameLogicComp.mouseChildren = ( Boolean( event.data ));
		}

		protected function addScoreHandler( event:MainEvent ):void
		{
			timeClockComp.addScore( int( event.data ));
		}

		protected function dispelSuccessHandler( event:MainEvent ):void
		{
			SoundManager.playSoundWin();

			var mc1:MovieClip = new UILevelNextArrow();
			mc1.x = AppStage.stageWidth >> 1;
			mc1.y = AppStage.stageHeight >> 1;
			addChild( mc1 );
			AppStage.adjustScaleXY( mc1 );
			MovieClipUtil.playMovieClip( mc1, complete );
			function complete():void
			{
				if ( mc1 && mc1.parent )
					mc1.parent.removeChild( mc1 );
			}
			var mc2:MovieClip = new UILevelNextWord();
			mc2.x = AppStage.stageWidth >> 1;
			mc2.y = AppStage.stageHeight >> 1;
			addChild( mc2 );
			AppStage.adjustScaleXY( mc2 );
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

		protected function addTimeHandler( event:MainEvent ):void
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
				EffectControl.instance.playSuccessAccessAllGuanQia();
			}
			var levelVo:LevelVo = LevelConfig.getCurLevelVo( curLevel );
			timeClockComp.setLevelVo( levelVo );
			timeClockComp.initialize();
			gameLogicComp.initialize();
			gameLogicComp.startAndReset( levelVo );

			EffectControl.instance.playReadyGo( timeClockComp.startTimer );

			if ( bgImage )
			{
				DisplayUtil.removedFromParent( bgImage );
				bgImage.dispose();
			}

			bgImage = new Image( AppUrl.getBgUrl( int( Math.random() * 10 )), onCompleteLoaded );
			addChildAt( bgImage, 0 );
		}

		private function onCompleteLoaded( img:Image ):void
		{
			AppStage.bgToEqualRatio( img );
		}

		/**
		 * 时间到
		 */
		private function timeCompleteFun():void
		{
			gameLogicComp.mouseChildren = false;
			timeClockComp.stopTimer();
			EffectControl.instance.playTimeup( exit );
			SoundManager.playSoundLose();
		}

		private function exit():void
		{
			DisplayUtil.removedFromParent( this );
			NativeApplication.nativeApplication.removeEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.removeEventListener( Event.DEACTIVATE, deactivateHandler );
		}
		
		override public function show():void
		{
			initialize();
			
			super.show();
		}

		public static function get instance():MainView
		{
			if ( _instance == null )
				_instance = new MainView();
			return _instance;
		}


	}
}
