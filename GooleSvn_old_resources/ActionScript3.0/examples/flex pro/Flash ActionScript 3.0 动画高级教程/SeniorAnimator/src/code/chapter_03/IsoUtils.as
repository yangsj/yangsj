package code.chapter_03
{
	import flash.geom.Point;
	
	/**
	 * 说明：IsoUtils
	 * @author victor
	 * 2012-7-12 下午11:36:13
	 */
	
	public class IsoUtils
	{
		
		////////////////// vars /////////////////////////////////
		
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		
		public static function isoToScreen(pos:Point3D):Point
		{
			var screenX:Number = pos.x - pos.z;
			var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) * 0.5;
			return new Point(screenX, screenY);
		}
		
		public static function screenToIso(point:Point):Point3D
		{
			var xpos:Number = point.y + point.x * 0.5;
			var ypos:Number = 0;
			var zpos:Number = point.y - point.x * 0.5;
			return new Point3D(xpos, ypos, zpos);
		}
		
		public function IsoUtils()
		{
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}