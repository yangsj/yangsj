package victor.view.scenes.game.logic
{
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-5
	 */
	public class DrawPathLine extends Sprite
	{
		private var points:Vector.<Point>;
		private var pathPos:Array;
		private var shape:Shape;

		public function DrawPathLine()
		{
			shape = new Shape();
			shape.graphics.beginFill(0xff0000);
			shape.graphics.drawTriangles(Vector.<Number>([5,0, -5,-5, -5,5]));
			shape.graphics.endFill();
			addChild(shape);
			shape.visible = false;
		}

		public function setPoints( points:Vector.<Point> ):void
		{
			if ( points && points.length > 1 )
			{
				clearLine();
				var point:Point = points.shift();
				this.points = points;
				this.graphics.clear();
				this.graphics.lineStyle( 5, 0xff0000 );
				this.graphics.moveTo( point.x, point.y );
				pathPos = [ point.x, point.y ];
				draw();
			}
		}

		private function draw():void
		{
			if ( points && points.length > 0 )
			{
				var point:Point = points.shift();
				shape.visible = true;
				shape.x = pathPos[0];
				shape.y = pathPos[1];
				TweenMax.to( pathPos, 0.04, { endArray: [ point.x, point.y ], onUpdate: onUpdateTween, onComplete: onCompleteTween });
			}
			else
			{
				TweenMax.delayedCall( 0.2, clearLine );
				this.graphics.endFill();
			}
		}

		private function onUpdateTween():void
		{
			this.graphics.lineTo( pathPos[ 0 ], pathPos[ 1 ]);
			setShapePointAndDirection();
		}

		private function onCompleteTween():void
		{
			draw();
		}

		private function clearLine():void
		{
			TweenMax.killTweensOf( pathPos );
			TweenMax.killDelayedCallsTo( draw );
			TweenMax.killDelayedCallsTo( clearLine );
			this.graphics.clear();
			shape.visible = false;
		}
		
		private function setShapePointAndDirection():void
		{
			var x0:Number = shape.x;
			var y0:Number = shape.y;
			var x1:Number = pathPos[0];
			var y1:Number = pathPos[1];
			var angle:Number = Math.atan2((y1 - y0) , (x1 - x0));
			var degrees:Number = angle * 180/Math.PI;
			shape.rotation = degrees;
			shape.x = x1;
			shape.y = y1;
		}

	}
}
