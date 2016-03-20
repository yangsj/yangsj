package core 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Advance extends Control 
	{
		
		public function Advance() 
		{
			this.toolControlName = Control.ADVANCE;
			//addEventListener(MouseEvent.CLICK, advanceHandler);
		}
		
		//private function advanceHandler(e:MouseEvent):void
		//{
			//paintBoard.art.nextElement();
		//}
		
		override protected function revocationAndAdvanceHandler(e:MouseEvent):void
		{
			paintBoard.art.nextElement();
		}
	}

}