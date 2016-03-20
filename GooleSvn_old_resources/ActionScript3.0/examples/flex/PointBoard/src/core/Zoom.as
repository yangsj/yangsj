package core 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author King
	 */
	public class Zoom extends Tool 
	{
		private var txt:TextField = new TextField();
		
		public function Zoom() 
		{
			this.toolName = Tool.ZOOM;
			this.option = new ZoomOption();
		}	
		
		override public function draw(e:Event):void 
		{
			//super.draw(e);
			
			//trace(this.toolName + ' ' + e.type);
			
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				//stage.addChild(txt);
				addChild(txt);
				txt.text = '';
				txt.x = mouseX + 10;
				txt.y = mouseY;
				
				if (ZoomOption(this.option).hasBig)
				{
					if (Object(paintBoard.art).width < 2500)
					{
						DisplayObject(drawArea).width *= 1.05;
						DisplayObject(drawArea).height *= 1.05;
					}
					else  txt.text = '已经放大到最大了';
				}
				else if (ZoomOption(this.option).hasSmall)
				{
					
					if (DisplayObject(drawArea).width > 250)
					{
						DisplayObject(drawArea).width  *= 0.95;
						DisplayObject(drawArea).height *= 0.95;
					}
					else txt.text = '已经缩小到最小了';
				}
				else if (ZoomOption(this.option).hasPlace)
				{
					DisplayObject(drawArea).width  = 800;
					DisplayObject(drawArea).height = 600;
					DisplayObject(drawArea).x = 295;
					DisplayObject(drawArea).y = 210;
				}
			}
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE || e.type == MouseEvent.MOUSE_MOVE)
			{
				if (txt.parent) txt.parent.removeChild(txt);
			}
		}		
	}

}