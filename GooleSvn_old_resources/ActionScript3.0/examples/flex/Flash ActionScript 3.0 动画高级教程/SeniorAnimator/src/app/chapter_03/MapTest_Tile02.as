package app.chapter_03
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	
	/**
	 * 说明：MapTest_Tile02
	 * @author victor
	 * 2012-7-15 上午11:18:51
	 */
	
	public class MapTest_Tile02 extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		[Embed(source="assets/chapter_3/tile_02.png")]
		private var Tile02:Class;
		
		public function MapTest_Tile02()
		{
			super();
			addChild(new Tile02() as DisplayObject);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}