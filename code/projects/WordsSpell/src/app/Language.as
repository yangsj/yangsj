package app
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class Language
	{
		public static function lang( msg:String, ...args ):String
		{
			var exp : RegExp = null;
			var index : int = 1;
			if(args){
				var len :int = args.length;
				while (index <= len) {
					exp = new RegExp("\\$<" + index + ">");
					msg = msg.replace(exp, args[(index - 1)]);
					index++;
				}
			}
			return msg;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		
		public static const PreloaderRollWordLine_0:String = "和同学比赛提高得更快哦|练习模式将记录你曾经出错过的单词|是不是感觉越来越难了,努力提高自己吧|玩过的关卡可以重复玩|遇到困难请老师和同学帮忙吧|学无止境,游戏中的提高也是如此";
		
		public static const LoginView_0:String = "请输入登陆帐号或密码！";
		
		public static const RegisterView_0:String = "姓名为必填项|年龄为必填项|昵称为必填项|密码为必填项|请再次确认密码|两次输入的密码不一致|输入的电话号码不正确|输入的邮箱格式不正确";
		
	}
}