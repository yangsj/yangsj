package app.startup
{
	import flash.events.Event;
	
	import app.events.ViewEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitCommand extends BaseCommand
	{
		// 初始化
		private static const INIT_COMMAND:String = "init_command";
		
		private static var commands:Array = 
			[
			];
		
		public function InitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			//************  add events ************************************************//
			// 监听打开视图
			commandMap.mapEvent( ViewEvent.SHOW_VIEW, ShowViewCommand, ViewEvent );
			// 监听关闭视图
			commandMap.mapEvent( ViewEvent.HIDE_VIEW, ShowViewCommand, ViewEvent );
			
			
			
			//************  initlialize commands ************************************************//
			// 初始化 command
			var len:int = commands.length;
			var initCommandClass:Class;
			for ( var i:int = 0; i < len; i++ )
			{
				initCommandClass = commands[ i ];
				if ( initCommandClass )
					commandMap.mapEvent( INIT_COMMAND, initCommandClass, Event, true );
			}
			dispatch( new Event( INIT_COMMAND ));
			
		}
		
	}
}