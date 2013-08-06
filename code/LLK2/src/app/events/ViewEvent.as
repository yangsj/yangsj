package app.events
{
	import flash.events.Event;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class ViewEvent extends Event
	{
		public var view:Class;
		
		public var data:Object;
		
		public function ViewEvent(type:String, viewClass:Class, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.view = viewClass;
			this.data = data;
		}
		
		public static const SHOW_VIEW:String = "showViewByEventCommand";
		
	}
}