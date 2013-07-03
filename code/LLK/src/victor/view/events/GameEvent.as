package victor.view.events
{
	import flash.events.Event;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-2
	 */
	public class GameEvent extends Event
	{
		public var data:Object;

		public function GameEvent( type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
			this.data = data;
		}



		/**
		 * 增加时间
		 */
		public static const ADD_TIME:String = "add_time";
		
		/**
		 * 成功消除所有
		 */
		public static const DISPEL_SUCCESS:String = "dispel_success";
		
		/**
		 * 增加得分
		 */
		public static const ADD_SCORE:String = "add_score";
		
		/**
		 * 时间控制
		 */
		public static const CTRL_TIME:String = "ctrl_time";


	}
}
