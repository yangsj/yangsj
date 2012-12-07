package level
{

	import flash.events.IEventDispatcher;


	public interface ILevel extends IEventDispatcher
	{
		function start(getPlayers : Function, pos : *) : void;
		function get enemies() : Array;
	}
}
