package interfaces
{
	import charactersOld.Character;

	public interface IAttackImpl
	{
		function get attackRange() : Number;
		function get damage() : Number;
		
		function set attackRange(val : Number) : void;
		function set damage(val : Number) : void;
		
		function inRange(target : Character) : Boolean;
	}
}