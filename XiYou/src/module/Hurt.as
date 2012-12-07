package module
{
	import character.FrameLabels;
	import charactersOld.FreeCombatant;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import flash.display.MovieClip;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import global.Global;
	use namespace status;






	public class Hurt extends Action
	{
		private var host : FreeCombatant;
		private var hitFlash : MovieClip;
		private var anim : TweenMax;

		public function Hurt(host : FreeCombatant)
		{
			this.host = host;
			super('hurt');

			hitFlash = host.alliance == 'Player' ? new HitFlashBlue : new HitFlashRed;
			hitFlash.stop();
			hitFlash.y = -45;
			hitFlash.alpha = 0;
			host.addChild(hitFlash);
		}

		override status function start() : void
		{
//			trace(host.name, 'hurt start');
			anim = host.play({frames: [FrameLabels.HURT], loop: false, onComplete: complete});
			anim.data = '>hurt<';
			hitFlash.gotoAndStop(0);
			TweenMax.to(hitFlash, 10 / Global.FPS, {ease: Sine.easeOut, scaleX: 1.5, scaleY: 2, alpha: 1, repeat: 1, yoyo: true, onUpdate: hitFlash.nextFrame});
		}

		override status function complete(... args) : void
		{
//			trace('hurt complete', getTimer());
			anim.kill();
			super.complete();
		}

		override status function pause() : void
		{
			anim.pause();
		}

		override status function resume() : void
		{
			anim.resume();
		}

		override status function abort() : void
		{
			anim.kill();
		}
	}
}
