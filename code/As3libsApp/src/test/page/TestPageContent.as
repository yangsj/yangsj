package test.page
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	import victor.components.page.PageContent;
	import victor.utils.BitmapUtil;


	/**
	 * ……
	 * @author yangsj
	 */
	public class TestPageContent extends PageContent
	{
		public function TestPageContent( showRect:Rectangle, pageSize:int = 8, isLoop:Boolean = false )
		{
			super( showRect, pageSize, isLoop );
		}

		override protected function createList( array:Array ):void
		{
			var length:int = array.length;
			for ( var i:int = 0; i < length; i++ )
			{
				var item:Sprite = createItemTest( "NO." + ( _pages.pageSize * ( _pages.curPageNo - 1 ) + i ));
				item.y = 30 * i;
				addChild( item );
				_currList.push( item );
			}
		}

		private function createItemTest( label:String ):Sprite
		{
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill( 0xff0000 );
			sprite.graphics.drawRect( 0, 0, 100, 25 );
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
