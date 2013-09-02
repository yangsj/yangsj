package app.startup
{
	
	import app.modules.ViewName;
	import app.modules.panel.test.TestMediator;
	import app.modules.panel.test.TestView;
	import app.modules.preloader.PreloaderMediator;
	import app.modules.preloader.PreloaderView;
	import app.modules.scene.view.SceneMediator;
	import app.modules.scene.view.SceneView;
	
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
			//////////// add scenes //////////////////////
			
			addView( "", SceneView, SceneMediator );
			
			
			///////////// add panels ///////////////
			addView( ViewName.Preloader, PreloaderView, PreloaderMediator );
			
			addView( ViewName.Test, TestView, TestMediator );
			
			
		}
		
	}
}