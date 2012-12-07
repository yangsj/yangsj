package module.effect
{
	import character.Pawn;
	import character.PawnEvent;

	import utils.SpriteUtils;

	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.easing.Elastic;

	import flash.display.Sprite;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	public class ScatEffect
	{
		public function ScatEffect(host : Pawn, layer : Sprite)
		{
			var _mie : mie = new mie();
			var dic_effect_class_on_attack : * = {ShanShen:hong, HuangShiJing:hong, ZhuBaJie:hong, BullKing:hong, XiaoQiBing:dong, MoLiSou:dong, SaShen:dong, TaiShangLaoJun:dong, TuoTaLiTianWang:guang, TangSanZang:guang, SunWuKong:guang, XiaBin:peng, JingXiLingLi:peng, TianBing:peng, MoLiHai:peng, MoLiQing:peng, RedBoy:peng, XiaoGongShou:sou, BaiGuFuRen:sou, TieShanGongZhu:sou, MoLiHong:sou};
			function show(effect : Sprite) : void
			{
				effect.x = host.x;
				effect.y = host.y - 180;
				effect.alpha = 0;
				effect.scaleX = 0;
				effect.scaleY = 0;
				// TweenNano.to(effect, 1, {y:effect.y - 150});
				TweenNano.to(effect, 1, {scaleX:1, scaleY:1, ease:Elastic.easeOut});
				TweenMax.to(effect, .4, {alpha:1.5, repeat:1, yoyo:true});
				layer.addChild(effect);
				setTimeout(function() : void
				{
					SpriteUtils.safeRemove(effect);
				}, 1000);
			}
			host.addEventListener(PawnEvent.DEAD, function() : void
			{
				show(_mie);
			});
			host.addEventListener(host.isArcher ? PawnEvent.ATTACK_START : PawnEvent.ATTACK, function(evt : PawnEvent) : void
			{
				if (host.isArcher || evt.damage > 0)
					show(dic_effect_class_on_attack[host.name] ? new dic_effect_class_on_attack[host.name] : new hong);
			});
		}
	}
}
