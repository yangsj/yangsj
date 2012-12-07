package charactersOld
{

	import flash.events.Event;


	public class CharacterEvent extends Event
	{
		public static const MOVE : String = 'MOVE';
		public static const MOVING : String = 'MOVING';
		public static const STAND : String = 'STAND';
		public static const DEAD : String = 'DEAD';
		public static const DISPOSE : String = 'DISPOSE';
		public static const HURT : String = 'HURT';
		public static const RAGE_UPDATE : String = "RAGE_UPDATE";

		public function CharacterEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
