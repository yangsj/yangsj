package module.combat
{
	import charactersOld.FreeCombatant;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import module.status;




	use namespace status;


	public class AICombat extends Combat
	{
		private var randomAttackDelay : TweenLite;

		public function AICombat(host : FreeCombatant, getEnemiesFunc : Function)
		{
			super(host, getEnemiesFunc);
		}

		override status function start() : void
		{
			host.playStand();
			var superStart : Function = super.start;
			randomAttackDelay = TweenLite.to(this, 0.5 * Math.random(), {onComplete: function() : void
			{
				randomAttackDelay = null;
				superStart();
			}});
		}

		override status function pause() : void
		{
			if (randomAttackDelay)
				randomAttackDelay.pause();
			else
				super.pause();
		}

		override status function abort() : void
		{
			if (randomAttackDelay)
				randomAttackDelay.kill();
			else
				super.abort();
		}

		override protected function onTargetDead(event : Event) : void
		{
			var enemies : Array = getEnemiesFunc();
			var noTargets : Array = enemies.filter(selectNoTargetEnemy);
			if (noTargets.length)
				attack(noTargets[int(Math.random() * noTargets.length)]);
			else if (enemies.length)
				attack(enemies[int(Math.random() * noTargets.length)]);
			else
				super.onTargetDead(event);
		}

		private function selectNoTargetEnemy(enemy : FreeCombatant, ... rest) : Boolean
		{
			return enemy.target == null;
		}
	}
}
