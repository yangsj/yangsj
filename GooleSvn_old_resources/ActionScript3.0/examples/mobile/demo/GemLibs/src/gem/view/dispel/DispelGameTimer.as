package gem.view.dispel
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * 说明：DiamondsGameTimer
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-7-3
	 */
	
	public class DispelGameTimer
	{
		private var sprite:Sprite;
		private var lastTime:Number;
		private var accumulatedValue:int;

		private var _callBackFunction:Function;
		
		public function DispelGameTimer()
		{
		}
		
		public function start():void
		{
			if (sprite == null)
			{
				sprite = new Sprite();
			}
			lastTime = getTimer();
			sprite.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function pause():void
		{
			if (sprite)
			{
				sprite.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		public function stopAndClear():void
		{
			pause();
			callBackFunction = null;
			sprite = null;
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var nowTime:Number = getTimer();
			if (accumulatedValue >= 1000)
			{
				if (callBackFunction != null) callBackFunction.apply(this);
				accumulatedValue += nowTime - lastTime - 1000;
			}
			else
			{
				accumulatedValue += nowTime - lastTime;
			}
			lastTime = nowTime;
		}
		
		public function get callBackFunction():Function
		{
			return _callBackFunction;
		}
		
		public function set callBackFunction(value:Function):void
		{
			_callBackFunction = value;
		}
		
		
		
	}
	
}