package module.combat
{

	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import charactersOld.RushCombatant;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import global.Global;
	import interfaces.ICombatant;





	/**
	 *
	 * @author Chenzhe
	 */
	public class CombatModule
	{
		/**
		 *
		 * @default
		 */
		protected var host : ICombatant;
		/**
		 *
		 * @default
		 */
		protected var _target : Character;
		private var _attackRange : Number = Global.FIGHTER_ATTACK_RANGE;
		private var _damage : Number = 20;
		/**
		 *
		 * @default
		 */
		protected var getEnemiesFunc : Function;

		/**
		 *
		 * @param host
		 */
		public function CombatModule(host : ICombatant, getEnemiesFunc : Function)
		{
			this.host = host;
			this.getEnemiesFunc = getEnemiesFunc;
		}

		/**
		 * 判断目标在不在攻击距离内
		 * @param target 攻击目标
		 */
		protected function inAttactRange(target : Character) : Boolean
		{
			var dist : Number = Point.distance(new Point(host.x, host.y), new Point(target.x, target.y));
			return dist <= attackRange;
		}

		/**
		 * 目标受到伤害
		 */
		protected function targetHurt() : void
		{
			if (_target != null)
			{
				log(host, '\t攻击\t', _target, '\t伤害\t', damage);
				_target.HP -= damage;
				if (_target.HP <= 0)
					_target.dead();
			}
		}

		/**
		 *
		 * @param value
		 */
		protected function setTarget(value : Character) : void
		{
			if (value == _target)
				return;
			if (_target)
				_target.removeEventListener(CharacterEvent.DEAD, onTargetDead);
			_target = value;
			if (_target)
				_target.addEventListener(CharacterEvent.DEAD, onTargetDead);
		}

		/**
		 * 攻击目标
		 * @return
		 */
		public function get target() : Character
		{
			return _target;
		}

		/**
		 * 当目标死亡后的动作，默认是站立不动
		 */
		protected function onTargetDead(event : Event) : void
		{

		}

		/**
		 *
		 * @default 5
		 */
		public function get damage() : Number
		{
			return _damage;
		}

		/**
		 * @private
		 */
		public function set damage(value : Number) : void
		{
			_damage = value;
		}

		/**
		 *
		 * @default 70
		 */
		public function get attackRange() : Number
		{
			return _attackRange;
		}

		/**
		 * @private
		 */
		public function set attackRange(value : Number) : void
		{
			_attackRange = value;
		}

	}
}
