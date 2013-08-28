package app.startup
{
	
	import app.modules.panel.test.TestMediator;
	import app.modules.panel.test.TestView;
	import app.modules.preloader.PreloaderMediator;
	import app.modules.preloader.PreloaderView;
	
	import victor.framework.core.BaseCommand;
	
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
			addView( PreloaderView, PreloaderMediator );
			
			addView( TestView, TestMediator );
		}
		
	}
}