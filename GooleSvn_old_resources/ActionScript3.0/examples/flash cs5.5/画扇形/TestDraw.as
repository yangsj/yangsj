package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Shape;
	import net.vyky.utils.VGraphics;

	public class TestDraw extends Sprite
	{
		public function TestDraw()
		{
			var stag:Sprite=new Sprite();
			stag.graphics.lineStyle(1);
			stag.graphics.drawRect(1,1,stage.stageWidth - 2, stage.stageHeight - 2);
			stag.graphics.endFill();
			addChild(stag);
			var moviec:Shape = new Shape()  ;
			stag.addChild(moviec);
			moviec.x = 200;
			moviec.y = 200;
			var S_angle:int = -360;
			this.addEventListener(Event.ENTER_FRAME, enterHandler);
			
			function enterHandler(event:Event):void
			{
				if (S_angle >= 361)
				{
					//return;
				}
			VGraphics.drawSector(moviec, 0, 0, 100, S_angle, 270);
				S_angle++;
				if (S_angle == 0) S_angle = -360;
				trace(S_angle);
			}
		}

		//
		private function draw(mc:MovieClip, x:Number=200, y:Number=200, r:Number=100, angle:Number=27, startFrom:Number=0, color:Number=0xff0000):void
		{
			mc.graphics.clear();
			mc.graphics.beginFill(color);
			mc.graphics.moveTo(x, y);
			angle=(Math.abs(angle) > 360) ? 360 : angle;
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number = angle / n;
			angleA = angleA * Math.PI / 180;
			startFrom = startFrom * Math.PI / 180;
			mc.graphics.lineTo(x + r * Math.cos(startFrom), y + r * Math.sin(startFrom));
			for (var i=1; i <= n; i++)
			{
				startFrom +=  angleA;
				var angleMid = startFrom - angleA / 2;
				var bx=x + r / Math.cos(angleA / 2) * Math.cos(angleMid);
				var by=y + r / Math.cos(angleA / 2) * Math.sin(angleMid);
				var cx = x + r * Math.cos(startFrom);
				var cy = y + r * Math.sin(startFrom);
				mc.graphics.curveTo(bx, by, cx, cy);
			}
			if (angle != 360)
			{
				mc.graphics.lineTo(x, y);
			}
			mc.graphics.endFill();
		}
	}
}