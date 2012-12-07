package charactersOld
{

	import character.PawnAttr;
	import module.combat.AICombat;


	public class AIFreeCombatant extends FreeCombatant
	{
		public function AIFreeCombatant(attr : PawnAttr, getEnemiesFunc : Function)
		{
			super(attr, getEnemiesFunc);
		}

		override protected function initCombat(getEnemiesFunc : Function) : void
		{
			combat = new AICombat(this, getEnemiesFunc);
		}
	}
}
