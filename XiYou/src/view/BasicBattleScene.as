package view
{

	import com.greensock.TweenNano;

	import flash.display.Sprite;
	import flash.events.Event;

	import global.Global;

	import utils.SpriteUtils;


	public class BasicBattleScene extends Sprite
	{
		protected var logoWin : LogoWin;
		protected var logoFaild : FaildLogo;

		public function BasicBattleScene()
		{
			super();
			logoWin = new LogoWin;
			logoFaild = new FaildLogo;
			logoFaild.x = logoWin.x = 400.15 * Global.standardWidth / 800;
			logoFaild.y = logoWin.y = 127.45 * Global.standardHeight / 480;

			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		}

		protected function onRemoved(event : Event) : void
		{
			SpriteUtils.safeRemove(logoWin);
			SpriteUtils.safeRemove(logoFaild);
		}

		protected function showLogo(logo : Sprite) : void
		{
			logo.scaleX = 0;
			logo.scaleY = 0;
			TweenNano.to(logo, 1.5, {scaleX: 1, scaleY: 1});
			addChild(logo);
		}

		protected function faild() : void
		{
			showLogo(logoFaild);
		}

		protected function win() : void
		{
			showLogo(logoWin);
		}
	}
}
