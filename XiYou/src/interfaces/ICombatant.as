package interfaces
{

	import flash.events.IEventDispatcher;

	import mx.utils.NameUtil;


	public interface ICombatant extends IWalkImpl, IWalkable, IPositionable, IEventDispatcher
	{
		function dead() : void;
		function get fireAnimDuration() : Number;
	}
}
