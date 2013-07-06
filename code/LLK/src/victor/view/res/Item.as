package victor.view.res
{
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import victor.GameStage;
	import victor.URL;
	import victor.core.interfaces.IItem;
	import victor.core.Image;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class Item extends Sprite implements IItem
	{
		private const _itemWidth:Number = 80 * GameStage.minScale;
		private const _itemHeight:Number = 80 * GameStage.minScale;

		private var _cols:int;
		private var _rows:int;
		private var _mark:int;
		private var _isReal:Boolean;
		private var _selected:Boolean;
		private var _globalPoint:Point;

		private var _image:Image;
		private var _border:Shape;
		private var _selectEffect:Shape;

		public function Item()
		{
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

			mouseEnabled = true;
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
			if ( _image )
				_image.dispose();
			_image = new Image( URL.getHeadUrl( mark ));
			_image.setSize( itemWidth, itemHeight );
			addChild( _image );

			if ( _border == null )
			{
				_border ||= new Shape();
				_border.graphics.lineStyle( 5, 0, 0.8 );
				_border.graphics.drawRect( 0, 0, itemWidth, itemHeight );
				_border.graphics.endFill();
			}
			addChild( _border );
			if ( _selectEffect == null )
			{
				_selectEffect = new Shape();
				_selectEffect.graphics.lineStyle( 5, 0x00FF00, 0.8 );
				_selectEffect.graphics.drawRect( 0, 0, itemWidth, itemHeight );
				_selectEffect.graphics.endFill();
			}
			addChild( _selectEffect );
			selected = false;
		}

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			refresh();
		}

		public function removeFromParent():void
		{
			mouseEnabled = false;
			TweenMax.delayedCall( 0.5, function abc( target:DisplayObject ):void
			{
				target.visible = false;
				selected = false;
			}, [ this ]);
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
//			filters = value ? [ new GlowFilter()] : [];
			_selectEffect.visible = value;
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
