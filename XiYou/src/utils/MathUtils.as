package utils
{
	import flash.geom.Point;

	/**
	 * 一些数学工具类
	 * @author Chenzhe
	 */
	public class MathUtils
	{
		/**
		 * 求a与b的距离
		 * @param ax
		 * @param ay
		 * @param bx
		 * @param by
		 * @return 两点间的距离
		 */
		public static function distance(ax : Number, ay : Number, bx : Number, by : Number) : Number
		{
			return Math.sqrt((ax - bx) * (ax - bx) + (ay - by) * (ay - by));
		}

		public static function chop(val : Number, min : Number, max : Number) : Number
		{
			if (val < min)
				return min;
			if (val > max)
				return max;
			return val;
		}

		// public static function angle2D(ax : Number, ay : Number, bx : Number, by : Number, toDegree : Boolean = false) : Number
		// {
		// var angr : Number = Math.acos((ax * bx + ay * by) / (Math.sqrt(ax * ax + ay * ay) * Math.sqrt(bx * bx + by * by)));
		// return toDegree ? angr * 180 / Math.PI : angr;
		// }
		public static function anglePt(ax : Number, ay : Number, bx : Number, by : Number) : Number
		{
			ax = bx - ax;
			ay = by - ay;
			bx = 1;
			by = 0;
			var angr : Number = Math.acos((ax * bx + ay * by) / (Math.sqrt(ax * ax + ay * ay) * Math.sqrt(bx * bx + by * by))) * 180 / Math.PI;

			if (by > ay)
				angr = -angr;
			if (ax < 0)
				angr += 180;
			return angr;
		}

		public static function middlePt(a : Point, b : Point) : Point
		{
			return new Point((a.x + b.x) * .5, (a.y + b.y) * .5);
		}

		public static function randomInRange(min : Number, max : Number) : Number
		{
			return min + (max - min) * Math.random();
		}
	}
}
