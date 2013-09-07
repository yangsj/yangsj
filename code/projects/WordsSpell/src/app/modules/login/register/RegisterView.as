package app.modules.login.register
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.Language;
	import app.core.Tips;
	import app.modules.login.register.event.RegisterEvent;
	import app.modules.login.register.vo.RegisterVo;
	import app.utils.appStage;
	
	import victor.framework.components.Reflection;
	import victor.framework.core.BaseScene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-4
	 */
	public class RegisterView extends BaseScene
	{
		// required
		public var txtName:TextField;
		public var txtAge:TextField;
		public var txtAccount:TextField;
		public var txtPw1:TextField;
		public var txtPw2:TextField;
		// optional
		public var txtSchool:TextField;
		public var txtPhone:TextField;
		public var txtEmail:TextField;
		public var txtClass:TextField;
		public var txtQQ:TextField;
		
		public var btnRegister:InteractiveObject;
		public var btnLogin:InteractiveObject;
		
		private var _registerVo:RegisterVo;
		
		public function RegisterView()
		{
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			_skin = new ui_SkinRegisterUI();
			addChild( _skin );
			Reflection.reflection( this, _skin );
			
			btnLogin.addEventListener(MouseEvent.CLICK, btnLoginHandler );
			btnRegister.addEventListener(MouseEvent.CLICK, btnRegisterHandler );
			
			txtAge.restrict = "0-9";
			txtPhone.restrict = "0-9";
			txtQQ.restrict = "0-9";
		}
		
		protected function btnLoginHandler(event:MouseEvent):void
		{
			dispatchEvent( new RegisterEvent( RegisterEvent.LOGIN ));
		}
		
		protected function btnRegisterHandler(event:MouseEvent):void
		{
			var msg:String = "";
			var array:Array = Language.lang(Language.RegisterView_0).split("|");
			if ( !registerVo.playerName )
				msg = array[0];
			else if ( !registerVo.playerAge )
				msg = array[1];
			else if ( !registerVo.nickName )
				msg = array[2];
			else if ( !registerVo.password )
				msg = array[3];
			else if (　!registerVo.passwordConfirm )
				msg = array[4];
			if ( !msg )
			{
				if ( registerVo.password != registerVo.passwordConfirm )
				{
					txtPw2.text = "";
					msg =  array[5];
				}
				else
				{
					if ( registerVo.phone && !validatePhoneNumber( registerVo.phone ))
						msg = array[6];
					else if ( registerVo.email && !validateEmail( registerVo.email ))
						msg = array[7];
				}
			}
			
			if ( msg )
			{
				Tips.showMouse( msg );
			}
			else
			{
				dispatchEvent( new RegisterEvent( RegisterEvent.REGISTER ));
			}
		}
		
		/**
		 * 验证邮箱是否格式正确
		 * @param str
		 * @return 
		 */
		private function validateEmail(str:String):Boolean {
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(str);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		/**
		 * 验证电话号码是否正确
		 * @param str
		 * @return 
		 */
		private function validatePhoneNumber(str:String):Boolean {
			var pattern:RegExp = /^\d{11}$/;
			var result:Object = pattern.exec(str);
			if(result == null) {
				return false;
			}
			return true;
		}
		
		public function get registerVo():RegisterVo
		{
			_registerVo ||= new RegisterVo();
			_registerVo.playerName = txtName.text;
			_registerVo.playerAge = txtAge.text;
			_registerVo.nickName = txtAccount.text;
			_registerVo.password = txtPw1.text;
			_registerVo.passwordConfirm = txtPw2.text;
			
			_registerVo.schoolName = txtSchool.text;
			_registerVo.phone = txtPhone.text;
			_registerVo.email = txtEmail.text;
			_registerVo.className = txtClass.text;
			_registerVo.QQ = txtQQ.text;
			
			return _registerVo;
		}
		
	}
}