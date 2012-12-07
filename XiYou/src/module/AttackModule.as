package module
{
	import character.Pawn;
	import character.ComplexPawn;
	import character.PawnEvent;

	import utils.EventUtils;
	import utils.MathUtils;
	import utils.SpriteUtils;

	import flash.geom.Point;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	public class AttackModule
	{
		protected var host : ComplexPawn;
		protected var atkDelay : uint;
		protected var destination : Point;
		protected var startPos : Point;

		public function AttackModule(host : ComplexPawn)
		{
			this.host = host;
		}

		public function attack(target : ComplexPawn) : void
		{
			// var targetGPos : Point = SpriteUtils.position(target);//target.localToGlobal(new Point());
			// var attackerGPos : Point = SpriteUtils.position(host);//host.localToGlobal(new Point());
			startPos = SpriteUtils.position(host);
			destination = SpriteUtils.position(target);
			// .add(targetGPos.subtract(attackerGPos));
			destination.x += startPos.x > destination.x ? 100 : -100;
			if (host.isArcher)
			{
				// TODO 远程角色也要加入暴击
				host.attack([target]);
			}
			else
			{
				moveToAtkPos(target, destination);
			}
		}

		protected function moveToAtkPos(target : ComplexPawn, destination : Point) : void
		{
			if (host.attr.jumpAttack)
			{
				var mid : Point = MathUtils.middlePt(SpriteUtils.position(host), destination);
				host.moveTo(mid, function() : void
				{
					atkDelay = setTimeout(function() : void
					{
						attackThanReturn(target);
					}, 400);
					host.jumpTo(destination.x, destination.y, 120);
				});
			}
			else
			{
				host.moveTo(destination, function() : void
				{
					host.turnTo(target.x);
					attackThanReturn(target);
				});
			}
			// switch(attacker.name) {
			// case 'XiaoQiBing':
			//					//  TODO
			//					//  EmbededSound.play(SoundResource.instance.knight_start);
			// break;
			// default:
			// }
		}

		protected function attackThanReturn(target : ComplexPawn) : void
		{
			if (target.HP <= 0)
			{
				targetDeadBeforeAttack();
				return;
			}
			var tx : Number = target.x;
			host.addEventListener(PawnEvent.ATTACK_COMPLETE, function() : void
			{
				host.removeEventListener(PawnEvent.ATTACK_COMPLETE, arguments.callee);
				host.moveTo(startPos, function() : void
				{
					// host.alliance == 'Enemy' ? host.turnLeft() : host.turnRight();
					host.turnTo(tx, true);
				});
			});

			doAttack(target);
		}

		protected function targetDeadBeforeAttack() : void
		{
			host.moveTo(startPos);
		}

		protected function doAttack(target : Pawn) : void
		{
			host.attack([target]);
		}
	}
}
