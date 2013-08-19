package code
{
	import flash.events.Event;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class MEvent extends Event
	{
		public var index:int;
		public var visible:Boolean;
		
		public function MEvent(type:String, index:int, visible:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.index = index;
			this.visible = visible;
		}
		
		public static const SELECTED_MENU:String = "selected_menu";
		
		
	}
}