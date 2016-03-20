package app.chapter_02
{
	import code.SpriteBase;
	import code.chapter_02.SteeredVehicle;
	import code.chapter_02.Vector2D;
	import code.chapter_02.Vehicle;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：PursueTest
	 * @author victor
	 * 2012-4-12 上午12:41:02
	 */
	
	public class PursueTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _seeker:SteeredVehicle;
		private var _pursuer:SteeredVehicle;
		private var _target:Vehicle;
		
		public function PursueTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			_seeker = new SteeredVehicle();
			_seeker.x = 400;
			this.addChild(_seeker);
			
			_pursuer = new SteeredVehicle();
			_pursuer.x = 400;
			this.addChild(_pursuer);
				
			_target = new Vehicle();
			_target.position = new Vector2D(200,200);
			_target.velocity.length = 15;
			this.addChild(_target);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_seeker.seek(_target.position);
			_seeker.update();
			
			_pursuer.pursue(_target);
			_pursuer.update();
			
			_target.update();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}