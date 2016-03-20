package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.GraphicTile;
	import code.chapter_03.IsoUtils;
	import code.chapter_03.IsoWorld;
	import code.chapter_03.Point3D;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * 说明：GraphicTest
	 * @author victor
	 * 2012-7-14 下午11:26:53
	 */
	
	public class GraphicTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var world:IsoWorld;
		
		[Embed(source="assets/chapter_3/tile_01.png")]
		private var Tile01:Class;
		
		[Embed(source="assets/chapter_3/tile_02.png")]
		private var Tile02:Class;
		
		public function GraphicTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			world = new IsoWorld();
			world.x = stage.stageWidth * 0.5;
			world.y = 100;
			this.addChild(world);
			
			var leng:int = 20;
			for (var i:int = 0; i < leng; i++)
			{
				for (var j:int = 0; j < leng; j++)
				{
					var tile:GraphicTile = new GraphicTile(leng, Tile01, leng, leng * 0.5);
					tile.position = new Point3D(i * leng, 0, j * leng);
					world.addChildToFloor(tile);
				}
			}
			stage.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			var box:GraphicTile = new GraphicTile(20, Tile02, 20, 10);
			var pos:Point3D = IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			pos.x = Math.round(pos.x / 20) * 20;
			pos.y = Math.round(pos.y / 20) * 20;
			pos.z = Math.round(pos.z / 20) * 20;
			box.position = pos;
			world.addChildToWorld(box);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}