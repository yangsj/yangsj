package module
{
	import character.Pawn;

	import com.greensock.TweenNano;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;

	/**
	 * @author Chenzhe
	 */
	public class RageEffectView extends Sprite
	{
		public function showEffect(pawn : Pawn, onComplete : Function) : void
		{
			try
			{
				var effect : Bitmap = new Bitmap((new (getDefinitionByName('rage.' + pawn.name))) as BitmapData);
				effect.x = effect.width;
				effect.y = 220;
				addChild(effect);
				TweenNano.to(effect, .5, {x:-80});
				setTimeout(function() : void
				{
					TweenNano.to(effect, .5, {x:-effect.width, onComplete:onComplete});
				}, 750);
			}
			catch(err : *)
			{
				setTimeout(onComplete, 1000);
				trace(pawn.name, '没有暴怒的卡片.');
			}
		}
	}
}
