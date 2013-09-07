package app.modules.login.command
{
	import app.modules.ViewName;
	import app.modules.login.login.LoginMediator;
	import app.modules.login.login.LoginView;
	import app.modules.login.service.LoginService;
	import app.modules.login.preloader.PreloaderMediator;
	import app.modules.login.preloader.PreloaderView;
	import app.modules.login.register.RegisterMediator;
	import app.modules.login.register.RegisterView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class LoginInitCommand extends BaseCommand
	{
		public function LoginInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			// 创建帐号，注册信息
			addView( ViewName.Register, RegisterView, RegisterMediator );
			// 登陆资源加载器
			addView( ViewName.Preloader, PreloaderView, PreloaderMediator );
			// 登陆界面
			addView( ViewName.Login, LoginView, LoginMediator );
			
			injectActor( LoginService );
			
		}
		
	}
}