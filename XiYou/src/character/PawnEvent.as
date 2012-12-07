package character
{
	import flash.events.Event;

	/**
	 * @author Administrator
	 */
	public class PawnEvent extends Event
	{
		public static const ATTACK_COMPLETE : String = 'attack_complete';
		public static const HURT : String = 'HURT';
		public static const ARRIVAL : String = 'arrival';
		public static const DISPOSE : String = 'dispose';
		public static const RAGE_START_COMPLETE : String = 'rage_start_complete';
		public static const RAGE_UPDATE : String = "RAGE_UPDATE";
		public static const DEAD : String = "dead";
		public static const ATTACK : String = "ATTACK";
		public static const ATTACK_START : String = "ATTACK_START";
		public static const RAGE_START : String = "RAGE_START";
		public static const RAGE_ATTACK : String = "RAGE_ATTACK";
		public static const HP_UPDATE : String = "HP_UPDATE";
		public var damage : Number;
		public var rageNum : Number;
		public var HP : Number;
		public var fullHP : Number;

		public function PawnEvent(type : String, damage : Number = 0, rageNum : Number = 0, HP : Number = 0, fullHP : Number = 0)
		{
			this.fullHP = fullHP;
			this.HP = HP;
			this.rageNum = rageNum;
			this.damage = damage;
			super(type);
		}
	}
}
