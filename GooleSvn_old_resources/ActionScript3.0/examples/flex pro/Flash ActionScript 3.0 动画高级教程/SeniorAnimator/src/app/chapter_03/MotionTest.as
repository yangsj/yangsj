package app.chapter_03
{
	import code.SpriteBase;
	import code.chapter_03.DrawnIsoBox;
	import code.chapter_03.DrawnIsoTile;
	import code.chapter_03.IsoWorld;
	import code.chapter_03.Point3D;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
	/**
	 * 说明：MotionTest
	 * @author victor
	 * 2012-7-14 下午09:02:18
	 */
	
	public class MotionTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var world:IsoWorld;
		private var box:DrawnIsoBox;
		private var speed:int = 20;
		
		public function MotionTest()
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
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP,   onKeyUpHandler);
		}
		
		private function onKeyDownHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.UP:
					box.vx = -speed;
					break;
				case Keyboard.DOWN:
					box.vx = speed;
					break;
				case Keyboard.LEFT:
					box.vz = speed;
					break;
				case Keyboard.RIGHT:
					box.vz = -speed;
					break;
			}
			this.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onKeyUpHandler(e:KeyboardEvent):void
		{
			box.vx = 0;
			box.vz = 0;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void
		{
			box.x += box.vx;
			box.y += box.vy;
			box.z += box.vz;
			world.sort();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}