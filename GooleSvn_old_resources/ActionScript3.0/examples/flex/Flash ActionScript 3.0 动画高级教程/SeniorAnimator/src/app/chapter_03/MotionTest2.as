package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.DrawnIsoBox;
	import code.chapter_03.DrawnIsoTile;
	import code.chapter_03.IsoWorld;
	import code.chapter_03.Point3D;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	
	
	/**
	 * 说明：MotionTest2
	 * @author victor
	 * 2012-7-14 下午10:13:52
	 */
	
	public class MotionTest2 extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var world:IsoWorld;
		private var box:DrawnIsoBox;
		private var shadow:DrawnIsoTile;
		private var gravity:Number = 2;
		private var friction:Number = 0.95;
		private var bounce:Number = -0.9;
		private var filter:BlurFilter;
		
		public function MotionTest2()
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
					var tile:DrawnIsoTile = new DrawnIsoTile(leng, 0xcccccc);
					tile.position = new Point3D(i * leng, 0, j * leng);
					world.addChildToFloor(tile);
				}
			}
			
			box = new DrawnIsoBox(leng, 0xff0000, leng);
			box.x = 200;
			box.z = 200;
			world.addChildToWorld(box);
			
			shadow = new DrawnIsoTile(leng, 0);
			shadow.alpha = 0.5;
			world.addChildToFloor(shadow);
			
			filter = new BlurFilter();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			stage.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void
		{
			box.vy += 2;
			box.x += box.vx;
			box.y += box.vy;
			box.z += box.vz;
			if (box.x > 380)
			{
				box.x = 380;
				box.vy *= -0.8;
			}
			else if (box.x < 0)
			{
				box.x = 0;
				box.vy *= bounce;
			}
			else if (box.z > 380)
			{
				box.z = 380;
				box.vz *= bounce;
			}
			else if (box.z < 0)
			{
				box.z = 0;
				box.vz *= bounce;
			}
			else if (box.y > 0)
			{
				box.y = 0;
				box.vy *= bounce;
			}
			box.vx *= friction;
			box.vy *= friction;
			box.vz *= friction;
			
			shadow.x = box.x;
			shadow.z = box.z;
			filter.blurX = filter.blurY = -box.y * 0.25;
			shadow.filters = [filter];
			
			world.sort();
		}
		
		private function onClickHandler(e:MouseEvent):void
		{
			box.vx = Math.random() * 20 - 10;
			box.vy = -Math.random() * 40;
			box.vz = Math.random() * 20 - 10;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}