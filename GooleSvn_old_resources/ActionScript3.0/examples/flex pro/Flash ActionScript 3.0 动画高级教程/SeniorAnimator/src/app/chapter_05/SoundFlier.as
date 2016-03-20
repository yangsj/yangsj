package app.chapter_05
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.Microphone;
	
	
	/**
	 * 说明：SoundFlier
	 * @author victor
	 * 2012-8-5 上午9:47:31
	 */
	
	public class SoundFlier extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _mic:Microphone;
		private var _flier:Sprite;
		private var _bg:Bitmap;
		private var _yVelocity:Number = 0;
		
		public function SoundFlier()
		{
			super();
		}
		
		override protected function initialization():void
		{
			makeBackground();
			makeFlier();
			trace(stage.stageWidth, stage.stageHeight, _flier.y);
			_mic = Microphone.getMicrophone();
			_mic.setLoopBack(true);
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
//			trace("activityLevel:", _mic.activityLevel );
			
			_yVelocity += 0.4;
			_yVelocity -= _mic.activityLevel * 0.05;
			_flier.y += _yVelocity;
			_yVelocity *= 0.9;
			_flier.y = Math.min(_flier.y, stage.stageHeight - 20);
			_flier.y = Math.min(_flier.y, 20);
			
			var h:Number = Math.random() * 120;
			_bg.bitmapData.fillRect(new Rectangle(stage.stageWidth - 20, 0, 5, h), 0xcccccc);
			h = Math.random() * 120;
			_bg.bitmapData.fillRect(new Rectangle(stage.stageWidth - 20, stage.stageHeight - h, 5, h), 0xcccccc);
			_bg.bitmapData.scroll(-5, 0);
		}
		
		private function makeFlier():void
		{
			_flier = new Sprite();
			_flier.graphics.lineStyle(0);
			_flier.graphics.moveTo(-10, 0);
			_flier.graphics.lineTo(-10, -8);
			_flier.graphics.lineTo(-7, -4);
			_flier.graphics.lineTo(10, 0);
			_flier.graphics.lineTo(-10, 0);
			_flier.x = 100;
			_flier.y = stage.stageHeight - 50;
			addChild(_flier);
		}
		
		private function makeBackground():void
		{
			var bmp:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false);
			_bg = new Bitmap(bmp);
			addChild(_bg);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}