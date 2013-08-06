package app.module.main.events
{
	import framework.BaseEvent;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-2
	 */
	public class MainEvent extends BaseEvent
	{

		public function MainEvent( type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			super( type, data, bubbles, cancelable );
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
		
		/**
		 * 游戏界面返回菜单界面
		 */
		public static const BACK_MENU:String = "back_menu";


	}
}
