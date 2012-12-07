package module.combat {
	import charactersOld.Character;
	import charactersOld.RushCombatant;
	import flash.display.MovieClip;
	import interfaces.IRushCombatant;
	import module.ProjectleModule;
	import utils.Heartbeat;





	public class RangedRushCombatModule extends RushCombatModule
	{
		private var projectleModule : ProjectleModule;
		private var projectle : MovieClip;
		private var _firing : Boolean = false;

		public function RangedRushCombatModule(host : IRushCombatant, projectle : MovieClip, getEnemiesFunc : Function)
		{
			this.projectle = projectle;
			super(host, getEnemiesFunc);
			projectleModule = new ProjectleModule(host, projectle, getEnemiesFunc);
		}

		override protected function goStep() : void
		{
			if (!_firing)
				super.goStep();
		}

		override protected function gotEnemyInrange(target : RushCombatant) : void
		{
			if (!_firing)
				super.gotEnemyInrange(target);
		}

		override protected function playAttackAnim() : void
		{
			if (!_firing)
				super.playAttackAnim();
		}

		override protected function knockbackTarget() : void
		{
		}

		override protected function targetHurt() : void
		{
			super.targetHurt();
			if (_target.HP <= 0)
				_target.dead();
		}

		override protected function fire() : void
		{
			playAttackAnim();
			_firing = true;
			Heartbeat.instance.addOnTick(function() : void
			{
				_firing = false;
			}, IRushCombatant(host).fireDuration)
			if (projectle.stage)
			{
				projectle.visible = true;
				projectleModule.shoot(function(target : Character) : void
				{
					setTarget(target)
					projectle.visible = false;
					targetHurt();
//					knockbackTarget();
				});
			}
		}
	}
}
