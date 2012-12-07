package level
{

	import flash.events.Event;
	import flash.events.EventDispatcher;


	public class BossLevel extends EventDispatcher implements ILevel
	{
		public function BossLevel()
		{
		}

		public function start(getPlayers : Function, pos : *) : void
		{
		}

		public function get enemies() : Array
		{
			return null;
		}
	}
}
