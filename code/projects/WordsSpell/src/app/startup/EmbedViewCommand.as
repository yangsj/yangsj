package app.startup
{
	
	import app.modules.ViewName;
	import app.modules.login.preloader.PreloaderMediator;
	import app.modules.login.preloader.PreloaderView;
	import app.modules.login.register.RegisterMediator;
	import app.modules.login.register.RegisterView;
	import app.modules.panel.test.TestMediator;
	import app.modules.panel.test.TestView;
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
			
			// 主场景
			addView( "", SceneView, SceneMediator );
			
			// 创建帐号，注册信息
			addView( ViewName.register, RegisterView, RegisterMediator );
			// 登陆资源加载器
			addView( ViewName.Preloader, PreloaderView, PreloaderMediator );
			
			///////////// add panels ///////////////
			
			// 测试面板
			addView( ViewName.Test, TestView, TestMediator );
			
			
		}
		
	}
}