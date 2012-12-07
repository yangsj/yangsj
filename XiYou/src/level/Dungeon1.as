package level
{


	public class Dungeon1 extends Dungeon
	{
		public function Dungeon1()
		{
			super();
		}

		override public function get levels() : Array
		{
			var waves : Array = [[[0], [3]], [[0, 1], [6, 8]], [[2, 2, 1], [1, 5, 4]], [[4, 0, 3, 1], [1, 2, 3, 4]]];
			return LevelMaker.makeWaves(waves);
		}
	}
}
