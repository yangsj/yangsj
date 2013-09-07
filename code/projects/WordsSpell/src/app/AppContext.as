package app
{
	import flash.display.DisplayObjectContainer;
	
	import app.events.LoadEvent;
	import app.startup.EnterGameCommand;
	import app.startup.FlashVarsCommand;
	import app.startup.InitCommand;
	import app.startup.InitServiceCommand;
	import app.startup.LoadCommand;
	
	import org.robotlegs.base.ContextEvent;
	
	import victor.framework.core.BaseContext;
	import victor.framework.core.ViewStruct;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class AppContext extends BaseContext
	{
		public function AppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			initManager();
			addStartupCommand()
			
			super.startup();
		}
		
		private function initManager() : void
		{
			// 初始化视图结构管理器
			ViewStruct.initialize( contextView );
		}
		
		private function addStartupCommand() : void
		{
			// 解析传flash的参数值
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, FlashVarsCommand, ContextEvent, true);
			
			// 初始化网络
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitServiceCommand, ContextEvent, true);
			
			// 初始化command
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitCommand, ContextEvent, true);
			
			// 加载
			commandMap.mapEvent(LoadEvent.LOAD_START, LoadCommand, LoadEvent, true);
			
			// 进入游戏场景
			commandMap.mapEvent(LoadEvent.LOAD_COMPLETE, EnterGameCommand, LoadEvent, true);
			
		}
		
	}
}