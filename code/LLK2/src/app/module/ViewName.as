package app.module
{
	import app.module.loading.LoadingView;
	import app.module.main.view.MainView;
	import app.module.menu.view.MenuView;
	import app.module.panel.help.HelpView;
	import app.module.panel.rank.RankView;
	import app.module.panel.update.UpdateView;
	import app.module.setting.SettingView;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-6
	 */
	public class ViewName
	{
		public function ViewName()
		{
		}
		
		public static const MENU:Class = MenuView;
		
		public static const MAIN:Class = MainView;
		
		public static const HELP:Class = HelpView;
		
		public static const RANK:Class = RankView;
		
		public static const SETTING:Class = SettingView;
		
		public static const LOADING:Class = LoadingView;
		
		public static const UPDATE:Class = UpdateView;
		
	}
}