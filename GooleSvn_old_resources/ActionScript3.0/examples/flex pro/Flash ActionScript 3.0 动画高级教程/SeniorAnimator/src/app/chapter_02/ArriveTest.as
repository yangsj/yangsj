package app.chapter_02
{
	import code.SpriteBase;
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：ArriveTest
	 * @author victor
	 * 2012-4-12 上午12:24:15
	 */
	
	public class ArriveTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _vehicle:SteeredVehicle;
		
		public function ArriveTest()
		{
			super();
		}
		
		////////////////// static /////////////////////////////////
		
		override protected function initialization():void
		{
			_vehicle = new SteeredVehicle();
			this.addChild(_vehicle);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_vehicle.arrive(new Vector2D(mouseX, mouseY));
			_vehicle.update();
		}
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}