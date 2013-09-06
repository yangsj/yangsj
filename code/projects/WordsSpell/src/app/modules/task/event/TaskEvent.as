package app.modules.task.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskEvent extends BaseEvent
	{
		public function TaskEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}