package events
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;


	/**
	 * ……
	 * @author yangsj
	 */
	public class EditEvent extends Event
	{
		public static const dispatcher:EventDispatcher = new Sprite();

		/**
		 * 解析完成
		 */
		public static const RESOLVING_ALL_COMPLETE:String = "resolving_all_complete";

		/**
		 * 解析单个文件完成
		 */
		public static const RESOLVING_ITEM_COMPLETE:String = "resolving_item_complete";


		public var data:Object;

		public function EditEvent( type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
			this.data = data;
		}
	}
}
