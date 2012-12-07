package level
{

	import charactersOld.FreeCombatant;
	import flash.utils.setTimeout;



	public class Dungeon2 extends Dungeon
	{
		override public function get levels() : Array
		{
//			var wave1 : Wave = new Wave([0, 0, 5], [2, 3, 5]);
//			var wave2 : Wave = new Wave([5, 5, 7], [3, 4, 8]);
//			var wave3 : Wave = new Wave([7, 7, 11], [8, 5, 4]);
//			var wave4 : Wave = new Wave([11, 11, 14], [2, 5, 3]);
//			var wave5 : Wave = new Wave([14, 14, 16], [6, 3, 4]);
//			var wave6 : Wave = new Wave([16, 16, 20], [2, 8, 1]);
//			wave1.addEventListener(LevelEvent.START, function(evt : LevelEvent) : void
//			{
//				(wave1.enemies[2] as FreeCombatant).level = getPlayerAverageLv(wave1.getPlayers) + 1;
//				setTimeout(wave2.start, 13000, wave1.getPlayers, wave1.pos);
//				setTimeout(wave3.start, 23000, wave1.getPlayers, wave1.pos);
//				setTimeout(wave4.start, 33000, wave1.getPlayers, wave1.pos);
//				setTimeout(wave5.start, 43000, wave1.getPlayers, wave1.pos);
//				setTimeout(wave6.start, 53000, wave1.getPlayers, wave1.pos);
//			});
			var waves : Array = [[[0, 0, 5], [2, 3, 5]], [[5, 5, 7], [3, 4, 8]], [[7, 7, 11], [8, 5, 4]], [[11, 11, 14], [2, 5, 3]], [[14, 14, 16], [6, 3, 4]], [[16, 16, 20], [2, 8, 1]]];
			return LevelMaker.makeWaves(waves);
//			return [wave1, wave2, wave3, wave4, wave5];
		}
	}
}
