package app.chapter_05
{
	import code.SpriteBase;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	
	/**
	 * 说明：MicrophoneTest
	 * @author victor
	 * 2012-8-5 上午9:31:50
	 */
	
	public class MicrophoneTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _mic:Microphone;
		private var _bmp:BitmapData;
		
		public function MicrophoneTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			
			_bmp = new BitmapData(400,50,false,0xffffff);
			var bitMap:Bitmap = new Bitmap(_bmp);
			bitMap.x = (this.stage.stageWidth - bitMap.width) * 0.5;
			bitMap.y = (this.stage.stageHeight- bitMap.height)* 0.5;
			addChild(bitMap);
			
			_mic = Microphone.getMicrophone();
			trace("MicrophoneTest.name",_mic.name);
			_mic.setLoopBack(true);
			Security.showSettings(SecurityPanel.MICROPHONE);
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			trace("MicrophoneTest.activityLevel",_mic.activityLevel);
			_bmp.setPixel32(298, 50 - _mic.activityLevel * 0.5, 0);
			_bmp.scroll(-1, 0);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}