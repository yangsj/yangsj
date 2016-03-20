package core 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Revocation extends Control 
	{
		
		public function Revocation() 
		{
			this.toolControlName = Control.REVOCATION;
			//addEventListener(MouseEvent.CLICK, revocationHandler);
		}
		
		//private function revocationHandler(e:MouseEvent):void
		//{
			//paintBoard.art.backElement();
		//}
		
		override protected function revocationAndAdvanceHandler(e:MouseEvent):void
		{
			paintBoard.art.backElement();
		}
	}

}