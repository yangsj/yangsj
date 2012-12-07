package charactersOld
{

	import character.PawnAttr;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import interfaces.IRushCombatant;
	import module.combat.RangedRushCombatModule;
	import module.combat.RushCombatModule;
	import utils.SpriteUtils;





	public class RushCombatant extends BasicCombatant implements IRushCombatant
	{
		protected var combat : RushCombatModule;
		private var projectle : MovieClip;
		private var _knockback : Boolean;

		public function RushCombatant(attr : PawnAttr, getEnemiesFunc : Function)
		{
			super(attr);
			if (attr.combatType == 'range')
			{
				projectle = new (attr.projectileClass) as MovieClip;
				this.combat = new RangedRushCombatModule(this, projectle, getEnemiesFunc);
			}
			else
			{
				this.combat = new RushCombatModule(this, getEnemiesFunc);
			}
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		protected function onRemovedFromStage(event : Event) : void
		{
			if (projectle)
				SpriteUtils.safeRemove(projectle);
		}

		override protected function onAddedToStage(event : Event) : void
		{
			if (projectle)
				stage.addChild(projectle);
		}

		override public function set x(val : Number) : void
		{
			if (val <= 50)
				val = 50;
			if (val >= 750)
				val = 750;
			super.x = val;
		}

		public function set level(val : uint) : void
		{
			attr.level = val;
		}

		public function get level() : uint
		{
			return attr.level;
		}

		public function get projectileSpeed() : Number
		{
			return attr.projectileSpeed;
		}

		public function stepAhead() : void
		{
			combat.hostMove();
		}

		public function get combatType() : String
		{
			return attr.combatType;
		}

		public function get knockback() : Boolean
		{
			return _knockback;
		}

		public function set knockback(value : Boolean) : void
		{
			_knockback = value;
		}

		public function check(enemy : RushCombatant) : void
		{
			combat.check(enemy);
		}
	}
}
