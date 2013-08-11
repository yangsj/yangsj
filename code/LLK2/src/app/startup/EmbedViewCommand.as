package app.startup
{
	import app.module.main.view.MainMediator;
	import app.module.main.view.MainView;
	import app.module.menu.view.MenuMediator;
	import app.module.menu.view.MenuView;
	import app.module.panel.help.HelpMediator;
	import app.module.panel.help.HelpView;
	import app.module.panel.rank.RankMediator;
	import app.module.panel.rank.RankView;
	import app.module.setting.SettingMediator;
	import app.module.setting.SettingView;
	
	import framework.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class EmbedViewCommand extends BaseCommand
	{
		public function EmbedViewCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( MainView, MainMediator);
			
			addView( MenuView, MenuMediator);
			
			addView( HelpView, HelpMediator );
			
			addView( RankView, RankMediator );
			
			addView( SettingView, SettingMediator );
		}
		
	}
}