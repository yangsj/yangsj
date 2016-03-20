package app.chapter_02
{
	import code.SpriteBase;
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	import code.chapter_02.Vehicle;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：SeekFleeTest2
	 * @author victor
	 * 2012-4-11 上午12:21:01
	 */
	
	public class SeekFleeTest2 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _vehicleA:SteeredVehicle;
		private var _vehicleB:SteeredVehicle;
		private var _vehicleC:SteeredVehicle;
		
		public function SeekFleeTest2()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_vehicleA = new SteeredVehicle();
			_vehicleA.position = new Vector2D(200,200);
			_vehicleA.edgeBehavior = Vehicle.BOUNCE;
			this.addChild(_vehicleA);
			
			_vehicleB = new SteeredVehicle();
			_vehicleB.position = new Vector2D(400,200);
			_vehicleB.edgeBehavior = Vehicle.BOUNCE;
			this.addChild(_vehicleB);
			
			_vehicleC = new SteeredVehicle();
			_vehicleC.position = new Vector2D(300,260);
			_vehicleC.edgeBehavior = Vehicle.BOUNCE;
			this.addChild(_vehicleC);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_vehicleA.seek(_vehicleB.position);
			_vehicleA.flee(_vehicleC.position);
			
			_vehicleB.seek(_vehicleC.position);
			_vehicleB.flee(_vehicleA.position);
			
			_vehicleC.seek(_vehicleA.position);
			_vehicleC.flee(_vehicleB.position);
			
			_vehicleA.update();
			_vehicleB.update();
			_vehicleC.update();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}