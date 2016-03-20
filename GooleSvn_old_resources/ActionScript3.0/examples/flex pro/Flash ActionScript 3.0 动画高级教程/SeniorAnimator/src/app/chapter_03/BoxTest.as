package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.DrawnIsoBox;
	import code.chapter_03.DrawnIsoTile;
	import code.chapter_03.IsoUtils;
	import code.chapter_03.Point3D;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	/**
	 * 说明：BoxTest
	 * @author victor
	 * 2012-7-13 上午01:21:04
	 */
	
	public class BoxTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var world:Sprite;
		
		public function BoxTest()
		{
			super();
		}
		
		override protected function initialization():void
		{
			world = new Sprite();
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
			
			world.addEventListener(MouseEvent.CLICK, onWorldClickHandler);
		}
		
		private function onWorldClickHandler(e:MouseEvent):void
		{
			var box:DrawnIsoBox = new DrawnIsoBox(20, Math.random() * 0xffffff, 20);
			var pos:Point3D = IsoUtils.screenToIso(new Point(world.mouseX, world.mouseY));
			pos.x = Math.round(pos.x / 20) * 20;
			pos.y = Math.round(pos.y / 20) * 20;
			pos.z = Math.round(pos.z / 20) * 20;
			box.position = pos;
			world.addChild(box);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}