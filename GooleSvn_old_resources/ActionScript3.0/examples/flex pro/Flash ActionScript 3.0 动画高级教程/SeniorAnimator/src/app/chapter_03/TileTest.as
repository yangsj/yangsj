package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.DrawnIsoTile;
	import code.chapter_03.Point3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	
	/**
	 * 说明：TileTest
	 * @author victor
	 * 2012-7-13 上午12:22:32
	 */
	
	public class TileTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function TileTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			var world:Sprite = new Sprite();
			world.x = stage.stageWidth * 0.5;
			world.y = 100;
			addChild(world);
			
			var leng:int = 20;
			for (var i:int = 0; i < leng; i++)
			{
				for (var j:int = 0; j < leng; j++)
				{
					var tile:DrawnIsoTile = new DrawnIsoTile(20, 0xcccccc);
					tile.position = new Point3D(i * 20, 0, j * 20);
					world.addChild(tile);
				}
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}