package app
{
	import com.adobe.nativeExtensions.Vibration;
	
	import app.module.model.Global;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-19
	 */
	public class NativeExtensions
	{
		public function NativeExtensions()
		{
		}
		
		/////////////// 震动 （ android & ios ）///////////////////////
		
		private static var vibration:Vibration;
		
		/**
		 * 手机震动
		 * @param duration 持续震动时间长（ 以毫秒为单位 ）
		 */
		public static function vibrate( duration:Number ):void
		{
			if (Vibration.isSupported && Global.switchResultVibrate )
			{
				vibration ||= new Vibration();
				vibration.vibrate( duration );
			}
		}
		
	}
}