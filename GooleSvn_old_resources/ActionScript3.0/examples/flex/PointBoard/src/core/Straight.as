package core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Straight extends Tool 
	{
		private var shape:Sprite;
		
		public function Straight() 
		{
			this.toolName = Tool.STRAIGHT;
			this.option = new PenOption();
		}
		
		override public function draw(e:Event):void 
		{
			super.draw(e);
			
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				drawArea.delElement();
				canPaint = true;
				shape = new Sprite();
				drawArea.addElement(shape);
			}
			else if ( e.type == MouseEvent.MOUSE_MOVE )
			{
				if (shape && canPaint) shape.graphics.clear();
				redraw();
			}
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE)
			{
				redraw();
				canPaint = false;
			}
		}
		
		private function redraw():void
		{
			if (canPaint)
			{
				shape.graphics.lineStyle(PenOption(this.option).lineStyle, PenOption(this.option).lineColor, PenOption(this.option).lineAlpha);	
				shape.graphics.moveTo(startX, startY);
				shape.graphics.lineTo(startX, startY);
				shape.graphics.lineTo(drawMouseX, drawMouseY);
			}
		}
	}

}