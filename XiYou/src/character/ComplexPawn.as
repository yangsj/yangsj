package character
{
	import flash.geom.Point;

	import test.AdvanceMC;

	import flash.display.MovieClip;

	/**
	 * @author Chenzhe
	 */
	public class ComplexPawn extends Pawn
	{
		public var attr : PawnAttr;

		public function ComplexPawn(charId : String, scale : Number = 1.5, lv : Number = 1, mcOffest : Point = null, cacheFrames : Vector.<String> = null)
		{
			attr = Attrs.instance.getAttrById(charId);
			attr.level = lv;
			var mc : MovieClip = (new attr.uiClass) as MovieClip;
			mc.scaleX = mc.scaleY = scale;
			cacheFrames ||= Vector.<String>(['stand', 'walk', 'attack', 'hurt', 's_start', 's_attack', 'dead1']);
			var amc : AdvanceMC = new AdvanceMC(mc, cacheFrames);
			if (mcOffest)
			{
				amc.x += mcOffest.x;
				amc.y += mcOffest.y;
			}
			if (attr.projectileClass != null)
				projectile = ((new attr.projectileClass) as MovieClip);
			super(amc);
		}

		override public function get HP() : Number
		{
			return attr.HP;
		}

		override public function set HP(hP : Number) : void
		{
			if (hP > fullHP)
				hP = fullHP;
			attr.HP = hP;
			dispatchEvent(new PawnEvent(PawnEvent.HP_UPDATE, 0, 0, hP, fullHP));
		}

		override public function get fullHP() : Number
		{
			return attr.fullHP;
		}

		override protected function damageCalc(target : Pawn) : Number
		{
			return attr.getDamage((target as ComplexPawn).attr);
		}
	}
}
