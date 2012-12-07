package level
{
	import charactersOld.FreeCombatant;



	public class Dungeon
	{
		public function Dungeon()
		{
		}

		public function getPlayerAverageLv(getPlayers : Function) : int
		{
			var totalLv : int = 0;
			var players : Array = getPlayers();
			players.map(function(player : FreeCombatant, ... rest) : void
			{
				totalLv += player.level;
			});
			return totalLv / players.length;
		}

		public function get levels() : Array
		{
			return [];
		}
	}
}
