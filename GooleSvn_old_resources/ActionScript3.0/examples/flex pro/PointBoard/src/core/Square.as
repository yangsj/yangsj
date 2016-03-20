package core 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author King
	 */
	public class Square extends Tool 
	{
		private var shape:Sprite;
		
		public function Square() 
		{
			this.toolName = Tool.SQUARE;			
			this.option = new SquareOption();
		}
		
		/*override protected function stageHandler(e:Event):void 
		{
			squareArray = new Array();
		}*/
		
		override public function draw(e:Event):void 
		{
			super.draw(e);			
			////trace(this.toolName + ' ' + e.type);
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				drawArea.delElement();
				canPaint = true;
				shape = new Sprite();
				drawArea.addElement(shape);
				trace(e.target.name);
			}
			else if ( e.type == MouseEvent.MOUSE_MOVE ) redraw();
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE )
			{	
				redraw();
				shape.graphics.endFill();
				canPaint = false;				
			}
		}
		
		private function redraw():void
		{
			if (canPaint)
			{
				shape.graphics.clear();
				if (SquareOption(this.option).hasBorder) shape.graphics.lineStyle(SquareOption(this.option).lineStyle, SquareOption(this.option).lineColor, SquareOption(this.option).lineAlpha);
				if (SquareOption(this.option).hasFill) shape.graphics.beginFill(SquareOption(this.option).fillColor, SquareOption(this.option).fillAlpha);
				shape.graphics.drawRect(startX, startY, drawMouseX - startX, drawMouseY - startY);			
			}
		}
	}

}