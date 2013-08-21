package app.core
{
	import com.freshplanet.ane.AirAlert.AirAlert;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class Alert// extends Sprite
	{
		public function Alert()
		{
		}

		public static function showAlert( title:String, 
										  message:String, 
										  button1:String="OK", 
										  callback1:Function=null, 
										  button2:String=null, 
										  callback2:Function=null ):void
		{
			AirAlert.getInstance().showAlert( title, message, button1, callback1, button2, callback2 );
		}
		
	}
}
