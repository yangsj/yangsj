package app.startup
{
	import app.events.ViewEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitCommand extends BaseCommand
	{
		public function InitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			// 监听打开视图
			commandMap.mapEvent( ViewEvent.SHOW_VIEW, ShowViewCommand, ViewEvent );
			// 监听关闭视图
			commandMap.mapEvent( ViewEvent.HIDE_VIEW, ShowViewCommand, ViewEvent );
		}
		
	}
}