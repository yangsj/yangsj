package core 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author King
	 */
	public class Circle extends Tool 
	{
		private var shape:Sprite;
		
		public function Circle() 
		{
			this.toolName = Tool.CIRCLE;
			this.option = new CircleOption();
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
				shape.graphics.drawEllipse(startX, startY, drawMouseX - startX, drawMouseY - startY);			
			}
		}
	}

}