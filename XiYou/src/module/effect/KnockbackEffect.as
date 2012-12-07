package module.effect
{
	import character.Pawn;
	import character.PawnEvent;

	import utils.EventUtils;
	import utils.SpriteUtils;

	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.geom.Point;

	/**
	 * @author Chenzhe
	 */
	public class KnockbackEffect
	{
		private var originPos : Point;

		public function KnockbackEffect(host : Pawn)
		{
			host.addEventListener(PawnEvent.HURT, function(evt : PawnEvent) : void
			{
				originPos ||= SpriteUtils.position(host);
				if (evt.HP == 0)
				{
					EventUtils.careOnce(host, PawnEvent.DISPOSE, function() : void
					{
						host.x = originPos.x;
						host.y = originPos.y;
					});
				}
				TweenMax.to(host, .1, {ease:Sine.easeIn, x:host.x + (20 + 40 * (evt.damage / evt.fullHP)) * host.orientation, repeat:evt.HP > 0 ? 1 : 0, yoyo:evt.HP > 0, onComplete:function() : void
				{
					if (host.HP > 0)
					{
						host.x = originPos.x;
						host.y = originPos.y;
					}
				}});
			});
		}
	}
}
