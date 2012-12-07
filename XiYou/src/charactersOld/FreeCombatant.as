package charactersOld
{

	import character.FrameLabels;
	import character.PawnAttr;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.clearTimeout;
	import flash.utils.getDefinitionByName;
	import global.Global;
	import module.HPBar;
	import module.Hurt;
	import module.Rage;
	import module.Rule;
	import module.combat.Combat;
	import utils.MathUtils;





	public class FreeCombatant extends BasicCombatant
	{
		protected var combat : Combat;

		private var hurtTimeout : uint;

		public static var AttackRangeMin : Number = 110;

		public static var FireDuration : Number = 2000;

		public var projectle : MovieClip;

		public var moveZone : Rectangle;

		private var bRage : Boolean;

		private var mouseHitShape : HitShape;

		private var timeoutWalkpaused : uint;

		// ACTION ------------------------------------------------------
		private var hurtAction : Hurt;

		private var rage : Rage;


		private const slotOffsets : Array = [new Point(85, 15), new Point(-60, 15), new Point(-85, -15), new Point(60, -15)];

		public var slots : Array = [new Slot, new Slot, new Slot, new Slot];


		public function FreeCombatant(attr : PawnAttr, getEnemiesFunc : Function, alliance : String = 'Enemy')
		{
			this.alliance = alliance;
			mouseHitShape = new HitShape();
			mouseHitShape.visible = false;
			addChild(mouseHitShape);
			super(attr);
			if (isArcher)
			{
				projectle = new (attr.projectileClass) as MovieClip;
				projectle.visible = false;
			}
			initCombat(getEnemiesFunc);

			//XXX new HPBar(this);

			hurtAction = new Hurt(this);
			rage = new Rage(this);

			stats.makeRules('rage', 'dead', Rule.KILL);
			stats.makeRules('rage', 'walk', Rule.WAIT);

			stats.makeRules('walk', 'hurt', Rule.KILL_RESTART);
			stats.makeRules('walk', 'attack', Rule.KILL);
			stats.makeRules('walk', 'rage', Rule.KILL);

			stats.makeRules('attack', 'walk', Rule.WAIT);
			stats.makeRules('attack', 'hurt', Rule.KILL_RESTART);
			stats.makeRules('attack', 'dead', Rule.KILL);
			stats.makeRules('attack', 'rage', Rule.KILL);
			stats.makeRules('attack', 'rage', Rule.WAIT);

			stats.makeRules('hurt', 'dead', Rule.KILL);
			stats.makeRules('hurt', 'attack', Rule.WAIT);
			stats.makeRules('hurt', 'hurt', Rule.KILL);
			stats.makeRules('hurt', 'walk', Rule.WAIT);
			stats.makeRules('hurt', 'rage', Rule.KILL);

			hurtAction.addEventListener(Event.COMPLETE, playStand);
			rage.addEventListener(Event.COMPLETE, playStand);
			combat.addEventListener(Event.COMPLETE, playStand);

			walk.addEventListener(Event.COMPLETE, onWalkComplete);
		}

		protected function onWalkComplete(event : Event) : void
		{
			combat.startCheckInrage();
		}

		override protected function onAddedToStage(event : Event) : void
		{
			if (isArcher)
				parent.addChild(projectle);
		}

		public function enrage() : void
		{
			requestAction(rage);
		}

		override public function hitTestPoint(x : Number, y : Number, shapeFlag : Boolean = false) : Boolean
		{
			return mouseHitShape.hitTestPoint(x, y, shapeFlag);
		}

		protected function initCombat(getEnemiesFunc : Function) : void
		{
			combat = new Combat(this, getEnemiesFunc);
		}

		public function hurt(damage : Number) : void
		{
			if (attr.HP <= 1)
				return;
			attr.HP -= damage;
			requestAction(hurtAction);
			dispatchEvent(new CharacterEvent(CharacterEvent.HURT));
			if (attr.HP <= 1)
				dead();
		}

		override public function dead() : void
		{
			clearTimeout(hurtTimeout);
			super.dead();
		}

		override public function moveToPos(_x : Number, _y : Number) : void
		{
			combat.enemy = null;
			combat.stopCheckInrange();
			super.moveToPos(_x, _y);
		}

		override public function get attackRange() : Number
		{
			var r : Number = super.attackRange;
			return r < AttackRangeMin ? AttackRangeMin : r;
		}

		public function follow(target : *) : void
		{
			walk.destination = target;
			requestAction(walk);
		}

		public function attackTarget(target : FreeCombatant) : void
		{
			combat.attack(target);
		}

		public function stopFollow() : void
		{
			walk.destination = null;
		}

		override public function get fireDuration() : Number
		{
			return FireDuration; //attr.fireDuration;
		}

		public function get target() : Character
		{
			return combat.enemy;
		}

		public function playingAttack() : Boolean
		{
			return anim.currentFrame == FrameLabels.ATTACK;
		}

		public function playingHurt() : Boolean
		{
			return anim.currentFrame == FrameLabels.HURT;
		}

		public function playingRage() : Boolean
		{
			return anim.currentFrame == FrameLabels.S_START || anim.currentFrame == FrameLabels.S_ATTACK;
		}

		public function get hurtDuration() : Number
		{
			return anim.getAnimInfo(FrameLabels.HURT).duration;
		}

		public function get flyDuration() : Number
		{
			return MathUtils.distance(x, y, target.x, target.y) * .8 + Global.hurtDelay;
		}

		private function get left() : Number
		{
			return moveZone ? moveZone.x : -Infinity;
		}

		private function get right() : Number
		{
			return moveZone ? moveZone.x + moveZone.width : Infinity;
		}

		private function get top() : Number
		{
			return moveZone ? moveZone.y : -Infinity;
		}

		private function get bottom() : Number
		{
			return moveZone ? moveZone.y + moveZone.height : Infinity;
		}

		override public function set x(value : Number) : void
		{
			super.x = MathUtils.chop(value, left, right);
		}

		override public function set y(value : Number) : void
		{
			if (value < 50 && x < 50)
				throw 1
			super.y = MathUtils.chop(value, top, bottom);
		}

		public function get level() : int
		{
			return attr.level;
		}

		public function set level(value : int) : void
		{
			attr.level = value;
		}

		public function attack() : void
		{
			requestAction(combat)
		}

		override protected function onWalkUpdate() : void
		{
			for (var i : * in slots)
			{
				var slot : Slot = slots[i];
				slot.postion.x = x + slotOffsets[i].x;
				slot.postion.y = y + slotOffsets[i].y;
			}
			super.onWalkUpdate();
		}

		public function get enemy() : FreeCombatant
		{
			return combat.enemy;
		}

	}
}
