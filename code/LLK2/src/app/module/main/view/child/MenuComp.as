package app.module.main.view.child
{
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;

	import app.AppStage;
	import app.manager.SoundManager;
	import app.data.LevelVo;
	import app.module.main.events.MainEvent;
	import app.utils.DisplayUtil;
	import app.utils.NumberUtil;
	import app.utils.safetyCall;

	import ui.components.UIAddScore100;
	import ui.components.UITimeView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class MenuComp extends Sprite
	{

		private var bgImg:Sprite;
		private var barImg:Sprite;
		private var mcTimeWord:Sprite;
		private var txtTime:TextField;
		private var txtScore:TextField;
		private var mcScoreWord:Sprite;
		private var btnMc:MovieClip;

		private var timer:Timer;
		private var uiSkin:UITimeView;
		private var barWidth:Number = 0;

		private var _completeCallBackFunction:Function;

		private var baseTimeSec:int = 60;
		private var endResultScore:Array;
		private var startResultScore:Array;

		private var lvSprite:Sprite;
		private var isPlay:Boolean = false;
		private var isTimeup:Boolean = false;

		private var numTimeSprite:Sprite;
		private var numScoreSprite:Sprite;


		public function MenuComp()
		{
			uiSkin = new UITimeView();
			addChild( uiSkin );

			bgImg = uiSkin.bgImg;
			barImg = uiSkin.barImg;
			btnMc = uiSkin.btnMc;
			mcTimeWord = uiSkin.mcTimeWord;
			mcScoreWord = uiSkin.mcScroeWord;
			txtTime = uiSkin.mcTimeValue.txtTimeValue;
			txtScore = uiSkin.mcScoreValue.txtScoreValue;

			AppStage.adjustXYScaleXYForTarget( uiSkin );

			ctrlTime();

			btnMc.addEventListener( MouseEvent.CLICK, btnMcClickHandler );
			btnMc.buttonMode = true;
			btnMc.mouseChildren = false;

			barWidth = barImg.width;

			x = 30;
			y = 15;

			AppStage.adjustXY( this );

			txtScore.visible = false;
			txtTime.visible = false;
		}

		public function dispose():void
		{
			if ( timer )
			{
				timer.stop();
				timer.removeEventListener( TimerEvent.TIMER, timerHandler );
				timer.removeEventListener( TimerEvent.TIMER_COMPLETE, completeHandler );
				timer = null;
			}
			bgImg = null;
			barImg = null;
			txtTime = null;
			mcTimeWord = null;

			_completeCallBackFunction = null;
		}

		public function resetScore():void
		{
			isTimeup = false;
			createNumScoreSprite( 0 );
			endResultScore = [ 0 ];
		}

		public function initialize():void
		{
			barImg.width = 1;
			createNumTimeSprite( baseTimeSec );
		}

		public function stopTimer():void
		{
			if ( timer )
			{
				if ( timer.running == false )
					return;
				timer.stop();
			}
			isPlay = false;
			ctrlTime();
		}

		public function startTimer():void
		{
			isTimeup = false;
			isPlay = true;
			ctrlTime();
			timer ||= new Timer( 1000 );
			timer.addEventListener( TimerEvent.TIMER, timerHandler );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, completeHandler );
			timer.repeatCount = baseTimeSec;
			timer.reset();
			timer.start();
		}

		public function addTime( sec:int ):void
		{
			if ( timer )
			{
				timer.repeatCount += sec;
				if ( SoundManager.isPlayLast10Second )
				{
					var addSec:int = timer.repeatCount - baseTimeSec;
					var currentCount:int = timer.currentCount - addSec;
					var repeatCount:int = timer.repeatCount - addSec;
					var leftCount:int = repeatCount - currentCount;
					SoundManager.stopLast10Second();
					if ( leftCount <= 10 )
					{
						SoundManager.playLast10Second(( 10 - leftCount ) / 10 );
					}
				}
			}
		}

		public function setLevelVo( levelVo:LevelVo ):void
		{
			baseTimeSec = levelVo.limitTime;
			if ( lvSprite && lvSprite.parent )
				lvSprite.parent.removeChild( lvSprite );
			lvSprite = NumberUtil.createNumSprite( "L" + levelVo.level );
			lvSprite.width = lvSprite.width * mcScoreWord.height / lvSprite.height;
			lvSprite.height = mcScoreWord.height;
			lvSprite.x = mcScoreWord.x - lvSprite.width - 40;
			lvSprite.y = mcScoreWord.y;
			mcScoreWord.parent.addChild( lvSprite );
		}

		public function addScore( score:int ):void
		{
			startResultScore = [ endResultScore[ 0 ]];
			endResultScore = [ endResultScore[ 0 ] + score ];
			setTweenMcScoreEffect( score );
		}

		public function ctrlTime():void
		{
			if ( isPlay )
			{
				btnMc.gotoAndStop( "play" );
				dispatchEvent( new MainEvent( MainEvent.CTRL_TIME, 1 ));
			}
			else
			{
				btnMc.gotoAndStop( "stop" );
				dispatchEvent( new MainEvent( MainEvent.CTRL_TIME, 0 ));
			}
			if ( timer )
			{
				if ( isPlay )
				{
					timer.start();
				}
				else
				{
					timer.stop();
					SoundManager.stopLast10Second();
				}
			}
			isPlay = !isPlay;
		}

		protected function btnMcClickHandler( event:MouseEvent ):void
		{
			ctrlTime();
			if ( timer )
			{
				if ( timer.repeatCount - timer.currentCount <= 10 )
				{
					if ( isPlay )
					{
						SoundManager.resetLast10Second();
					}
					else
					{
						SoundManager.stopLast10Second();
					}
				}
			}
			SoundManager.playClickButton();
		}

		protected function completeHandler( event:TimerEvent ):void
		{
			isTimeup = true;
			stopTimer();
			safetyCall( _completeCallBackFunction );
		}

		protected function timerHandler( event:TimerEvent ):void
		{
			var addSec:int = timer.repeatCount - baseTimeSec;
			var currentCount:int = timer.currentCount - addSec;
			var repeatCount:int = timer.repeatCount - addSec;
			var leftCount:int = repeatCount - currentCount;
			var per:Number = currentCount / repeatCount;
			barImg.width = per * barWidth;
			createNumTimeSprite( leftCount );
			if ( leftCount <= 10 )
			{
				if ( leftCount == 0 )
				{
					SoundManager.playTimeEnd();
				}
				else
				{
					if ( SoundManager.isPlayLast10Second == false )
					{
						SoundManager.playLast10Second( 0 );
					}
				}
			}
			else
			{
				if ( SoundManager.isPlayLast10Second )
				{
					SoundManager.stopLast10Second();
				}
			}
		}

		private function setTweenMcScoreEffect( score:int ):void
		{
			var num:Sprite = NumberUtil.createNumSprite( score );
			var mc:Sprite = new UIAddScore100();
			num.width = num.width * mc.height / num.height;
			num.height = mc.height;
			num.x = -num.width >> 1;
			num.y = -num.height >> 1;
			mc.x = startPoint.x;
			mc.y = startPoint.y;
			mc.removeChildren();
			mc.addChild( num );
			AppStage.stage.addChild( mc );
			TweenMax.to( mc, 1, { x: endPoint.x, y: endPoint.y, scaleX: 0.1, scaleY: 0.1, onComplete: addScoreTween, onCompleteParams: [ mc ]});
		}

		private function addScoreTween( mc:DisplayObject ):void
		{
			if ( mc && mc.parent )
				mc.parent.removeChild( mc );
			TweenMax.killTweensOf( startResultScore );
			TweenMax.to( startResultScore, 0.5, { endArray: endResultScore, onUpdate: onUpdateScore, onComplete: onCompleteScore });
		}

		private function onUpdateScore():void
		{
			createNumScoreSprite( startResultScore[ 0 ]);
		}

		private function onCompleteScore():void
		{
			createNumScoreSprite( endResultScore[ 0 ]);
		}

		private function createNumTimeSprite( num:int ):void
		{
//			txtTime.text = num + "";
			DisplayUtil.removedFromParent( numTimeSprite );
			numTimeSprite = NumberUtil.createNumSprite( num );
			numTimeSprite.width = numTimeSprite.width * mcTimeWord.height / numTimeSprite.height;
			numTimeSprite.height = mcTimeWord.height;
			numTimeSprite.x = bgImg.x + ( bgImg.width - numTimeSprite.width ) >> 1;
			numTimeSprite.y = mcTimeWord.y;
			barImg.parent.addChild( numTimeSprite );
		}

		private function createNumScoreSprite( num:int ):void
		{
//			txtScore.text = num + "";			
			DisplayUtil.removedFromParent( numScoreSprite );
			numScoreSprite = NumberUtil.createNumSprite( num );
			numScoreSprite.width = numScoreSprite.width * mcScoreWord.height / numScoreSprite.height;
			numScoreSprite.height = mcScoreWord.height;
			numScoreSprite.x = mcScoreWord.x + mcScoreWord.width + 20;
			numScoreSprite.y = mcScoreWord.y;
			barImg.parent.addChild( numScoreSprite );
		}

		private function get startPoint():Point
		{
			return new Point( AppStage.stage.mouseX, AppStage.stage.mouseY );
		}

		private function get endPoint():Point
		{
			return txtScore.localToGlobal( new Point( 20, txtScore.height * 0.5 ));
		}

		/**
		 * 倒计时结束时回调
		 */
		public function set completeCallBackFunction( value:Function ):void
		{
			_completeCallBackFunction = value;
		}

		public function get totalScore():int
		{
			return endResultScore[ 0 ];
		}

		public function get isRunning():Boolean
		{
			return isTimeup ? false : timer.running;
		}



	}
}
