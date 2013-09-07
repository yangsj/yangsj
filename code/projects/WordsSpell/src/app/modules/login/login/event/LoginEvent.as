package app.modules.login.login.event
{
	import victor.framework.events.BaseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-7
	 */
	public class LoginEvent extends BaseEvent
	{
		public function LoginEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
		
		/**
		 * 登陆
		 */
		public static const ACTION_LOGIN:String = "action_login";
		
		/**
		 * 注册
		 */
		public static const ACTION_REGISTER:String = "action_register";
		
	}
}