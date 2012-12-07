package module.combat
{

	import character.FrameLabels;
	import charactersOld.Character;
	import charactersOld.CharacterEvent;
	import charactersOld.FreeCombatant;
	import charactersOld.Slot;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.easing.Sine;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import global.Global;
	import module.Action;
	import module.status;
	import utils.ArrayUtils;
	import utils.MathUtils;
	import utils.SpriteUtils;

	use namespace status;







	public class Combat extends Action
	{
		protected var host : FreeCombatant;
		private var _enemy : FreeCombatant;
		private var _attacking : Boolean;
		private var checkInterval : uint;
		private var getEnemyFunc : Function;


		protected var getEnemiesFunc : Function;
		private var checkInrangeInterval : uint;
		private var attackRange : Number;
		private var fireDuration : Number;
		private var hurtDuration : Number;
		private var rage : Boolean;
		private var anim : TweenMax;
		private var interval : uint;
		private var following : Boolean;
		private var hurt : TweenLite;
		private var nextAttackDelay : TweenLite;
		private var dummy : Object = {};

//		private var i : int = 0;

		public function Combat(host : FreeCombatant, getEnemiesFunc : Function)
		{
			this.getEnemiesFunc = getEnemiesFunc;
			this.host = host;
			attackRange = host.attackRange;
			fireDuration = host.fireDuration;
			hurtDuration = host.hurtDuration;
			host.addEventListener(CharacterEvent.DEAD, onHostDead);

			super('attack');

			interval = setInterval(check, 250);
			startCheckInrage();
		}

		private function check() : void
		{
//			trace(host.name, 'attacking:', _attacking, 'enemy:', enemy);
			if (enemy == null || _attacking)
				return;
			var bInRange : Boolean;
			var theSlot : Slot;
			if (host.isArcher)
			{
				bInRange = inRange();
			}
			else
			{
				var slots : Array = enemy.slots.concat();
				theSlot = ArrayUtils.selectOne(slots, function(slot : Slot) : Boolean
				{
					return slot.occupier == host;
				});
				if (theSlot == null)
				{
					var enemySlot : Slot = ArrayUtils.selectOne(host.slots, function(mySlot : Slot) : Boolean
					{
						return mySlot.occupier == enemy;
					});
					var mySlotIdx : int = host.slots.indexOf(enemySlot);
					if (mySlotIdx != -1)
					{
						theSlot = enemy.slots[mySlotIdx > 1 ? mySlotIdx - 2 : mySlotIdx + 2];
						theSlot.occupier = host;
					}
				}
				if (theSlot == null)
				{
					slots.sort(function(a : Slot, b : Slot) : int
					{
						return MathUtils.distance(host.x, host.y, a.postion.x, a.postion.y) - MathUtils.distance(host.x, host.y, b.postion.x, b.postion.y);
					});
					theSlot = ArrayUtils.selectOne(slots, function(slot : Slot) : Boolean
					{
						return slot.occupier == null;
					});
					theSlot.occupier = host;
				}
				bInRange = MathUtils.distance(host.x, host.y, theSlot.postion.x, theSlot.postion.y) < 10;
			}
			if (bInRange)
			{
				host.stopFollow();
				following = false;
				host.turnTo(enemy.x);
				host.attack();
			}
			else if (!following)
			{
				following = true;
				host.follow(host.isArcher ? enemy : theSlot.postion);
			}
		}

		public function startCheckInrage() : void
		{
			stopCheckInrange();
			checkInrangeInterval = setInterval(checkInrange, Global.hurtDelay);
		}

		public function stopCheckInrange() : void
		{
			clearInterval(checkInrangeInterval);
		}

		private function checkInrange() : void
		{
			if (enemy != null)
				return;
//			log('enemy:', enemy);
			var target : FreeCombatant = (getEnemiesFunc() as Array).filter(selectInrangeEnemy)[0];
			if (target)
			{
				attack(target);
			}
		}

		private function selectInrangeEnemy(enemy : FreeCombatant, ... rest) : Boolean
		{
			return MathUtils.distance(host.x, host.y, enemy.x, enemy.y) <= attackRange;
		}

		protected function onHostDead(event : Event) : void
		{
			enemy = null;
			clearInterval(interval);
			stopCheckInrange();
		}

		public function attack(target : FreeCombatant) : void
		{
//			trace(host.name, enemy == target, 'enemy:', enemy);
			if (this.enemy == target)
				return;
			this.enemy = target;
		}

		private function inRange() : Boolean
		{
			return host.isArcher ? MathUtils.distance(host.x, host.y, enemy.x, enemy.y) <= attackRange : Math.abs(int(host.x - enemy.x)) <= attackRange && Math.abs(int(host.y - enemy.y)) <= 30;
		}

		override status function start() : void
		{
			if (enemy == null)
			{
				super.complete();
				return;
			}
//			i++;
			_attacking = true;
			var dmg : Number = host.getDamage(enemy.attr);
			if (rage)
			{
				dmg *= 5;
				rage = false;
			}
//			log(host.name, '\t攻击', target.name, '\t造成伤害', dmg);

			anim = host.play({frames: [FrameLabels.ATTACK], loop: false, onComplete: complete});
			anim.data = '>attack<';
			var __enemy : FreeCombatant = enemy;

			var projectle : MovieClip = host.projectle;
			if (projectle)
			{
				projectle.scaleX = host.orientation * -1;
				projectle.x = host.x + 40 * host.orientation;
				projectle.y = host.y - 40;
				var ang : Number = MathUtils.anglePt(host.x, host.y, __enemy.x, __enemy.y);
				if (host.x > __enemy.x)
					ang += 180;
				projectle.rotation = ang;
				projectle.visible = true;
				projectle.gotoAndPlay('flight');
				hurt = TweenLite.to(projectle, host.flyDuration / 1000, {ease: Sine.easeOut, x: __enemy.x, y: __enemy.y - 40, onUpdate: function() : void
				{
					if (int(Math.abs(projectle.x - __enemy.x) < 30))
					{
						hurt.complete();
					}
				}, onComplete: function() : void
				{
					if (projectle.totalFrames > 12)
						projectle.gotoAndPlay('disappear');
					__enemy.hurt(dmg);
					projectle.visible = false;
				}});
			}
			else
			{
				hurt = TweenLite.to(dummy, (host.isArcher ? host.flyDuration : Global.hurtDelay) / 1000, {onComplete: function() : void
				{
					__enemy.hurt(dmg);
				}});
			}
			nextAttackDelay = TweenLite.to(dummy, fireDuration / 1000, {onComplete: function() : void
			{
				_attacking = false;
			}});
		}

		override status function complete(... args) : void
		{
//			i--;
			anim.kill();
			anim = null;
			super.complete();
		}

		override status function abort() : void
		{
//			i--;
//			trace(host.name, 'abort', i);
			anim.kill();
			if (!host.isArcher)
				hurt.kill();
			nextAttackDelay.restart();
			_attacking = false;
		}

		public function get enemy() : FreeCombatant
		{
			return _enemy;
		}

		public function set enemy(value : FreeCombatant) : void
		{
			if (_enemy == value)
				return;
			if (_enemy)
			{
				var slot : Slot = ArrayUtils.selectOne(_enemy.slots, function(slot : Slot) : Boolean
				{
					return slot.occupier == host
				})
				if (slot)
				{
					slot.occupier = null;
				}
				_enemy.removeEventListener(CharacterEvent.DEAD, onTargetDead);
			}
			_enemy = value;
			if (_enemy)
				_enemy.addEventListener(CharacterEvent.DEAD, onTargetDead);
			else
			{
				stopAttack();
			}
		}

		private function stopAttack() : void
		{
			following = false;
			host.stopFollow();
			_attacking = false;
			if (nextAttackDelay)
				nextAttackDelay.kill();
		}

		protected function onTargetDead(event : Event) : void
		{
			enemy = null;
		}
	}
}
