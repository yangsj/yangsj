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
	 * 说明：DepthTest2
	 * @author victor
	 * 2012-7-14 上午12:53:46
	 */
	
	public class DepthTest2 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var world:Sprite;
		private var objectList:Array;
		private var listOne:Array;
		
		public function DepthTest2()
		{
			super();
		}
		
		override protected function initialization():void
		{
			world = new Sprite();
			world.x = stage.stageWidth * 0.5;
			world.y = 100;
			addChild(world);
			
			objectList = new Array();
			listOne = new Array();
			
			var leng:int = 20;
			for (var i:int = 0; i < leng; i++)
			{
				for (var j:int = 0; j < leng; j++)
				{
					var tile:DrawnIsoTile = new DrawnIsoTile(20, 0xccccccc);
					tile.position = new Point3D(i * 20, 0.1, j * 20);
					world.addChild(tile);
					listOne.push(tile);
				}
			}
			sortList();
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
			objectList.push(box);
			sortList();
			box.mouseEnabled = box.mouseChildren = false;
		}
		
		private function sortList():void
		{
			objectList.sortOn("depth", Array.NUMERIC);
			var leng:int = objectList.length;
			var leng2:int = listOne.length;
			for (var i:int = 0; i < leng; i++)
			{
				world.setChildIndex(objectList[i], leng2 + i);
			}
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}