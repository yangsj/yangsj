package victor.view
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import ui.components.UITimeView;
	
	import victor.GameStage;
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
		private var timer:Timer;
		private var uiSkin:UITimeView;
		private var barWidth:Number = 0;

		private var _completeCallBackFunction:Function;


		public function TimeClockComp()
		{
			uiSkin = new UITimeView();
			addChild( uiSkin );

			bgImg = uiSkin.bgImg;
			barImg = uiSkin.barImg;
			txtTime = uiSkin.txtTime;
			mcTimeWord = uiSkin.mcTimeWord;
			
			GameStage.adjustXYScaleXYForTarget(uiSkin);

			barWidth = barImg.width;

			x = 50;
			y = 15;
			
			GameStage.adjustXY(this);
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
			txtTime.text = 60 + "";
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
			timer ||= new Timer( 1000, 60 );
			timer.addEventListener( TimerEvent.TIMER, timerHandler );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, completeHandler );
			timer.reset();
			timer.start();
		}

		protected function completeHandler( event:TimerEvent ):void
		{
			stopTimer();
			safetyCall( _completeCallBackFunction );
		}

		protected function timerHandler( event:TimerEvent ):void
		{
			var currentCount:int = timer.currentCount;
			var repeatCount:int = timer.repeatCount;
			var leftCount:int = repeatCount - currentCount;
			var per:Number = currentCount / repeatCount;
			barImg.width = per * barWidth;
			txtTime.text = leftCount + "";
		}

		/**
		 * 倒计时结束时回调
		 */
		public function set completeCallBackFunction(value:Function):void
		{
			_completeCallBackFunction = value;
		}


	}
}
