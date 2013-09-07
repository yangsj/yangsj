package app.modules.login.login
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.login.login.event.LoginEvent;
	import app.modules.login.service.LoginService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class LoginMediator extends BaseMediator
	{
		[Inject]
		public var view:LoginView;
		
		[Inject]
		public var loginService:LoginService;
		
		public function LoginMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( LoginEvent.ACTION_LOGIN, actionLoginHandler, LoginEvent );
			addViewListener( LoginEvent.ACTION_REGISTER, actionRegisterHandler, LoginEvent );
		}
		
		private function actionRegisterHandler( event:LoginEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Register, view.loginVo ));
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Login ));
		}
		
		private function actionLoginHandler( event:LoginEvent ):void
		{
			loginService.login( view.loginVo, view.hide );
		}		
		
	}
}