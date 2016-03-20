package app.chapter_02
{
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 说明：SeekTest
	 * @author victor
	 * 2012-4-10 下午11:52:28
	 */
	
	public class SeekTest extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _vehicle:SteeredVehicle;
		
		public function SeekTest()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function addedToStageHandler(e:Event):void
		{
			init();
		}
		
		private function init():void
		{
			_vehicle = new SteeredVehicle();
			addChild(_vehicle);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			_vehicle.seek(new Vector2D(mouseX, mouseY));
			_vehicle.update();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}