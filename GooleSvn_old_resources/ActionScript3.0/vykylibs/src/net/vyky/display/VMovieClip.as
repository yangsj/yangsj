package net.vyky.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	
	/**
	 * 说明：VMovieClip
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-21
	 */
	
	public class VMovieClip extends Sprite
	{
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		private var xml:XML;
		private var fps:int = 24;
		private var bitmapArray:Vector.<DisplayObject>;
		private var timer:Timer;
		private var currentFrame:int = 0;
		private var totalFrame:int = 0;
		
		public function VMovieClip($bitmapData:BitmapData, $xml:XML, $fps:int = 24)
		{
			bitmapData = $bitmapData;
			xml = $xml;
			fps = $fps;
			bitmapArray = new Vector.<DisplayObject>();
			createResourceArray();
			refresh();
		}
		
		private function createResourceArray():void
		{
			var xmlList:XMLList = xml.children();
			var xl:XML;
			var matrix:Matrix = new Matrix();
			for each (xl in xmlList)
			{
				var b_x:Number = Number(xl.@x);
				var b_y:Number = Number(xl.@y);
				var b_w:Number = Number(xl.@width);
				var b_h:Number = Number(xl.@height);
				
				var bm:Bitmap = new Bitmap();
				var bmd:BitmapData = new BitmapData(b_w, b_h, true, 0);
				
				matrix.tx = -b_x;
				matrix.ty = -b_y;
				
				bmd.draw(bitmapData, matrix);
				bm.bitmapData = bmd;
				
				bitmapArray.push(bm);
			}
			totalFrame = bitmapArray.length;
		}
		
		////////////// public functions //////////////
		
		public function play():void
		{
			if (timer == null)
			{
				timer = new Timer(50);
			}
			if (timer.hasEventListener(TimerEvent.TIMER) == false)
			{
				timer.addEventListener(TimerEvent.TIMER, timerHandler);
			}
			timer.delay = 1000 / fps;
			timer.start();
		}
		
		public function stop():void
		{
			if (timer)
			{
				timer.stop();
			}
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			refresh();
		}
		
		private function refresh():void
		{
			while (this.numChildren > 0) this.removeChildAt(0);
			var dis:DisplayObject = bitmapArray[currentFrame] as DisplayObject;
			this.addChild(dis);
			
			currentFrame++;
			
			if (currentFrame >= totalFrame)
			{
				currentFrame = 0;
			}
		}
		
		////////////// override functions //////////////
		
		
		
		////////////// private functions //////////////
		
		
		
		////////////// events functions handle/////////
		
		
		
		////////////// getter/setter //////////////////
		
	}
	
}