package net.victor.code.loader
{
	import flash.events.Event;
	
	public class LoadBatchEvent extends Event
	{
		public static var LOAD_BATCH_EVENT_COMPLETE:String = "load_batch_event_complete";
		public static var LOAD_BATCH_EVENT_PROGRESS:String = "load_batch_event_progress";
		
		public var totalNum:int = 0;
		public var loadedNum:int = 0; 
		
		
		
		public function LoadBatchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}