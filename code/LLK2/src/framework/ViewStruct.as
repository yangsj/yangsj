package framework
{
	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.text.TextField;

	import app.AppStage;
	import app.utils.DisplayUtil;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class ViewStruct
	{
		private static var numCount:uint = 0;

		public static const BACKGROUND:uint = numCount++;
		public static const SCENE:uint = numCount++;
		public static const MAIN:uint = numCount++;
		public static const PANEL:uint = numCount++;
		public static const ALERT:uint = numCount++;
		public static const EFFECT:uint = numCount++;
		public static const BACK_WORD:uint = numCount++;

		private static var container:Sprite;

		private static var backWordEffect:Sprite;

		public function ViewStruct()
		{
		}

		public static function initialize( displayObjectContainer:DisplayObjectContainer ):void
		{
			if ( container == null )
			{
				var sprite:Sprite;
				displayObjectContainer.addChild( container = new Sprite());
				container.mouseEnabled = false;
				for ( var i:uint = 0; i < numCount; i++ )
				{
					sprite = new Sprite();
					sprite.mouseEnabled = false;
					container.addChild( sprite );
				}
			}
		}

		public static function addScene( scene:DisplayObject ):void
		{
			removeAll( SCENE );
			addChild( scene, SCENE );
		}

		public static function addPanel( panel:DisplayObject ):void
		{
			addChild( panel, PANEL );
		}

		public static function addChild( child:DisplayObject, containerType:uint ):void
		{
			if ( child )
			{
				try
				{
					var spr:Sprite = container.getChildAt( containerType ) as Sprite;
				}
				catch ( e:Error )
				{
					throw e;
				}
				if ( spr )
				{
					spr.addChild( child );
				}
			}
		}

		public static function removeChild( child:DisplayObject ):void
		{
			DisplayUtil.removedFromParent( child );
		}

		public static function removeAll( containerType:uint ):void
		{
			try
			{
				var sprite:Sprite = container.getChildAt( containerType ) as Sprite;
			}
			catch ( e:Error )
			{
			}
			if ( sprite )
			{
				sprite.removeChildren();
			}
		}

		public static function addBackWordEffect():void
		{
			if ( backWordEffect == null )
			{
				var txtTips:TextField = DisplayUtil.getTextFiled( 28, 0xffffff );
				txtTips.appendText( "再按一次返回到桌面" );
				txtTips.width = txtTips.textWidth + 5;
				txtTips.height = txtTips.textHeight + 2;

				var bitdata:BitmapData = new BitmapData( txtTips.width, txtTips.height, true, 0 );
				bitdata.draw( txtTips );
				var bitmap:Bitmap = new Bitmap( bitdata, "auto", true );
				bitmap.x = 15;
				bitmap.y = 15;

				backWordEffect = new Sprite();
				backWordEffect.graphics.beginFill( 0, 0.8 );
				backWordEffect.graphics.drawRoundRect( 0, 0, txtTips.textWidth + bitmap.x * 2, txtTips.textHeight + bitmap.y * 2, 10 );
				backWordEffect.graphics.endFill();
				backWordEffect.addChild( bitmap );
				backWordEffect.x = ( AppStage.stageWidth - backWordEffect.width ) >> 1;
				backWordEffect.y = ( AppStage.stageHeight - backWordEffect.height ) - 100;
			}
			removeBackWordEffect();
			addChild( backWordEffect, BACK_WORD );
			TweenMax.from( backWordEffect, 0.3, { alpha: 0 });
			TweenMax.to( backWordEffect, 0.3, { alpha: 0, delay: 1.2 });
		}

		public static function removeBackWordEffect():void
		{
			removeChild( backWordEffect );
			TweenMax.killTweensOf( backWordEffect );
			backWordEffect.alpha = 1;
		}


	}
}
