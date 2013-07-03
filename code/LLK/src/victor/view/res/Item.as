package victor.view.res
{
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Point;

	import victor.GameStage;
	import victor.core.IItem;
	import victor.core.Image;
	import victor.URL;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class Item extends Sprite implements IItem
	{
		private const _itemWidth:Number = 50 * GameStage.minScale;
		private const _itemHeight:Number = 50 * GameStage.minScale;

		private var _cols:int;
		private var _rows:int;
		private var _mark:int;
		private var _isReal:Boolean;
		private var _selected:Boolean;
		private var _globalPoint:Point;

		private var _image:Image;

//		private static var COLORS:Vector.<uint>;

		public function Item()
		{
//			if ( COLORS == null )
//			{
//				var length:int = 20;
//				var single:uint = uint( 255 * 255 * 255 / 21 );
//				COLORS = new Vector.<uint>( length );
//				for ( var i:int = 1; i <= length; i++ )
//				{
//					COLORS[ i - 1 ] = single * i;
//				}
//			}
			mouseChildren = false;
			buttonMode = true;
		}

		public function dispose():void
		{
		}

		public function refresh():void
		{
			this.x = cols * ( itemWidth + 5 );
			this.y = rows * ( itemHeight + 5 );
			_globalPoint = this.localToGlobal( new Point(( itemWidth >> 1 ), ( itemHeight >> 1 )));
		}

		public function initialize():void
		{
			_isReal = true;
			visible = true;

			this.removeChildren();

			if ( stage )
				addedToStageHandler( null );
			else
				addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

			// 设置资源
			_image = new Image( URL.getHeadUrl( mark ));
			_image.setSize( itemWidth, itemHeight );
			addChild( _image );
		}

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			refresh();
		}

		public function removeFromParent():void
		{
			TweenMax.delayedCall( 0.5, function abc( target:DisplayObject ):void
			{
				target.visible = false;
			}, [ this ]);
			selected = false;
			isReal = false;
			cols = 0;
			rows = 0;
		}

		public function get globalPoint():Point
		{
			return _globalPoint;
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


	}
}
