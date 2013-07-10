package core
{

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-7-10
	 */
	public class AppStatus
	{
		public function AppStatus()
		{
			checkSettingStatus();
		}

		private function checkSettingStatus():void
		{
			trace( Setting.playLoop, Setting.playRandom, Setting.playSingle, Setting.alwaysInFront, Setting.alwaysInBack );

			if ( Setting.playLoop == Setting.playRandom == Setting.playSingle == false )
			{
				Setting.playLoop = true;
			}
			if ( Setting.alwaysInFront )
			{
				Global.nativeWindow.orderToFront();
				Global.nativeWindow.alwaysInFront = true;
			}
			else if ( Setting.alwaysInBack )
			{
				Global.nativeWindow.orderToBack();
				Global.nativeWindow.alwaysInFront = false;
			}
		}

	}
}
