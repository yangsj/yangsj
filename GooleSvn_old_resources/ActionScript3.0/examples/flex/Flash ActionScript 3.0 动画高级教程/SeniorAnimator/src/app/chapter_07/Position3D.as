package app.chapter_07
{
	import code.SpriteBase;
	
	import flash.display.Shape;
	import flash.events.Event;
	
	
	/**
	 * 说明：Position3D
	 * @author victor
	 * 2012-8-19 下午3:27:06
	 */
	
	public class Position3D extends SpriteBase
	{
		
		////////////////// vars /////////////////////////////////
		
		private var _shape:Shape;
		private var _n:Number = 0;
		
		public function Position3D()
		{
			super();
		}
		
		override protected function initialization():void
		{
			if (_shape == null)
			{
				_shape = new Shape();
				_shape.graphics.beginFill(0xff0000);
				_shape.graphics.drawRect(-100,-100,200,200);
				_shape.graphics.endFill();
			}
			addChild(_shape);
			
			super.initialization();
		}
		
		override protected function onEnterFrame(e:Event):void
		{
			_shape.x = mouseX;
			_shape.y = mouseY;
			_shape.z = 10000 + Math.sin(_n += 0.1) * 10000;
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}