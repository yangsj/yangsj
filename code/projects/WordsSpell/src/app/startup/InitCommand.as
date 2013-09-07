package app.startup
{
	import flash.events.Event;
	
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.chat.command.ChatInitCommand;
	import app.modules.friend.command.FriendInitComand;
	import app.modules.login.command.LoginInitCommand;
	import app.modules.panel.test.TestInitCommand;
	import app.modules.scene.command.SceneInitCommand;
	import app.modules.task.command.TaskInitCommand;
	
	import victor.framework.core.BaseCommand;
	import victor.framework.drag.DragManager;
	
	
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
				  SceneInitCommand
				, TestInitCommand
				, TaskInitCommand // 任务系统
				, ChatInitCommand // 聊天系统
				, FriendInitComand// 好友系统
				, LoginInitCommand// 登陆游戏
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
			
			//////////////
			
			injector.mapValue( DragManager, DragManager.instance );
			
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
			
			// 打开登陆界面
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Login ));
			
		}
		
	}
}