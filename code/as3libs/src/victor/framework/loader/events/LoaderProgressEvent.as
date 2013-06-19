package victor.framework.loader.events
{
	import flash.events.Event;


	/**
	 * ……
	 * @author yangsj
	 */
	public class LoaderProgressEvent extends Event
	{
		/**
		 * 加载进度
		 */
		public static const PROGRESS:String = "loader_progress_event";

		public function LoaderProgressEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}

		/**
		 * 资源总加载数量
		 */
		public var numTotal:int = 0;
		/**
		 * 当前资源加载数量
		 */
		public var numLoaded:int = 0;

		/**
		 * 加载总进度(100)
		 */
		public var progressTotal:int = 100;
		/**
		 * 当前加载进度（percent: loaded 50%, progressLoaded=50）
		 */
		public var progressLoaded:int = 0;


	}
}
