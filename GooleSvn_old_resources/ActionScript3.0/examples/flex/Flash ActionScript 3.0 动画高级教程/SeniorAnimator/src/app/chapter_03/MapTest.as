package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.IsoWorld;
	import code.chapter_03.MapLoader;
	
	import flash.events.Event;
	
	
	/**
	 * 说明：MapTest
	 * @author victor
	 * 2012-7-15 上午12:56:47
	 */
	
	public class MapTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _world:IsoWorld;
		private var _floor:IsoWorld;
		private var mapLoader:MapLoader;
		private var tile01:MapTest_Tile01;
		private var tile02:MapTest_Tile02;
		
		public function MapTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			mapLoader = new MapLoader();
			mapLoader.addEventListener(Event.COMPLETE, onMapCompleted);
			mapLoader.loadMap("assets/chapter_3/map.txt");
		}
		
		private function onMapCompleted(e:Event):void
		{
			_world = mapLoader.makeWorld(20);
			_world.x = 1092 * 0.5;
			_world.y = 100;
			this.addChild(_world);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}