package module
{
	import character.FrameLabels;
	import charactersOld.FreeCombatant;
	import com.greensock.TweenMax;
	use namespace status;





	public class Rage extends Action
	{
		private var host : FreeCombatant;
		private var anim : TweenMax;

		public function Rage(host : FreeCombatant)
		{
			this.host = host;
			super('rage');
		}

		override status function start() : void
		{
			anim = host.play({frames: [FrameLabels.S_START, FrameLabels.S_ATTACK], loop: false, onComplete: complete, onUpdate: function(frame : String, i : int) : void
			{
				if (host.enemy)
				{
					if (frame == FrameLabels.S_ATTACK && i == 5)
					{
						host.enemy.hurt(host.attr.getDamage(host.enemy.attr) * 5);
					}
				}
			}});
		}

		override status function abort() : void
		{
			anim.kill();
		}

		override status function pause() : void
		{
			anim.pause();
		}

		override status function resume() : void
		{
			anim.resume();
		}
	}
}
