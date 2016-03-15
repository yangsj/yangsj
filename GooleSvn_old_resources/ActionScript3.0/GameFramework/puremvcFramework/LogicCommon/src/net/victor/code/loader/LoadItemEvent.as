package net.victor.code.loader
{
	import flash.events.Event;
	
	public class LoadItemEvent extends Event
	{
		public static var LOAD_ITEM_EVENT_COMPLETE:String = "load_item_event_complete";
		
		public var loadData:LoadData;
		public function LoadItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}