package net.vyky.utils
{

	import flash.display.DisplayObject;
	import flash.display.Shape;


	/**
	 * 说明：VMath
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-10-18
	 */

	public class VGraphics
	{


		public function VGraphics()
		{
		}

		/**
		 * 画一个扇形状
		 * @param dis  可以是一个Shape类型
		 * @param x 指定扇形的起始点x值
		 * @param y 指定扇形的起始点y值
		 * @param r 指定扇形的半径 （radius）
		 * @param angle 指定扇形的角度
		 * @param startFrom 指定扇形的开始的位置
		 * @param color 指定一个填充的颜色
		 *
		 */
		public static function drawSector(dis : Shape, x : Number = 0, y : Number = 0, radius : Number = 100, angle : Number = 45, startFrom : Number = 0, color : Number = 0xff0000) : void
		{
			dis.graphics.clear();
			dis.graphics.beginFill(color);
			dis.graphics.moveTo(x, y);
			angle = (Math.abs(angle) > 360) ? 360 : angle;
			var n : Number = Math.ceil(Math.abs(angle) / 45);
			var angleA : Number = angle / n;
			angleA = angleA * Math.PI / 180;
			startFrom = startFrom * Math.PI / 180;
			dis.graphics.lineTo(x + radius * Math.cos(startFrom), y + radius * Math.sin(startFrom));
			for (var i:int = 1; i <= n; i++)
			{
				startFrom += angleA;
				var angleMid:Number = startFrom - angleA / 2;
				var bx:Number = x + radius / Math.cos(angleA / 2) * Math.cos(angleMid);
				var by:Number = y + radius / Math.cos(angleA / 2) * Math.sin(angleMid);
				var cx:Number = x + radius * Math.cos(startFrom);
				var cy:Number = y + radius * Math.sin(startFrom);
				dis.graphics.curveTo(bx, by, cx, cy);
			}
			if (angle != 360)
			{
				dis.graphics.lineTo(x, y);
			}
			dis.graphics.endFill();
		}

		////////////// public functions //////////////



		////////////// override functions //////////////



		////////////// private functions //////////////



		////////////// events functions handle/////////



		////////////// getter/setter //////////////////

	}

}
