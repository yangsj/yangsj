package app.modules.login.login
{
	import flash.display.InteractiveObject;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.Language;
	import app.core.Tips;
	import app.modules.login.login.event.LoginEvent;
	import app.modules.login.login.vo.LoginVo;
	
	import victor.framework.components.Reflection;
	import victor.framework.core.BaseScene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class LoginView extends BaseScene
	{
		public var txtAccountNumber:TextField;
		public var txtPassword:TextField;
		public var txtTips1:TextField;
		public var txtTips2:TextField;
		public var forgetPassword:InteractiveObject;
		public var btnLogin:InteractiveObject;
		public var btnRegister:InteractiveObject;
		
		private var _loginVo:LoginVo;
		
		public function LoginView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			_skin = new ui_SkinLoginUI();
			addChild( _skin );
			
			Reflection.reflection( this, _skin );
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.addEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			forgetPassword.addEventListener(MouseEvent.CLICK, txtForgetPasswordHandler );
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			btnLogin.removeEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.removeEventListener(MouseEvent.CLICK, btnRegisterHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtAccountNumber.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_IN, focusInOutHandler );
			txtPassword.removeEventListener(FocusEvent.FOCUS_OUT, focusInOutHandler );
			forgetPassword.removeEventListener(MouseEvent.CLICK, txtForgetPasswordHandler );
		}
		
		protected function txtForgetPasswordHandler(event:MouseEvent):void
		{
			// 忘记密码
		}
		
		protected function focusInOutHandler(event:FocusEvent):void
		{
			var type:String = event.type;
			var target:TextField = event.target as TextField;
			if ( type == FocusEvent.FOCUS_IN )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = false;
				else txtTips2.visible = false;
			}
			else if ( type == FocusEvent.FOCUS_OUT )
			{
				if ( target == txtAccountNumber )
					txtTips1.visible = !target.text;
				else txtTips2.visible = !target.text;
			}
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			dispatchEvent( new LoginEvent( LoginEvent.ACTION_REGISTER ));
		}
		
		protected function btnLoginHandler(event:MouseEvent):void
		{
			if ( txtAccountNumber.text && txtPassword.text )
			{
				dispatchEvent( new LoginEvent( LoginEvent.ACTION_LOGIN ));
			}
			else 
			{
				Tips.showMouse( Language.lang( Language.LoginView_0 ) );
			}
		}
		
		public function get loginVo():LoginVo
		{
			_loginVo ||= new LoginVo();
			_loginVo.accountNumber = txtAccountNumber.text;
			_loginVo.passwrod = txtPassword.text;
			return _loginVo;
		}
		
	}
}