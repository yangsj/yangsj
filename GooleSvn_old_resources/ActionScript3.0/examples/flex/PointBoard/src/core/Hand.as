package core 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Hand extends Tool 
	{
		
		public function Hand() 
		{
			this.toolName = Tool.HAND;
			this.option   = new Option(); 
 		}
		
		override public function draw(e:Event):void 
		{			
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				if (!canPaint)
				{
					canPaint = true;
					Object(drawArea).startDrag();
				}				
			}
			else if ( e.type == MouseEvent.MOUSE_UP || e.type == Event.MOUSE_LEAVE )
			{
				if (canPaint)
				{
					Object(drawArea).stopDrag();
					canPaint = false;
				}
				
			}
		}
	}

}