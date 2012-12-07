package module
{
	import battle.ZhiZhuBaiSi;
	import battle.ZhiZhuNianSi;

	import character.ComplexPawn;
	import character.PawnEvent;

	import utils.ArrayUtils;
	import utils.EventUtils;
	import utils.MathUtils;
	import utils.SpriteUtils;

	import com.greensock.TweenNano;

	import flash.geom.Point;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	public class ZhiZhuJingAttackModule extends AttackModule
	{
		public var players : Array;
		private var zhiZhuSi : ZhiZhuBaiSi;

		public function ZhiZhuJingAttackModule(host : ComplexPawn)
		{
			zhiZhuSi = new ZhiZhuBaiSi();
			zhiZhuSi.x = -55;
			zhiZhuSi.y = -45;

			super(host);
		}

		override public function attack(target : ComplexPawn) : void
		{
			var atkAnim : String = ArrayUtils.random(['attack1', 'attack2', 'attack3']);
			switch(atkAnim)
			{
				case 'attack1':
					host.attack(players, false, 2, atkAnim);
					break;
				case 'attack2':
					super.attack(target);
					break;
				case 'attack3':
					var net : ZhiZhuNianSi = new ZhiZhuNianSi();
					host.setFrameHandler('attack3', 8, function() : void
					{
						if (target.HP > 0)
							target.addChild(net);
						host.addChild(zhiZhuSi);
					});
					host.setFrameHandler('attack3', -2, function() : void
					{
						SpriteUtils.safeRemove(zhiZhuSi);
					});
					var g0 : Point = host.localToGlobal(new Point());
					var g1 : Point = target.localToGlobal(new Point());
					zhiZhuSi.rotation = MathUtils.anglePt(g0.x, g0.y, g1.x, g1.y);
					zhiZhuSi.width = MathUtils.distance(g0.x, g0.y, g1.x, g1.y) + 50;
					host.attack([target], false, 2, atkAnim);
					target.freezed = true;
					setTimeout(function() : void
					{
						target.freezed = false;
						SpriteUtils.safeRemove(net);
					}, 5000);
					break;
			}
		}

		override protected function attackThanReturn(target : ComplexPawn) : void
		{
			host.attack([target], false, 2, 'attack2');
		}

		override protected function moveToAtkPos(target : ComplexPawn, destination : Point) : void
		{
			move(destination, function() : void
			{
				attackThanReturn(target);
				EventUtils.careOnce(host, PawnEvent.ATTACK_COMPLETE, function() : void
				{
					move(startPos, null);
				});
			});
			host.y += 10;
		}

		private function move(to : Point, onArrival : Function) : void
		{
			host.extra.hpBar.visible = false;
			host.setFrameHandler('up', -1, function() : void
			{
				host.stopAnim();
				TweenNano.to(host, .5, {x:to.x, y:to.y, onComplete:host.play, onCompleteParams:[['down']]});
			});
			host.setFrameHandler('down', -1, function() : void
			{
				host.extra.hpBar.visible = true;
				if (onArrival != null)
					onArrival();
			});
			host.play(['up']);
		}
	}
}
