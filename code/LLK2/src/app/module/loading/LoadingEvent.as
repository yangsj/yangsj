package app.module.loading
{
	import framework.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-22
	 */
	public class LoadingEvent extends BaseEvent
	{
		public function LoadingEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}