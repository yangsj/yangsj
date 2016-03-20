package app.chapter_03
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	
	/**
	 * 说明：MapTest_Tile01
	 * @author victor
	 * 2012-7-15 上午11:17:57
	 */
	
	public class MapTest_Tile01 extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="assets/chapter_3/tile_01.png")]
		private var Tile01:Class;
		
		public function MapTest_Tile01()
		{
			super();
			addChild(new Tile01() as DisplayObject);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}