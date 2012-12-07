package level
{

	import charactersOld.FreeCombatant;
	import flash.events.Event;
	import flash.utils.setTimeout;



	public class Dungeon3 extends Dungeon
	{
		override public function get levels() : Array
		{
			var wave1 : Wave = new Wave([0, 0, 0], [2, 3, 8]);
			var wave2 : Wave = new Wave([18], [6]);
			var wave3 : Wave = new Wave([5, 5, 5], [6, 1, 4]);
			var wave4 : Wave = new Wave([7, 7, 7], [2, 5, 3]);
			var wave5 : Wave = new Wave([17, 13], [6, 3]);
			//第一批怪物数量存活<2 牛魔王出场
			wave1.addEventListener(LevelEvent.ONE_DEAD, function(evt : Event) : void
			{
				log('第二波');
				wave1.enemies.length < 2;
				wave2.start(wave1.getPlayers, wave1.pos);
				(wave2.enemies[0] as FreeCombatant).level = getPlayerAverageLv(wave1.getPlayers) + 5;
			});

			wave1.addEventListener(LevelEvent.COMPLETE, function(evt : Event) : void
			{
				log('第三波');
				setTimeout(wave3.start, 15000, wave1.getPlayers, wave1.pos);
			});

			wave3.addEventListener(LevelEvent.COMPLETE, function(evt : Event) : void
			{
				log('第四波');
				setTimeout(wave4.start, 15000, wave1.getPlayers, wave1.pos);
			});

			wave4.addEventListener(LevelEvent.COMPLETE, function(evt : Event) : void
			{
				log('第五波');
				setTimeout(wave5.start, 20000, wave1.getPlayers, wave1.pos);
			});

			return [wave1, wave2, wave3, wave4, wave5];
		}
	}
}
