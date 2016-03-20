package app.chapter_02
{
	import code.chapter_02.Vector2D;
	import code.chapter_02.Vehicle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 说明：VehicleTest
	 * @author victor
	 * 2012-4-10 上午01:11:14
	 */
	
	public class VehicleTest extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _vehilce:Vehicle;
		
		public function VehicleTest()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		private function addedToStageHandler(e:Event):void
		{		
			_vehilce = new Vehicle();
			addChild(_vehilce);
			
			_vehilce.position = new Vector2D(100, 100);
			_vehilce.velocity.length = 5;
			_vehilce.velocity.angle = Math.PI / 4;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			_vehilce.update();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}