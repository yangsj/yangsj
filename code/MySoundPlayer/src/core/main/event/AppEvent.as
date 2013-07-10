package core.main.event
{
	import flash.events.Event;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-7-10
	 */
	public class AppEvent extends Event
	{
		public var data:Object;
		public function AppEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		/**
		 * 缓冲中
		 */
		public static const BUFFERING:String = "buffering";
		/**
		 * 缓冲完成
		 */
		public static const BUFFER_COMPLETE:String = "buffer_complete";
		/**
		 * 播放进度
		 */
		public static const PLAY_PROGRESS:String = "play_progress";
	}
}