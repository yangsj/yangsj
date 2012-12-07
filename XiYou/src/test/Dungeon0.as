package test
{

	import level.Dungeon;
	import level.Wave;


	public class Dungeon0 extends Dungeon
	{
		public function Dungeon0()
		{
			super();
		}

		override public function get levels() : Array
		{
			return [new Wave(['0', '0', '0', '0'], [1, 4, 3, 5])];
		}
	}
}
