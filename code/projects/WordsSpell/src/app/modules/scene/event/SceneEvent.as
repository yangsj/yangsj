package app.modules.scene.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class SceneEvent extends BaseEvent
	{
		public function SceneEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		public static const OPEN_TEST:String = "open_test";
		
		public static const SHOW:String = "scene_show";
		
	}
}