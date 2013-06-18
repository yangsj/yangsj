package test.scroll
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	import victor.components.scroll.TouchScrollPanel;
	import victor.utils.BitmapUtil;


	/**
	 * ……
	 * @author yangsj
	 */
	public class TestScrollPanel extends Sprite
	{


		public function TestScrollPanel()
		{
			var con:Sprite = new Sprite();
			addChild( con );
			con.x = 50;
			con.y = 50;
			for ( var i:int = 0; i < 100; i++ )
			{
				var sprite:Sprite = createItemTest( "NO." + i );
				sprite.x = 105 * ( i % 4 );
				sprite.y = 105 * int( i / 4 );
				con.addChild( sprite );
			}
			var scrollPanel:TouchScrollPanel = new TouchScrollPanel( con, new Rectangle( 0, 0, 105 * 4, 105 * 4 ));
			scrollPanel.refresh();
		}

		private function createItemTest( label:String ):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill( 0xff0000 );
			sprite.graphics.drawRect( 0, 0, 100, 100 );
			sprite.graphics.endFill();

			var txt:TextField = new TextField();
			txt.text = label;
			var bitmap:Bitmap = BitmapUtil.drawBitmapFromTextFeild( txt );
			bitmap.x = ( sprite.width - bitmap.width ) >> 1;
			bitmap.y = ( sprite.height - bitmap.height ) >> 1;
			sprite.addChild( bitmap );

			return sprite;
		}

	}
}
