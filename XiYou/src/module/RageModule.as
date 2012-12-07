package module
{
	import character.Pawn;
	import character.PawnEvent;
	/**
	 * @author Chenzhe
	 */
	public class RageModule
	{
		private var host : Pawn;
		private var _numRage : Number = 0;

		public function RageModule(host : Pawn)
		{
			this.host = host;
			host.addEventListener(PawnEvent.ATTACK_COMPLETE, onAtkComplete);
		}

		private function onAtkComplete(event : PawnEvent) : void
		{
			numRage += event.damage * .6;
		}

		public function set numRage(numRage : Number) : void
		{
			_numRage = numRage;
			host.dispatchEvent(new PawnEvent(PawnEvent.RAGE_UPDATE, 0, _numRage));
		}

		public function get numRage() : Number
		{
			return _numRage;
		}

		public function get available() : Boolean
		{
			var b : Boolean = host.HP > 0 && numRage >= host.HP;
			if (b) numRage = 0;
			return b;
		}
	}
}
