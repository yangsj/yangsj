package module
{
	import character.ComplexPawn;
	import character.Pawn;
	import character.PawnEvent;

	import utils.EventUtils;
	import utils.SpriteUtils;

	import com.greensock.TweenLite;

	/**
	 * @author Chenzhe
	 */
	public class PlayerAttackModule extends AttackModule
	{
		private var rage : Boolean;
		private var effectLayer : RageEffectView;
		private var players : Array;
		public var timeout_turn : TweenLite;

		public function PlayerAttackModule(host : ComplexPawn, players : Array, effectLayer : RageEffectView)
		{
			this.players = players;
			this.effectLayer = effectLayer;
			this.host = host;
			super(host);
		}

		override public function attack(target : ComplexPawn) : void
		{
			rage = false;
			if (host.extra.rage)
				rage = host.extra.rage.available;

			var superAttack : Function = super.attack;
			if (rage)
			{
				EventUtils.careOnce(host, PawnEvent.RAGE_START_COMPLETE, function() : void
				{
					effectLayer.showEffect(host, function() : void
					{
						superAttack(target);
					});
				});

				if (timeout_turn)
					timeout_turn.pause();
				for each (var player : Pawn in players)
				{
					if (player != host)
						player.pause();
				}
				host.rageStart();
			}
			else
			{
				super.attack(target);
			}
		}

		override protected function targetDeadBeforeAttack() : void
		{
			if (rage)
				resume();
			super.targetDeadBeforeAttack();
		}

		private function resume() : void
		{
			timeout_turn.resume();
			for each (var player : Pawn in players)
			{
				if (player != host)
					player.resume();
			}
		}

		override protected function doAttack(target : Pawn) : void
		{
			if (rage)
			{
				host.attack([target], true, 2.5);
				host.addEventListener(PawnEvent.ATTACK_COMPLETE, function() : void
				{
					host.removeEventListener(PawnEvent.ATTACK_COMPLETE, arguments.callee);
					resume();
				});
			}
			else
			{
				// 暴击
				if (Math.random() < 0.2)
				{
					var criticalEffent : CriticalAnim = new CriticalAnim();
					criticalEffent.x = -90;
					criticalEffent.y = -192;
					criticalEffent.addFrameScript(criticalEffent.totalFrames - 1, function() : void
					{
						criticalEffent.stop();
						SpriteUtils.safeRemove(criticalEffent);
						criticalEffent = null;
						host.attack([target], false, 1.5);
						// TODO
						// EmbededSound.play(SoundResource.instance.critical_attack);
					});
					host.addChild(criticalEffent);
				}
				else
					host.attack([target]);
			}
		}
	}
}
