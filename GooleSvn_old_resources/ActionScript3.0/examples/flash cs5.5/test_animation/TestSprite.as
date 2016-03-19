package 
{
	import flash.display.Sprite;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class TestSprite extends Sprite
	{
		private var arr:Array;
		private var index:int = 0;
		private var leng:int;
		private var bitmap:Bitmap;
		
		public function TestSprite()
		{
			bitmap = new Bitmap();
			this.addChild(bitmap as DisplayObject);
			arr = [new test0001(), new test0002(), new test0003(), new test0004(), new test0005(), new test0006(), new test0007(), new test0008(), new test0009()];
			leng = arr.length;
			var timer:Timer = new Timer(1000/24);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			while (this.numChildren > 0) this.removeChildAt(0);
			bitmap.bitmapData = arr[index] as BitmapData;
			this.addChild(bitmap as DisplayObject);
			index ++;
			if  (index >= leng) index = 0;
		}

	}

}