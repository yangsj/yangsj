package app.events
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class LoadEvent extends BaseEvent
	{
		public function LoadEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 资源加载完成
		 */
		public static const LOAD_COMPLETE:String = "app_load_complete";
		
		/**
		 * 开始加载资源
		 */
		public static const LOAD_START:String = "app_load_start";
		
		/**
		 * 资源加载进度
		 */
		public static const LOAD_PROGRESS:String = "app_load_progress";
	}
}