package module
{
	import character.Pawn;
	import character.PawnEvent;

	import charactersOld.CharacterEvent;

	import com.greensock.TweenNano;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;

	public class HPBar extends Sprite
	{
		private var background : Shape;
		private var HPLayer : Shape;
		private var HPLayer1 : Shape;
		private var host : Sprite;
		private var maxWidth : Number = 40;
		// 60.1;
		private var rageLayer : Shape;
		private var barHeight : Number = 3;

		public function HPBar(host : Pawn, hpColor : uint = 0x00ff00)
		{
			super();
			this.host = host;
			host.addEventListener(PawnEvent.HP_UPDATE, onHPUpdate);
			host.addEventListener(PawnEvent.RAGE_UPDATE, onRageUpdate);
			// visible = false;
			cacheAsBitmap = true;

			background = new Shape();
			background.graphics.beginFill(0);
			background.graphics.drawRect(0, 0, maxWidth, barHeight);

			rageLayer = new Shape();
			rageLayer.graphics.beginFill(0x355EFF);
			rageLayer.graphics.drawRect(0, 0, maxWidth, barHeight);
			rageLayer.width = 0;

			HPLayer = new Shape();
			HPLayer.graphics.beginFill(hpColor);
			// HPLayer.graphics.beginFill(host['alliance'] == 'Player' ? 0x00ff00 : 0x355EFF);
			HPLayer.graphics.drawRect(0, 0, maxWidth, barHeight);

			HPLayer1 = new Shape();
			HPLayer1.graphics.beginFill(host['alliance'] == 'Player' ? 0xd50000 : 0xff6600);
			HPLayer1.graphics.drawRect(0, 0, maxWidth, barHeight);

			rageLayer.x = HPLayer.x = HPLayer1.x = background.x = -maxWidth * .5;
			// -30.25;
			rageLayer.y = HPLayer.y = HPLayer1.y = background.y = -12.1;

			addChild(background);
			addChild(HPLayer1);
			addChild(HPLayer);
			addChild(rageLayer);
			// addChild(new ui_HPBar);
			scaleX = Math.abs(host.mc.scaleX);
			scaleY = host.mc.scaleY;
			y = -100 * host.mc.scaleY + host.mc.y;
		}

		private function onRageUpdate(event : PawnEvent) : void
		{
			var _w : int = maxWidth * (event.rageNum / host['fullHP']);
			if (_w >= HPLayer.width)
				_w = HPLayer.width;
			TweenNano.to(rageLayer, 0.5, {width:_w});
			alpha = 1;
			visible = true;
		}

		protected function onHPUpdate(event : Event) : void
		{
			var _w : int = maxWidth * (host['HP'] / host['fullHP']);
			HPLayer.width = _w;
			if (rageLayer.width >= _w)
				rageLayer.width = _w;
			TweenNano.to(HPLayer1, 0.5, {width:_w});
			visible = true;
			alpha = 1;
			// TweenNano.to(this, 0.5, {delay:3, alpha:0, onComplete:function() : void
			// {
			// visible = false;
			// }});
		}
	}
}
