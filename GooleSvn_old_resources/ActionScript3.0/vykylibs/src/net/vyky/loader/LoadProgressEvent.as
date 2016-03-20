package net.vyky.loader
{
	import flash.events.ProgressEvent;
	
	public class LoadProgressEvent extends ProgressEvent
	{
		public static var LOAD_PROGRESS_EVENT_PROGRESS:String = "load_progress_event_progress";
		public var loadItemIndex:int = 0;
		public function LoadProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}