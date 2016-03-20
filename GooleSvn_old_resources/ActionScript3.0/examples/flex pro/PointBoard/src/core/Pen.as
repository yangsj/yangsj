package core 
{
	import api.IOption;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author King
	 */
	public class Pen extends Tool 
	{
		private var shape:Sprite;
		private var txt:TextField;
		
		public function Pen() 
		{
			this.toolName = Tool.PEN;
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
				shape.graphics.lineStyle(PenOption(this.option).lineStyle, PenOption(this.option).lineColor, PenOption(this.option).lineAlpha);
				shape.graphics.moveTo(drawMouseX, drawMouseY);
			}
			else if ( e.type == MouseEvent.MOUSE_MOVE )
			{
				if (canPaint) shape.graphics.lineTo(drawMouseX, drawMouseY);				
			}
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE)
			{
				canPaint = false;
			}
		}
		
		override public function toString():String 
		{
			return "[Tool toolName=\"" + toolName + "\"] " + this.option;
		}
		
	}

}