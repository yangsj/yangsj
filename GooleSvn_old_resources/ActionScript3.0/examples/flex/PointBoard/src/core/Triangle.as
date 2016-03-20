package core 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author King
	 */
	public class Triangle extends Tool 
	{
		private var shape:Sprite;
		
		
		public function Triangle() 
		{
			this.toolName = Tool.TRIANGLE;
			this.option = new TriangleOption();
		}
		
		override public function draw(e:Event):void 
		{
			super.draw(e);
			
			//trace(this.toolName + ' ' + e.type);
			
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				drawArea.delElement();
				canPaint = true;
				shape = new Sprite();
				drawArea.addElement(shape);	
				if (SquareOption(this.option).hasBorder) shape.graphics.lineStyle(SquareOption(this.option).lineStyle, SquareOption(this.option).lineColor, SquareOption(this.option).lineAlpha);
				if (SquareOption(this.option).hasFill) shape.graphics.beginFill(SquareOption(this.option).fillColor, SquareOption(this.option).fillAlpha);
			}
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE)
			{	
				redraw();
				shape.graphics.endFill();
				canPaint = false;				
			}
			else if ( e.type == MouseEvent.MOUSE_MOVE )
			{
				redraw();
			}			
		}
		
		private function redraw():void
		{
			if (canPaint)
			{
				shape.graphics.clear();
				if (SquareOption(this.option).hasBorder) shape.graphics.lineStyle(SquareOption(this.option).lineStyle, SquareOption(this.option).lineColor, SquareOption(this.option).lineAlpha);
				if (SquareOption(this.option).hasFill) shape.graphics.beginFill(SquareOption(this.option).fillColor, SquareOption(this.option).fillAlpha);
				shape.graphics.moveTo(drawMouseX, drawMouseY);
				shape.graphics.lineTo(startX, drawMouseY - 3 * (drawMouseY - startY));
				shape.graphics.lineTo(drawMouseX - 2 * (drawMouseX - startX), drawMouseY);
				shape.graphics.lineTo(drawMouseX, drawMouseY);
			}
			
		}
	}

}