package module.combat
{

	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import charactersOld.RushCombatant;
	import com.greensock.TweenNano;
	import com.greensock.easing.Linear;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import global.Global;
	import global.Orientation;
	import interfaces.ICombatant;
	import interfaces.IRushCombatant;
	import utils.Heartbeat;
	import utils.MathUtils;







	/**
	 *
	 * @author Chenzhe
	 */
	public class RushCombatModule extends CombatModule
	{


		/**
		 * 击退敌人的距离，要根据最大最小值以及伤害计算
		 * @default
		 */
		protected var knockback : int;

		private var _playAttack : Boolean = false;
		private var step : Number;


		public static var _team1F : Function;
		public static var _team2F : Function;
		private static var interval : uint;
		private static var knockbackFs : Array = [];
		private var tick_targetKnockback : int;
		private var fireAnimDuration : Number;
		private var dectAnimRange : Number;

		/**
		 * 对冲式战斗模块
		 * @param host
		 * @param getEnemiesFunc 获取敌人列表的方法
		 */
		public function RushCombatModule(host : IRushCombatant, getEnemiesFunc : Function)
		{
			super(host, getEnemiesFunc);
			var speed : Number = host.speed;
			step = speed / Global.FPS;
			fireAnimDuration = host.fireAnimDuration;

			dectAnimRange = int(fireAnimDuration * (speed / 1000) - 10);
			if (dectAnimRange < 0)
				dectAnimRange = 0;
			log('攻击动画时长:', host['name'], fireAnimDuration);
			log('提前检测距离:', host['name'], dectAnimRange);
			host.addEventListener(CharacterEvent.DEAD, onHostDead);
		}

		private function onHostDead(evt : CharacterEvent) : void
		{
			host.removeEventListener(CharacterEvent.DEAD, onHostDead);
			setTarget(null);
		}

		public static function start(team1F : Function, team2F : Function) : void
		{
			_team1F = team1F;
			_team2F = team2F;
			interval = setInterval(tick, 1000 / 30);
		}

		public static function stop() : void
		{
			_team1F = null;
			_team2F = null;
			knockbackFs.length = 0;
			clearInterval(interval);
		}

		private static function selectFighter(char : RushCombatant, ... rest) : Boolean
		{
			return char.combatType != 'range';
		}

		private static function selectArcher(char : RushCombatant, ... rest) : Boolean
		{
			return char.combatType == 'range';
		}

		private static function fight(team : Array, enemies : Array, bLeftside : Boolean) : void
		{
			var enemy : RushCombatant = enemies.sortOn('x', Array.NUMERIC | (bLeftside ? 0 : Array.DESCENDING))[0];
			var teamSorted : Array = team.sortOn('x', Array.NUMERIC | (bLeftside ? Array.DESCENDING : 0));
			var fighters : Array = teamSorted.filter(selectFighter);
			var archers : Array = teamSorted.filter(selectArcher);
			if (fighters.length)
			{
				var fighter : RushCombatant = fighters[0];
				fighter.check(enemy);
			}

			for each (var archer : RushCombatant in archers)
			{
				archer.check(enemy)
			}
		}



		private static function tick() : void
		{
			var moveF : Function = function(char : RushCombatant, ... rest) : void
			{
				char.stepAhead();
			};
			var execute : Function = function(f : Function, ... rest) : void
			{
				f();
			};
			var team1 : Array = _team1F();
			var team2 : Array = _team2F();

			if (team1.length == 0 || team2.length == 0)
				return;
			fight(team1, team2, true);
			fight(team2, team1, false);

			knockbackFs.map(execute);
			knockbackFs.length = 0;
			team1.map(moveF);
			team2.map(moveF);
		}


//XXX
		public function hostMove() : void
		{
//			if (!_playAttack)
//			{
//				host.walk();
//			}
//			goStep();
		}

		protected function goStep() : void
		{
			host.x += step * host.orientation;
		}

		protected function gotEnemyInrange(target : RushCombatant) : void
		{
			gotEnemyInAnimRange(target);
//			log(host['name'], target.name, IRushCombatant(host).knockback, target.knockback);
			if (IRushCombatant(host).knockback || target.knockback)
				return;
//XXX			host.stop();
			setTarget(target);
			fire();
		}

		protected function playAttackAnim() : void
		{
			_playAttack = true;
//XXX			host.attack();
			Heartbeat.instance.addOnTick(function() : void
			{
				_playAttack = false;
			}, fireAnimDuration);
		}

		/**
		 *
		 */
		protected function fire() : void
		{
			// 目标伤血
			targetHurt();
			// 击退目标
			knockbackFs.push(knockbackTarget);
			// 因为远程目前不击退，所以攻击远程自己会后退
			if (IRushCombatant(_target).isArcher)
			{
				IRushCombatant(host).knockback = true;
				knockbackFs.push(knockbackSelf);
			}
		}

		override protected function targetHurt() : void
		{
			if (_target.HP <= 0)
				return;
			calculateKnockback();
			log(host, '\t攻击\t', _target, '\t伤害\t', damage);
			_target.HP -= damage;
			log('--------------------------------------------------------------------');
		}

		/**
		 * 计算击退距离
		 */
		protected function calculateKnockback() : void
		{
			var factor : Number = damage / _target.HP;
			if (factor > 1)
				factor = 1;
			knockback = damage >= target.HP ? Global.knockbackOnDead : MathUtils.chop(Global.knockbackScale * factor, Global.knockbackMin, Global.knockbackMax);
			log(_target.name, '伤血:', damage, '/', _target.HP, '击退:', knockback);
		}

		override protected function onTargetDead(event : Event) : void
		{
			log(host, '\t杀死\t', _target);
			Heartbeat.instance.remove(tick_targetKnockback);
			setTarget(null);
		}

		/**
		 *
		 */
		protected function knockbackTarget() : void
		{
			if (_target == null)
				return;
			var tar : Character = _target;
			var tx : Number = tar.x;
			knockback -= 10;
			tar.x = tx - 10 * tar.orientation;
			IRushCombatant(tar).knockback = true;
			tick_targetKnockback = Heartbeat.instance.tween(tar, Global.knockbackTime, {x: tar.x - knockback * tar.orientation, onComplete: function() : void
			{
				IRushCombatant(tar).knockback = false;
				if (tar.HP <= 0)
					tar.dead();
			}});
		}

		protected function knockbackSelf() : void
		{
			var hx : Number = host.x;
			host.x = hx - 10 * host.orientation;
			IRushCombatant(host).knockback = true;
			Heartbeat.instance.tween(host, Global.knockbackTime, {x: host.x - 90 * host.orientation, onComplete: function() : void
			{
				IRushCombatant(host).knockback = false;
			}});
		}

		override public function get damage() : Number
		{
			return IRushCombatant(host).getDamage(RushCombatant(_target).attr);
		}

		override public function get attackRange() : Number
		{
			return IRushCombatant(host).attackRange;
		}

		protected function gotEnemyInAnimRange(target : RushCombatant) : void
		{
//			log(host['name'], _playAttack, IRushCombatant(host).knockback, target.knockback);
			if (_playAttack || IRushCombatant(host).knockback || target.knockback)
				return;
			_playAttack = true;
//xxx			host.attack();
			Heartbeat.instance.addOnTick(function() : void
			{
				_playAttack = false;
			}, fireAnimDuration);
		}

		public function check(enemy : RushCombatant) : void
		{
			var dist : Number = Math.abs(int(host.x - enemy.x));
			if (dist <= IRushCombatant(host).attackRange)
			{
				gotEnemyInrange(enemy);
			}
			else if (dist <= IRushCombatant(host).attackRange + dectAnimRange)
			{
				gotEnemyInAnimRange(enemy);
			}
		}
	}
}
