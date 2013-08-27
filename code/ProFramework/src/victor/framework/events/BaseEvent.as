package victor.framework.events
{
	import flash.events.Event;
	
	/**
	 * …… 自定义事件类基类
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class BaseEvent extends Event
	{
		public var data:Object;
		
		public function BaseEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			this.data = data;
		}
		
		override public function clone():Event 
		{
			return new BaseEvent(type, data, bubbles, cancelable);
		}
		
	}
}