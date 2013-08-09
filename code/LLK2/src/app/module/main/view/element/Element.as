package app.module.main.view.element
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import app.AppStage;
	import app.core.Image;
	import app.module.AppUrl;
	import app.utils.DisplayUtil;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class Element extends Sprite implements IElement
	{
		private const _itemWidth:Number = 80 * AppStage.minScale;
		private const _itemHeight:Number = 80 * AppStage.minScale;

		private var _cols:int;
		private var _rows:int;
		private var _mark:int;
		private var _isReal:Boolean;
		private var _selected:Boolean;
		private var _globalPoint:Point;
		private var _parentTarget:DisplayObjectContainer;

		private var _image:Image;
		private var _border:Shape;
		private var _selectEffect:Shape;
		private var _errorEffect:Shape;

		private var _lastx:Number = 0;
		private var _lasty:Number = 0;
		private var _endx:Number = 0;
		private var _endy:Number = 0;

		public function Element()
		{
			mouseChildren = false;
			buttonMode = true;
		}

		public function dispose():void
		{
			if ( _image )
				_image.dispose();
			DisplayUtil.removedFromParent( _image );

			_image = null;
			_globalPoint = null;
			_parentTarget = null;
		}

		public function tween( delay:Number = 0 ):void
		{
			if ( isReal && delay > 0 )
			{
				this.x = cols * ( itemWidth + 5 );
				this.y = rows * ( itemHeight + 5 );
				TweenMax.killTweensOf( this );
				TweenMax.from( this, 0.2, { x: _lastx, y: _lasty, delay: delay });
			}
		}

		public function clickError():void
		{
			_errorEffect.visible = true;
			setTimeout( function abc():void
			{
				_errorEffect.visible = false;
			}, 300 );
		}

		public function refresh():void
		{
			_lastx = this.x;
			_lasty = this.y;
			this.x = cols * ( itemWidth + 5 );
			this.y = rows * ( itemHeight + 5 );
			_globalPoint = this.localToGlobal( new Point(( itemWidth >> 1 ), ( itemHeight >> 1 )));
			if ( _isReal == false )
			{
				this.x = _lastx;
				this.y = _lasty;
			}

			mouseEnabled = true;
		}

		public function initialize():void
		{
			_isReal = true;
			visible = true;

			// 设置资源
			if ( _image == null )
			{
				_image = new Image( AppUrl.getHeadUrl( mark ));
				_image.setSize( itemWidth, itemHeight );
				addChild( _image );
			}
			else
			{
				_image.reset( AppUrl.getHeadUrl( mark ));
			}

			if ( _border == null )
			{
				_border = getShape( 5, 0, 0.8 );
				addChild( _border );
			}
			if ( _selectEffect == null )
			{
				_selectEffect = getShape( 5, 0x00FF00, 0.8 );
				addChild( _selectEffect );
			}
			if ( _errorEffect == null )
			{
				_errorEffect = getShape( 5, 0xFF0000, 0.8 );
				addChild( _errorEffect );
			}
			selected = false;

			if ( parent == null && _parentTarget )
				_parentTarget.addChild( this );

			refresh();
		}

		private function getShape( thickness:Number = 0, color:uint = 0, alpha:Number = 1.0 ):Shape
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle( thickness, color, alpha );
			shape.graphics.drawRect( 0, 0, itemWidth, itemHeight );
			shape.graphics.endFill();
			return shape;
		}

		public function removeFromParent( delay:Number = 0 ):void
		{
			mouseEnabled = false;
			TweenMax.delayedCall( delay, function abc( target:DisplayObject ):void
			{
				target.visible = false;
				selected = false;
			}, [ this ]);
			_isReal = false;
		}

		public function get globalPoint():Point
		{
			return new Point( _globalPoint.x, _globalPoint.y );
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
			_selectEffect.visible = value;
			_errorEffect.visible = false;
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

//		public function set isReal( value:Boolean ):void
//		{
//			_isReal = value;
//		}

		public function get mark():int
		{
			return _mark;
		}

		public function set mark( value:int ):void
		{
			_mark = value;
		}

		public function get parentTarget():DisplayObjectContainer
		{
			return _parentTarget;
		}

		public function set parentTarget( value:DisplayObjectContainer ):void
		{
			_parentTarget = value;
		}


	}
}
