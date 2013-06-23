package victor.view.res
{
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import victor.core.IItem;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class Item extends Sprite implements IItem
	{
		private const _itemWidth:Number = 50;
		private const _itemHeight:Number = 50;

		private var _cols:int;
		private var _rows:int;
		private var _mark:int;
		private var _isReal:Boolean;
		private var _selected:Boolean;
		private var _parentNode:IItem;

		private static var COLORS:Vector.<uint>;

		public function Item()
		{
			if ( COLORS == null )
			{
				var length:int = 20;
				var single:uint = uint( 255 * 255 * 255 / 21 );
				COLORS = new Vector.<uint>( length );
				for ( var i:int = 1; i <= length; i++ )
				{
					COLORS[ i - 1 ] = single * i;
				}
			}
			mouseChildren = false;
			buttonMode = true;
		}

		public function dispose():void
		{
		}

		public function initialize():void
		{
			_isReal = true;
			_parentNode = null;

			this.removeChildren();
			this.graphics.clear();
			this.graphics.lineStyle( 1 );
			this.graphics.beginFill( COLORS[ mark ]);
			this.graphics.drawRect( 0, 0, itemWidth, itemHeight );
			this.graphics.endFill();

			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat( null, 25 );
			txt.text = mark + "";
			var bitdata:BitmapData = new BitmapData( txt.textWidth + 5, txt.textHeight + 2, true, 0 );
			bitdata.draw( txt );
			var bitmap:Bitmap = new Bitmap( bitdata, "auto", true );
			bitmap.x = ( width - bitmap.width ) >> 1;
			bitmap.y = ( height - bitmap.height ) >> 1;
			addChild( bitmap );

			this.x = cols * ( itemWidth + 5 );
			this.y = rows * ( itemHeight + 5 );
		}

		public function image( img:String ):void
		{
		}

		public function removeFromParent():void
		{
			TweenMax.delayedCall( 0.5, function abc( target:DisplayObject ):void
			{
				if ( target.parent )
				{
					target.parent.removeChild( target );
				}
			}, [ this ]);
			_parentNode = null;
			_selected = false;
			_isReal = false;
			_cols = 0;
			_rows = 0;
		}

		public function get globalPoint():Point
		{
			return localToGlobal( new Point( width >> 1, height >> 1 ));
		}

		public function get itemWidth():Number
		{
			return _itemWidth;
		}

		public function get itemHeight():Number
		{
			return _itemHeight;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected( value:Boolean ):void
		{
			_selected = value;
			filters = value ? [ new GlowFilter()] : [];
		}

		public function get cols():int
		{
			return _cols;
		}

		public function set cols( value:int ):void
		{
			_cols = value;
		}

		public function get rows():int
		{
			return _rows;
		}

		public function set rows( value:int ):void
		{
			_rows = value;
		}

		public function get isReal():Boolean
		{
			return _isReal;
		}

		public function set isReal( value:Boolean ):void
		{
			_isReal = value;
		}

		public function get mark():int
		{
			return _mark;
		}

		public function set mark( value:int ):void
		{
			_mark = value;
		}

		public function get parentNode():IItem
		{
			return _parentNode;
		}

		public function set parentNode(value:IItem):void
		{
			_parentNode = value;
		}


	}
}
