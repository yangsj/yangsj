package victor.view.scenes.game.logic
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import ui.components.UIAddScore100;
	import ui.components.UITimeView;
	
	import victor.GameStage;
	import victor.utils.NumberUtil;
	import victor.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class TimeClockComp extends Sprite
	{

		private var bgImg:Sprite;
		private var barImg:Sprite;
		private var mcTimeWord:Sprite;
		private var txtTime:TextField;
		private var txtScore:TextField;
		private var mcScoreWord:Sprite;

		private var timer:Timer;
		private var uiSkin:UITimeView;
		private var barWidth:Number = 0;

		private var _completeCallBackFunction:Function;

		public var baseTimeSec:int = 60;
		private var endResultScore:Array;
		private var startResultScore:Array;

		public function TimeClockComp()
		{
			uiSkin = new UITimeView();
			addChild( uiSkin );

			bgImg = uiSkin.bgImg;
			barImg = uiSkin.barImg;
			mcTimeWord = uiSkin.mcTimeWord;
			mcScoreWord = uiSkin.mcScroeWord;
			txtTime = uiSkin.mcTimeValue.txtTimeValue;
			txtScore = uiSkin.mcScoreValue.txtScoreValue;

			GameStage.adjustXYScaleXYForTarget( uiSkin );

			barWidth = barImg.width;

			x = 50;
			y = 15;

			GameStage.adjustXY( this );
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

		public function initialize():void
		{
			barImg.width = 1;
			txtTime.text = baseTimeSec + "";
			txtScore.text = "0";
			endResultScore = [ 0 ];
		}

		public function stopTimer():void
		{
			if ( timer )
			{
				timer.stop();
			}
		}

		public function startTimer():void
		{
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
			}
		}

		public function addScore( score:int ):void
		{
			startResultScore = [ endResultScore[ 0 ]];
			endResultScore = [ endResultScore[ 0 ] + score ];
			setTweenMcScoreEffect( score );
		}

		private function setTweenMcScoreEffect( score:int ):void
		{
			var num:Sprite = NumberUtil.createNumSprite(score);
			var mc:Sprite = new UIAddScore100();
			num.width = num.width * mc.height / num.height;
			num.height = mc.height;
			num.x = -num.width >> 1;
			num.y = -num.height >> 1;
			mc.x = startPoint.x;
			mc.y = startPoint.y;
			mc.removeChildren();
			mc.addChild(num);
			GameStage.stage.addChild( mc );
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
			txtScore.text = int( startResultScore[ 0 ]) + "";
		}

		private function onCompleteScore():void
		{
			txtScore.text = int( endResultScore[ 0 ]) + "";
		}

		protected function completeHandler( event:TimerEvent ):void
		{
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
			txtTime.text = leftCount + "";
		}

		private function get startPoint():Point
		{
			return new Point( GameStage.stage.mouseX, GameStage.stage.mouseY );
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

	}
}
