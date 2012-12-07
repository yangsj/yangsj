package interfaces
{

	import character.PawnAttr;
	import charactersOld.Character;
	import flash.events.IEventDispatcher;




	public interface IRushCombatant extends ICombatant
	{
		function getDamage(targetAttr : PawnAttr) : Number;
		function get attackRange() : Number;
		function set attackRange(val : Number) : void;
		function get fireDuration() : Number;
		function set level(val : uint) : void;
		function get level() : uint;
		function get projectileSpeed() : Number;
		function get combatType() : String;
		function get isArcher() : Boolean;
		function set knockback(val : Boolean) : void;
		function get knockback() : Boolean;
		function get HP() : Number;
	}
}
