package core.main.systemIcon
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-9
	 */
	public class SystemIconMenuType
	{
		public function SystemIconMenuType()
		{
		}

		public static const PLAY_MODE:String = "播放模式";
		public static const PLAY_MODE_SUB_LOOP:String = "列表循环";
		public static const PLAY_MODE_SUB_SINGLE:String = "单曲循环";
		public static const PLAY_MODE_SUB_RANDOM:String = "随机播放";
		public static const PLAY_MODE_SUB:Array = [ PLAY_MODE_SUB_LOOP, PLAY_MODE_SUB_SINGLE, PLAY_MODE_SUB_RANDOM ];

		public static const SETTING:String = "设置";
		public static const SETTING_SUB_AUTO_LOGIN:String = "开机启动";
		public static const SETTING_SUB_ALWAYS_IN_FRONT:String = "总在最前";
		public static const SETTING_SUB_ALWAYS_IN_BACK:String = "总是最后";
		public static const SETTING_SUB:Array = [ SETTING_SUB_AUTO_LOGIN, SETTING_SUB_ALWAYS_IN_FRONT, SETTING_SUB_ALWAYS_IN_BACK ];

		public static const CHECK_UPDATE:String = "检查更新";

		public static const EXIT_APPLICATION:String = "退出";

	}
}
