package module
{
	import character.FrameLabels;
	import charactersOld.FreeCombatant;
	import com.greensock.TweenMax;
	use namespace status;




	public class AttackAction extends Action
	{
		private var host : FreeCombatant;
		private var anim : TweenMax;

		public function AttackAction(host : FreeCombatant)
		{
			this.host = host;
			super('attack');
		}

		override status function start() : void
		{
			anim = host.play({frames: [FrameLabels.ATTACK], loop: false, onComplete: complete});
			anim.data = '>attack<';
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
