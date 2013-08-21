package app.module.main.view
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import app.AppStage;
	import app.EffectControl;
	import app.core.Alert;
	import app.core.Image;
	import app.data.LevelConfig;
	import app.data.LevelVo;
	import app.manager.LocalStoreManager;
	import app.manager.SoundManager;
	import app.module.AppUrl;
	import app.module.LocalStoreNameKey;
	import app.module.main.events.MainEvent;
	import app.module.main.view.child.LogicComp;
	import app.module.main.view.child.MenuComp;
	import app.utils.DisplayUtil;
	
	import framework.BaseScene;

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
		private var isRunning:Boolean = true;

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

			timeClockComp.addEventListener( MainEvent.CTRL_TIME, ctrlTimeHandler );
		}
		
		public function backMenu():void
		{
			timeClockComp.stopTimer();
			Alert.showAlert("", "你确定要返回吗？", "确定", exit, "继续", timeClockComp.ctrlTime);
		}

		protected function initialize():void
		{
			NativeApplication.nativeApplication.addEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.addEventListener( Event.DEACTIVATE, deactivateHandler );

			if ( timeClockComp )
				timeClockComp.resetScore();

			readyGo();
		}

		protected function deactivateHandler( event:Event ):void
		{
			isRunning = timeClockComp.isRunning;
			isStopLast10Second = SoundManager.isPlayLast10Second;

			if ( isRunning )
				timeClockComp.ctrlTime();

			if ( isStopLast10Second )
				SoundManager.stopLast10Second();
		}

		protected function activateHandler( event:Event ):void
		{
			if ( isRunning )
				timeClockComp.ctrlTime();

			if ( isStopLast10Second )
				SoundManager.resetLast10Second();
		}

		protected function ctrlTimeHandler( event:MainEvent ):void
		{
			if ( gameLogicComp )
				gameLogicComp.mouseChildren = ( Boolean( event.data ));
		}

		protected function addScoreHandler( event:MainEvent ):void
		{
			if ( timeClockComp )
				timeClockComp.addScore( int( event.data ));
		}

		protected function dispelSuccessHandler( event:MainEvent ):void
		{
			SoundManager.playSoundWin();
			
			EffectControl.instance.playAccessEffect( abc );

			if ( timeClockComp )
				timeClockComp.stopTimer();
			
			SoundManager.stopLast10Second();
			
			function abc():void
			{
				var message:String = curLevel >= LevelConfig.maxLevel - 1 ? "恭喜！通过所有关卡" : "恭喜！挑战成功";
				Alert.showAlert( "恭喜", message, "菜单", exit, "下一关", def );
			}
			function def():void
			{
				curLevel++;
				readyGo();
			}
		}

		protected function addTimeHandler( event:MainEvent ):void
		{
			if ( timeClockComp )
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

			if ( bgImage == null )
			{
				bgImage = new Image( AppUrl.getBgUrl( int( Math.random() * 10 )), onCompleteLoaded );
				addChildAt( bgImage, 0 );
			}
			else
				bgImage.reset( AppUrl.getBgUrl( int( Math.random() * 10 )), onCompleteLoaded );

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
			EffectControl.instance.playTimeup( abc );
			SoundManager.playSoundLose();
			
			function abc():void
			{
				Alert.showAlert( "再接再厉", "您本次挑战失败！再接再厉", "菜单", exit, "再来一次", readyGo );
			}
		}

		private function exit():void
		{
			DisplayUtil.removedFromParent( this );
			NativeApplication.nativeApplication.removeEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.removeEventListener( Event.DEACTIVATE, deactivateHandler );
			
			var arr:Array = LocalStoreManager.getData( LocalStoreNameKey.RANK_LIST ) as Array;
			arr ||= [];
			arr.push( [timeClockComp.totalScore, new Date().time]);
			arr.sort( sortAryFun );
			arr.splice(Math.min(arr.length, 10), Math.max(arr.length - 10, 0));
			
			LocalStoreManager.setData( LocalStoreNameKey.RANK_LIST, arr );
			
			function sortAryFun(ary1:Array, ary2:Array):Number
			{
				var a:int = ary1[0];
				var b:int = ary2[0];
				if ( a > b )
					return -1;
				else if ( a < b )
					return 1;
				return 0;
			}
			
			curLevel = 1;
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
