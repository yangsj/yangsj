package code
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * ……
	 * @author yangsj
	 */
	public class BarTips
	{
		private var _skin:MovieClip;

		private var _bg:Sprite;
		private var _tips:MovieClip;
		private var _pathVo:PathVo;
		
		private var _endTipsx:Number;
		private var _endTipsy:Number;

		public function BarTips( skin:MovieClip, pathVo:PathVo )
		{
			_skin = skin;
			_pathVo = pathVo;

			_bg = _skin[ "bg" ];
			_tips = _skin[ "tips" ];
			
			_endTipsx = _tips.x;
			_endTipsy = _tips.y;

			_tips.txt.text = pathVo.name;
			
			_skin.buttonMode = true;
			_skin.addEventListener( MouseEvent.ROLL_OUT, rollHandler );
			_skin.addEventListener( MouseEvent.ROLL_OVER, rollHandler );
			_skin.addEventListener( MouseEvent.CLICK, clickHandler );
			
			mouseOutComplete();
		}

		protected function rollHandler( event:MouseEvent ):void
		{
			if ( event.type == MouseEvent.ROLL_OUT )
				mouseOut();
			else
				mouseOver();
		}

		protected function clickHandler( event:MouseEvent ):void
		{
			gotoUrl();
		}

		public function playLoopOnce( delay:Number ):void
		{
			TweenMax.delayedCall( delay, mouseOver);
			TweenMax.delayedCall( delay + 0.6, mouseOut);
		}
		
		public function gotoUrl():void
		{
			if ( _pathVo && _pathVo.url )
			{
				navigateToURL(new URLRequest(_pathVo.url), _pathVo.window);
			}
		}

		public function mouseOver():void
		{
			_skin.parent.dispatchEvent( new MEvent(MEvent.SELECTED_MENU, _pathVo.id, true ));
			
			TweenMax.killTweensOf( _bg );
			_bg.alpha = 0;
			TweenMax.to( _bg, 0.6, { alpha: 1 });

			_tips.x = _endTipsx + (Math.random() * 15 + 5) * int(Math.random() * 2 - 1);
			_tips.y = _endTipsy + (Math.random() * 15 + 5);
			_tips.alpha = 0;
			_tips.visible = true;
			_tips.scaleX = _tips.scaleY = 0.001;
			TweenMax.killTweensOf( _tips );
			TweenMax.to( _tips, 0.4, { alpha:1, scaleX: 1, scaleY: 1, x:_endTipsx, y:_endTipsy, ease: Elastic.easeOut });
		}

		public function mouseOut():void
		{
			_skin.parent.dispatchEvent( new MEvent(MEvent.SELECTED_MENU, _pathVo.id, false ));

			TweenMax.killTweensOf( _bg );
			_bg.alpha = 1;
			TweenMax.to( _bg, 0.5, { alpha: 0 });
			
			_tips.alpha = 1;
			_tips.visible = true;
			_tips.scaleX = _tips.scaleY = 1;
			TweenMax.killTweensOf( _tips );
			TweenMax.to( _tips, 0.4, { scalexX: 0.001, scaleY: 0.001, delay: 0.1, ease: Elastic.easeIn, onComplete: mouseOutComplete });
		}

		private function mouseOutComplete():void
		{
			_tips.visible = false;
			_bg.alpha = 0;
		}

	}
}
