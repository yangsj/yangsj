package panel.gamepause
{
	import flash.events.Event;
	
	
	/**
	 * 说明：GamePausePanelEvent
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-19
	 */
	
	public class GamePausePanelEvent extends Event
	{
		/**
		 * 退出
		 */
		public static const EXIT:String = "exit";
		
		/**
		 * 继续
		 */
		public static const CONTINUE:String = "continue";
		
		public function GamePausePanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
	}
	
}