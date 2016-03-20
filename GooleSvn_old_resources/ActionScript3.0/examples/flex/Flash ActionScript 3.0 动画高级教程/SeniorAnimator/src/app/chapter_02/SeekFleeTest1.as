package app.chapter_02
{
	import code.SpriteBase;
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	import code.chapter_02.Vehicle;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：SeekFleeTest1
	 * @author victor
	 * 2012-4-11 上午12:10:35
	 */
	
	public class SeekFleeTest1 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _seeker:SteeredVehicle;
		private var _fleer:SteeredVehicle;
		
		public function SeekFleeTest1()
		{
			super();
		}
		
		////////////////// static /////////////////////////////////
		
		override protected function initialization():void
		{
			_seeker = new SteeredVehicle();
			_seeker.position = new Vector2D(200, 200);
			_seeker.edgeBehavior = Vehicle.BOUNCE;
			this.addChild(_seeker);
			
			_fleer = new SteeredVehicle();
			_fleer.position = new Vector2D(400, 300);
			_fleer.edgeBehavior = Vehicle.BOUNCE;
			this.addChild(_fleer);
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_seeker.seek(_fleer.position);
			_fleer.flee(_seeker.position);
			_seeker.update();
			_fleer.update();
		}
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}