package app.chapter_03
{	
	import code.SpriteBase;
	import code.chapter_03.IsoUtils;
	import code.chapter_03.Point3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	
	
	/**
	 * 说明：IsoTransFormTest
	 * @author victor
	 * 2012-7-12 下午11:44:25
	 */
	
	public class IsoTransFormTest extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function IsoTransFormTest()
		{
			super();
		}
		
		override protected function initialization():void
		{	
			var p0:Point3D = new Point3D(0,0,0);
			var p1:Point3D = new Point3D(100,0,0);
			var p2:Point3D = new Point3D(100,0,100);
			var p3:Point3D = new Point3D(0,0,100);
			
			var sp0:Point = IsoUtils.isoToScreen(p0);
			var sp1:Point = IsoUtils.isoToScreen(p1);
			var sp2:Point = IsoUtils.isoToScreen(p2);
			var sp3:Point = IsoUtils.isoToScreen(p3);
			
			var tile:Sprite = new Sprite();
			tile.x = 200;
			tile.y = 200;
			addChild(tile);
			
			tile.graphics.lineStyle(0, 0xff0000);
			tile.graphics.moveTo(sp0.x, sp0.y);
			tile.graphics.lineTo(sp1.x, sp1.y);
			tile.graphics.lineTo(sp2.x, sp2.y);
			tile.graphics.lineTo(sp3.x, sp3.y);
			tile.graphics.lineTo(sp0.x, sp0.y);
			
			trace(tile.width, tile.height, IsoUtils.Y_CORRECT);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}