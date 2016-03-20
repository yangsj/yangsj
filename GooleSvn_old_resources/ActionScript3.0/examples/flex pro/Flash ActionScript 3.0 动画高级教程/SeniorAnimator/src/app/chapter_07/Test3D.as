package app.chapter_07
{
	import code.SpriteBase;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	/**
	 * 说明：Test3D
	 * @author victor
	 * 2012-8-19 下午3:08:17
	 */
	
	public class Test3D extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _shape:Shape;
		
		public function Test3D()
		{
			super();
		}
		
		override protected function initialization():void
		{
			root.transform.perspectiveProjection.projectionCenter = new Point(stage.stageWidth * 0.5, stage.stageHeight * 0.5);
			if (_shape == null) 
			{
				_shape = new Shape();
				_shape.graphics.beginFill(0xff0000);
				_shape.graphics.drawRect(-100, -100, 200, 200);
				_shape.graphics.endFill();
			}
			_shape.rotationY = 0;
			_shape.x = this.stage.stageWidth * 0.5;
			_shape.y = this.stage.stageHeight * 0.5;
			this.addChild(_shape);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_shape.rotationY += 2;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}