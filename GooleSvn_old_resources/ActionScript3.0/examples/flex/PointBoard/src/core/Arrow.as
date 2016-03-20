package core 
{
	import api.IArt;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Arrow extends Tool 
	{
		private var sprite:Sprite;
		
		public function Arrow() 
		{
			this.toolName = Tool.ARROW;
			this.option = new ArrowOption();
		}
		
		override protected function stageHandler(e:Event):void
		{
			if (e.type == Event.ADDED_TO_STAGE) sprite = new Sprite();
		}
		
		override public function draw(e:Event):void 
		{
			super.draw(e);
			
			if ( e.type == MouseEvent.MOUSE_DOWN && e.target is IArt)
			{
				if (e.target is IArt) canPaint = true;
				DisplayObjectContainer(drawArea).addChild(sprite);
			}
			else if ( e.type == MouseEvent.MOUSE_MOVE ) redraw();
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE )
			{
				sprite.graphics.endFill();
				if ( canPaint && (startX != drawMouseX || startY != drawMouseY) ) drawArea.multiSelect(sprite);
				sprite.graphics.clear();
				canPaint = false;
				DisplayObjectContainer(drawArea).mouseChildren = true;
			}
		}
		
		//画一个矩形
		private function redraw():void
		{
			if (canPaint)
			{
				DisplayObjectContainer(drawArea).mouseChildren = false;
				sprite.graphics.clear();
				sprite.graphics.lineStyle(1);
				sprite.graphics.beginFill(0xffffff,0);
				sprite.graphics.drawRect(startX, startY, drawMouseX - startX, drawMouseY - startY);
			}
		}
	}

}