package app.chapter_02
{
	import code.SpriteBase;
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	import code.chapter_02.Vehicle;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：FleeTest
	 * @author victor
	 * 2012-4-11 上午12:03:20
	 */
	
	public class FleeTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _vehicle:SteeredVehicle;
		
		public function FleeTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_vehicle = new SteeredVehicle();
			_vehicle.position = new Vector2D(200, 200);
			_vehicle.edgeBehavior = Vehicle.BOUNCE;
			addChild(_vehicle);
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_vehicle.flee(new Vector2D(mouseX, mouseY));
			_vehicle.update();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}