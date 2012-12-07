package level
{

	import flash.events.Event;


	public class LevelEvent extends Event
	{
		public static var COMPLETE : String = 'COMPLETE';
		public static var START : String = 'START';
		public static var ONE_DEAD : String = 'ONE_DEAD';

		public function LevelEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
