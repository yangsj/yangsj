package loaders
{
	import flash.events.Event;
	
	
	/**
	 * 说明：LoaderEvent
	 * @author Victor
	 * 2012-10-26
	 */
	
	public class LoaderProgressEvent extends Event
	{
		public static const PROGRESS:String = "progress_event";
		
		public var current:int = 0;
		public var total:int = 100;
		
		public function LoaderProgressEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
	}
	
}