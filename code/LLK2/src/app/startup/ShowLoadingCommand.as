package app.startup
{
	import app.events.AppEvent;
	import app.events.ViewEvent;
	import app.module.ViewName;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class ShowLoadingCommand extends BaseCommand
	{
		public function ShowLoadingCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			// 打开资源加载界面
			dispatch( new ViewEvent(ViewEvent.SHOW_VIEW, ViewName.LOADING ));
			
			// 启动应用检查更新
			dispatch( new AppEvent( AppEvent.CHECK_UPDATE ));
		}
		
	}
}