package level
{

	import character.PawnAttr;
	import charactersOld.AIFreeCombatant;
	import charactersOld.CharacterEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import utils.ArrayUtils;




	public class Wave extends EventDispatcher implements ILevel
	{
		private var _enemies : Array;
		public var nextLevel : ILevel;
		private var position : Array;
		private var enemyId : Array;
		private var numEnemies : uint;
		public var pos : *;
		public var getPlayers : Function;

		public function Wave(enemyId : Array, position : Array)
		{
			this.enemyId = enemyId;
			this.position = position;
		}

		protected function onDead(event : Event) : void
		{
			ArrayUtils.remove(enemies, event.currentTarget);
			if (enemies.length == 0)
			{
				log('LEVEL COMPLETE');
				dispatchEvent(new LevelEvent(LevelEvent.COMPLETE));
			}
			else
			{
				dispatchEvent(new LevelEvent(LevelEvent.ONE_DEAD));
			}
		}

		public function start(getPlayers : Function, pos : *) : void
		{
			this.getPlayers = getPlayers;
			this.pos = pos;
			enemies = [];
			for (var i : * in enemyId)
			{
				var id : * = enemyId[i];
				var attr : PawnAttr = Attrs.instance.getAttrById(id);
				var enemy : AIFreeCombatant = new AIFreeCombatant(attr, getPlayers);
				enemies.push(enemy);
				log('pos:', pos);
				log('position:', position);
				log('position[i]:', position[i]);
				log('pos[position[i]]:', pos[position[i]]);
				enemy.x = pos[position[i]].x;
				enemy.y = pos[position[i]].y;
				enemy.addEventListener(CharacterEvent.DEAD, onDead);
			}
			numEnemies = enemies.length;
			dispatchEvent(new LevelEvent(LevelEvent.START));
		}

		public function get enemies() : Array
		{
			return _enemies;
		}

		public function set enemies(value : Array) : void
		{
			_enemies = value;
		}

		public function set prevWave(prevWave : Wave) : void
		{
			prevWave.addEventListener(LevelEvent.COMPLETE, function(evt : Event) : void
			{
				start(prevWave.getPlayers, prevWave.pos);
			});
		}
	}
}
