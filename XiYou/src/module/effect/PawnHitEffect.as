package module.effect
{
	import character.Pawn;
	import character.PawnEvent;

	import utils.SpriteUtils;

	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import flash.display.MovieClip;
	/**
	 * @author Chenzhe
	 */
	public class PawnHitEffect
	{
		private var host : Pawn;

		public function PawnHitEffect(host : Pawn)
		{
			this.host = host;
			var hitFlash : MovieClip = host.alliance == 'Player' ? new HitFlashBlue : new HitFlashRed;
			hitFlash.stop();
			hitFlash.y = -55;
			hitFlash.alpha = 0;

			host.addEventListener(PawnEvent.HURT, function() : void
			{
				hitFlash.gotoAndStop(0);
				host.addChild(hitFlash);
				TweenMax.to(hitFlash, .5, {ease:Sine.easeOut, scaleX:1.5 * Math.abs(host.scaleX), scaleY:2 * host.scaleY, alpha:1, repeat:1, yoyo:true, onUpdate:hitFlash.nextFrame, onComplete:function() : void
				{
					SpriteUtils.safeRemove(hitFlash);
				}});
			});
		}
	}
}
