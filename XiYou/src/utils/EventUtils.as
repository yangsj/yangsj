package utils
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Chenzhe
	 */
	public class EventUtils
	{
		public static function careOnce(target : IEventDispatcher, eventType : String, handler : Function) : Function
		{
			function f(evt : Event) : void
			{
				target.removeEventListener(eventType, f);
				handler(evt);
			}
			target.addEventListener(eventType, f);
			return f;
		}
	}
}
