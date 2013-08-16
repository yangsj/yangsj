package app
{
	import flash.display.DisplayObjectContainer;
	
	import app.startup.BgMusicCommand;
	import app.startup.CommonCommand;
	import app.startup.EmbedViewCommand;
	import app.startup.EnterCommand;
	import app.startup.InjectClassCommand;
	import app.startup.KeyboardCommand;
	import app.startup.StartupCommand;
	
	import framework.BaseContext;
	import framework.ViewStruct;
	
	import org.robotlegs.base.ContextEvent;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class AppContext extends BaseContext
	{
		public function AppContext( contextView:DisplayObjectContainer = null, autoStartup:Boolean = true )
		{
			super( contextView, autoStartup );
		}

		override public function startup():void
		{
			initManager();

			addCommand();

			super.startup();

			trace( "startup==============================over" );
		}

		private function initManager():void
		{
			AppStage.initStage( contextView.stage );

			ViewStruct.initialize( contextView );
		}

		private function addCommand():void
		{
			
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, InjectClassCommand, ContextEvent, true );
			
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, EmbedViewCommand, ContextEvent, true );
			
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent, true );
			
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, CommonCommand, ContextEvent, true );

			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, BgMusicCommand, ContextEvent, true );
			
			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, KeyboardCommand, ContextEvent, true );

			commandMap.mapEvent( ContextEvent.STARTUP_COMPLETE, EnterCommand, ContextEvent, true );
			
		}

	}
}
