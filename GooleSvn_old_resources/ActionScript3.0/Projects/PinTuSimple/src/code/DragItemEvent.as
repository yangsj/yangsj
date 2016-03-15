package code
{
	import flash.events.Event;
	
	
	/**
	 * 说明：DragItemEvent
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-4-16
	 */
	
	public class DragItemEvent extends Event
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		/**
		 * 单个移动到正确位置
		 */
		internal static const ITEM_OVER:String = "item_over";
		
		public var item:DragItem;
		
		public function DragItemEvent(type:String, $item:DragItem=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			item = $item;
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}