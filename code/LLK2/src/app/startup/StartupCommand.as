package app.startup
{
	import flash.events.Event;

	import app.events.AppEvent;

	import framework.BaseCommand;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class StartupCommand extends BaseCommand
	{

		private static var panls:Array = [ 
			BgMusicCommand 
		];

		// 面板初始化
		public static const INIT_PANEL_COMMAND:String = "init_panel_command";

		public function StartupCommand()
		{
			super();
		}

		override public function execute():void
		{
			super.execute();

			// 初始化面板 command
			var len:int = panls.length;
			var initCommandClass:Class;
			for ( var i:int = 0; i < len; i++ )
			{
				initCommandClass = panls[ i ];
				if ( initCommandClass )
					commandMap.mapEvent( INIT_PANEL_COMMAND, initCommandClass, Event, true );
			}
			dispatch( new Event( INIT_PANEL_COMMAND ));

		}


	}
}
