package app.module.main.view.child
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;

	import app.module.main.DirectionType;


	/**
	 * ……
	 * @author yangsj
	 */
	public class DrawDirectionIcon extends Sprite
	{
		private const COLOR:uint = 0xFF9900;
		private const ALPHA:Number = 0.8;

		public function DrawDirectionIcon()
		{
			super();
			scaleX = 0.3;
			scaleY = 0.3;
		}

		public function setDirection( direction:uint ):void
		{
			removeChildren();

			switch ( direction )
			{
				case DirectionType.DEFAULT:
					drawDefault();
					break;

				case DirectionType.DOWN:
					drawArrow( 180 );
					break;
				case DirectionType.UP:
					drawArrow( 0 );
					break;
				case DirectionType.LEFT:
					drawArrow( 270 );
					break;
				case DirectionType.RIGHT:
					drawArrow( 90 );
					break;

				case DirectionType.downAndUp:
					drawTwoDirction( 0, -1 );
					break;
				case DirectionType.leftAndRight:
					drawTwoDirction( 90, -1 );
					break;
				case DirectionType.upAndDown:
					drawTwoDirction( 0, 1 );
					break;
				case DirectionType.rightAndLeft:
					drawTwoDirction( 90, 1 );
					break;

				case DirectionType.byLeftMoveDown:
					drawDirectionAndLineArrow( 0, 1, 1 );
					break;
				case DirectionType.byLeftMoveUp:
					drawDirectionAndLineArrow( 0, -1, 1 );
					break;
				case DirectionType.byRightMoveDown:
					drawDirectionAndLineArrow( 0, 1, -1 );
					break;
				case DirectionType.byRightMoveUp:
					drawDirectionAndLineArrow( 0, -1, -1 );
					break;
				case DirectionType.byUpMoveLeft:
					drawDirectionAndLineArrow( 90, 1, 1 );
					break;
				case DirectionType.byUpMoveRight:
					drawDirectionAndLineArrow( 90, -1, 1 );
					break;
				case DirectionType.byDownMoveLeft:
					drawDirectionAndLineArrow( 90, 1, -1 );
					break;
				case DirectionType.byDownMoveRight:
					drawDirectionAndLineArrow( 90, -1, -1 );
					break;

				case DirectionType.moveDownLeft:
					drawArrow( 225 );
					break;
				case DirectionType.moveDownRight:
					drawArrow( 135 );
					break;
				case DirectionType.moveUpLeft:
					drawArrow( 315 );
					break;
				case DirectionType.moveUpRight:
					drawArrow( 45 );
					break;

//				case DirectionType.byCenterFromUpAndDown:
//					
//					break;
//				case DirectionType.byCenterFromLeftAndRight:
//					
//					break;
				case DirectionType.byCenterFromLeftAndRightAndUpAndDown:
					drawCenterCenter();
					break;
				case DirectionType.byCenterFromUpAndDownThenMoveLeft:
					drawCenterMove( 270 );
					break;
				case DirectionType.byCenterFromUpAndDownThenMoveRight:
					drawCenterMove( 90 );
					break;
				case DirectionType.byCenterFromLeftAndRightThenMoveDown:
					drawCenterMove( 180 );
					break;
				case DirectionType.byCenterFromLeftAndRightThenMoveUp:
					drawCenterMove( 0 );
					break;
			}
		}

		private function drawDefault():void
		{
//			var shape:Shape = new Shape();
//			shape.graphics.lineStyle( 15, COLOR, ALPHA);
//			shape.graphics.moveTo( -50, -50 );
//			shape.graphics.lineTo( 50, 50 );
//			shape.graphics.moveTo( 50, -50 );
//			shape.graphics.lineTo( -50, 50 );
//			
//			addChild( shape );
		}

		/**
		 * up:0°
		 * right:90°
		 * down:180°
		 * left:270°
		 */
		private function drawArrow( angle:Number ):DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( COLOR, ALPHA );
			shape.graphics.moveTo( 0, -120 );
			shape.graphics.lineTo( -75, -20 );
			shape.graphics.lineTo( -40, -20 );
			shape.graphics.lineTo( -40, 120 );
			shape.graphics.lineTo( 40, 120 );
			shape.graphics.lineTo( 40, -20 );
			shape.graphics.lineTo( 75, -20 );
			shape.graphics.lineTo( 0, -120 );
			shape.graphics.endFill();

			shape.height = 150;

			shape.rotation = angle;

			addChild( shape );

			return shape;
		}

		/**
		 * up_down: 0°, scaleY: 1
		 * down_up: 0°, scaleY: -1
		 * right_left: 90°, scaleY: 1
		 * left_right: 90°, scaleY: -1
		 */
		private function drawTwoDirction( angle:int, scaley:int ):DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( COLOR, ALPHA );
			shape.graphics.moveTo( -3, -120 );
			shape.graphics.lineTo( -3, 120 );
			shape.graphics.lineTo( -43, 120 );
			shape.graphics.lineTo( -43, -20 );
			shape.graphics.lineTo( -78, -20 );

			shape.graphics.moveTo( 3, -120 );
			shape.graphics.lineTo( 3, 120 );
			shape.graphics.lineTo( 78, 20 );
			shape.graphics.lineTo( 43, 20 );
			shape.graphics.lineTo( 43, -120 );
			shape.graphics.endFill();

			shape.height = 150;

			shape.rotation = angle;
			shape.scaleY = scaley;

			addChild( shape );

			return shape;
		}

		/**
		 * <code><b>
		 * down_by_left:	0°,	scaleY: 1,	scaleX: 1		<br>
		 * up_by_left:		0°,	scaleY:-1,	scaleX: 1		<br>
		 * down_by_right:	0°,	scaleY: 1,	scaleX:-1		<br>
		 * up_by_right:		0°,	scaleY:-1, 	scaleX:-1		<br>
		 * left_by_up:		90°,scaleY: 1, 	scaleX: 1		<br>
		 * right_by_up:		90°,scaleY:-1, 	scaleX: 1		<br>
		 * left_by_down:	90°,scaleY: 1, 	scaleX:-1		<br>
		 * right_by_down:	90°,scaleY:-1, 	scaleX:-1		<br>
		 */
		private function drawDirectionAndLineArrow( angle:int, scaley:int, scalex:int ):DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill( COLOR, ALPHA );

			shape.graphics.moveTo( -120, 20 );
			shape.graphics.lineTo( -80, 20 );
			shape.graphics.lineTo( -80, -120 );
			shape.graphics.lineTo( -45, -120 );
			shape.graphics.lineTo( -45, 120 );
			shape.graphics.lineTo( -120, 20 );

			shape.graphics.moveTo( -10, 0 );
			shape.graphics.lineTo( 60, -75 );
			shape.graphics.lineTo( 60, -40 );
			shape.graphics.lineTo( 90, -40 );
			shape.graphics.lineTo( 90, -90 );
			shape.graphics.lineTo( 120, -90 );
			shape.graphics.lineTo( 120, 90 );
			shape.graphics.lineTo( 90, 90 );
			shape.graphics.lineTo( 90, 40 );
			shape.graphics.lineTo( 60, 40 );
			shape.graphics.lineTo( 60, 75 );
			shape.graphics.lineTo( -10, 0 );

			shape.rotation = angle;
			shape.scaleX = scalex;
			shape.scaleY = scaley;

			addChild( shape );

			return shape;
		}

		/**
		 * center_up: 0
		 * center_down: 180
		 * center_left: 270
		 * center_right: 90
		 */
		private function drawCenterMove( angle:Number ):DisplayObject
		{
			var sprite:Sprite = new Sprite();

			var shape1:DisplayObject = drawArrow( 45 );
			var shape2:DisplayObject = drawArrow( 315 );

			shape1.x = -shape1.width >> 1;
			shape2.x = shape2.width >> 1;

			sprite.addChild( shape1 );
			sprite.addChild( shape2 );

			sprite.width = 200;

			sprite.rotation = angle;

			addChild( sprite );

			return sprite;
		}

		private function drawCenterCenter():DisplayObject
		{
			var sprite:Sprite = new Sprite();
			var shape1:DisplayObject = drawArrow( 0 );
			var shape2:DisplayObject = drawArrow( 90 );
			var shape3:DisplayObject = drawArrow( 180 );
			var shape4:DisplayObject = drawArrow( 270 );

			shape1.y = ( shape1.height >> 1 ) + 25;
			shape2.x = -( shape2.width >> 1 ) - 25;
			shape3.y = -( shape3.height >> 1 ) - 25;
			shape4.x = ( shape4.width >> 1 ) + 25;

			sprite.addChild( shape1 );
			sprite.addChild( shape2 );
			sprite.addChild( shape3 );
			sprite.addChild( shape4 );

			addChild( sprite );

			var scale:Number = 240 / sprite.width;

			sprite.width *= scale;
			sprite.height *= scale;

			return sprite;
		}

	}
}
