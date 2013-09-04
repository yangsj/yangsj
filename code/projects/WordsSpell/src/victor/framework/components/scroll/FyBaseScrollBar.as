package victor.framework.components.scroll
{

	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.UtilsFilter;

	/**
	 *  滚动条
	 * @author fireyang
	 */
	public class FyBaseScrollBar extends Sprite implements IDisposable
	{
		private var _skin:Sprite;
		private var _UpBtn:SimpleButton;
		private var _DownBtn:SimpleButton;
		private var _ScrollMc:MovieClip;
		private var _ScrollIcon:Sprite;
		private var _ListBack:Sprite;
		// 总高度
		private var _mainHeight:int;
		private var _isMainHeight:Boolean;
		private var _target:Sprite;
		// 是否已经加载
		private var _isLoadBar:Boolean;
		// 是否指定显示坐标
		private var _scrollbarXBool:Boolean;
		private var _scrollbarX:Number;
		private var _scrollbarYBool:Boolean;
		private var _scrollbarY:Number;
		// 显示宽度
		private var _showWidth:int;
		private var _widthBool:Boolean;
		private var _showHeight:int;
		private var _heightBool:Boolean;
		// 目标y值
		private var _targetY:Number;
		// 滚动条高度
		private var _barHeight:Number = -1;
		// 比率 （显示/总高度）
		private var ratio:Number;
		// 可移动距离
		private var _move:Number = 0;
		// 移动比例
		private var _movePoint:Number;
		// 默认是否隐藏滚动条
		private var _visibleScrollbar:Boolean;
		// 遮罩
		private var _maskX:Number;
		private var _maskY:Number;
		private var _rect:Shape;
		// 滚轮
		private var _wheel:Sprite;
		// 滚动速度
		public var speed:int = 5;
		// 是否在移动
		private var _isMove:Boolean;
		private var _stage:Stage;
		private var _showChange:Boolean;

		/**
		 * Construct a <code>FyBaseScrollBar</code>.
		 */
		public function FyBaseScrollBar( skin:Sprite )
		{
			_skin = skin;
			_UpBtn = _skin.getChildByName( "_UpBtn" ) as SimpleButton;
			_DownBtn = _skin.getChildByName( "_DownBtn" ) as SimpleButton;
			_ScrollMc = _skin.getChildByName( "_ScrollBtn" ) as MovieClip;
			_ScrollIcon = _skin.getChildByName( "_ScrollIcon" ) as Sprite;
			_ListBack = _skin.getChildByName( "_back" ) as Sprite;
			_ScrollMc.y = 0;
			_ScrollMc.stop();
			_visibleScrollbar = true;
			_ScrollIcon.mouseEnabled = false;
			addChild( _skin );
		}

		private function hideAll():void
		{
			this.hideBtn( false );
			this._ListBack.visible = false;
			this._DownBtn.visible = false;
			this._UpBtn.visible = false;
		}

		/**
		 * 设置目标
		 */
		public function setTarget( targetMc:Sprite ):void
		{
			if ( targetMc == null )
			{
				return;
			}
			if ( _target )
			{
				clearTarget();
			}
			_ScrollMc.y = 0;
			_target = targetMc;
			_targetY = _target.y;
			update();
		}

		public function setPrecent( num:Number ):void
		{
			_ScrollMc.y = num * _move;
			update();
		}

		public function getPrecent():Number
		{
			return _ScrollMc.y / _move;
		}

		/**
		 * 开始列表
		 */
		private function startList():void
		{
			if ( _target == null )
			{
				return;
			}
			// 设置滚动条
			this.loadScrollbar();
			this.scrollbarLive();
			this.scrollbarSize();
			if ( this.ratio >= 1 )
			{
				// 无需滚动条
				this.hideBtn( false );
				this._ListBack.visible = this._visibleScrollbar;
				this._DownBtn.visible = this._visibleScrollbar;
				this._UpBtn.visible = this._visibleScrollbar;
			}
			else
			{
				_showChange = true;
				this.createWheel();
				this.hideBtn( true );
				this._ListBack.visible = true;
				this._DownBtn.visible = true;
				this._UpBtn.visible = true;
				this.scrollMove();
			}
			if ( _showChange )
			{
				// 显示滚动条
				this.createMask();
			}
		}

		/**
		 * 更新
		 */
		public function update():void
		{
			if ( _target )
			{
				if ( !_isMainHeight )
				{
					this._mainHeight = _target.height;
				}
				if ( _mainHeight <= 0 )
				{
					hideAll();
					return;
				}
				this.startList();
			}
		}

		/**
		 * 隐藏按钮
		 */
		private function hideBtn( value:Boolean ):void
		{
			if ( value )
			{
				_skin.filters = null;
			}
			else
			{
				_skin.filters = [ UtilsFilter.COLOR_GREW ];
			}
			_UpBtn.mouseEnabled = value;
			_DownBtn.mouseEnabled = value;
			this._ScrollMc.visible = value;
			this._ScrollIcon.visible = value;
		}

		/**
		 * 加载滚动条
		 */
		private function loadScrollbar():void
		{
			if ( this._isLoadBar == false && _target.parent )
			{
				this._target.parent.addChild( this );
				addEventHandlers();
				this._isLoadBar = true;
			}
		}

		/**
		 * 设置宽度
		 */
		private function scrollbarLive():void
		{
			if ( this._scrollbarXBool == true )
			{
				this.x = this._scrollbarX;
			}
			else
			{
				this.x = this._target.x + this._showWidth;
			}
			if ( this._scrollbarYBool == true )
			{
				this.y = this._scrollbarY;
			}
			else
			{
				this.y = this._targetY + this._UpBtn.height;
			}
		}

		/**
		 * 设置大小
		 */
		private function scrollbarSize():void
		{
			if ( _barHeight < 0 )
			{
				_barHeight = this._showHeight - this._DownBtn.height * 2;
			}
			_ListBack.height = _barHeight + 2;
			this._DownBtn.y = _barHeight;
			this.ratio = this._showHeight / this._mainHeight;
			if ( this.ratio > 1 )
			{
				this.ratio = 1;
			}
			this._ScrollMc.height = _barHeight * this.ratio;
			this._move = _barHeight - this._ScrollMc.height;
			if ( this._move <= 0 )
			{
				this._movePoint = 0;
			}
			else
			{
				this._movePoint = this._move / ( this._mainHeight - this._showHeight );
			}
			this.range();
			// 更新图标
			this._ScrollIcon.y = this._ScrollMc.y + this._ScrollMc.height / 2;
		}

		/**
		 * 限制区域
		 */
		private function range():void
		{
			if ( this._ScrollMc.y > this._move )
			{
				this._ScrollMc.y = this._move;
			}
			if ( this._ScrollMc.y >= 0 && this.ratio >= 1 )
			{
				this._ScrollMc.y = 0;
			}
			this.scrollMove();
		}

		/**
		 * 移动
		 */
		private function scrollMove():void
		{
			if ( stage == null )
			{
				return;
			}
			render();
			dispatchEvent( new Event( Event.CHANGE ));
		}

		private function render():void
		{
			if ( this._movePoint <= 0 )
			{
				this._target.y = this._targetY;
			}
			else
			{
				this._target.y = -this._ScrollMc.y / this._movePoint + this._targetY;
			}
			this._ScrollIcon.y = this._ScrollMc.y + this._ScrollMc.height / 2;
		}

		public function get syncData():Array
		{
			return [ _ScrollMc.y ];
		}

		public function sync( data:Array ):void
		{
			_ScrollMc.y = data[ 0 ];
			render();
		}

		/**
		 * 添加事件监听
		 */
		private function addEventHandlers():void
		{
			this._UpBtn.addEventListener( MouseEvent.CLICK, this.onUpBtn );
			this._DownBtn.addEventListener( MouseEvent.CLICK, this.onDownBtn );
			_ScrollMc.addEventListener( MouseEvent.MOUSE_DOWN, this.onScrollDown );
			_ScrollMc.addEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
			_ScrollMc.addEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
			_ListBack.addEventListener( MouseEvent.CLICK, this.onBackHandler );
		}

		private function onBackHandler( event:MouseEvent ):void
		{
			var mid:Number = _ScrollMc.y + _ScrollMc.height * 0.5;
			var mouseX:Number = _ListBack.mouseY;
			if ( mouseX > mid )
			{
				downMove();
			}
			else
			{
				upMove();
			}
		}

		private function onScrollOut( event:MouseEvent ):void
		{
			_ScrollMc.gotoAndStop( 1 );
		}

		private function onScrollOver( event:MouseEvent ):void
		{
			_ScrollMc.gotoAndStop( 2 );
		}

		/**
		 * 移除事件
		 */
		private function removeListener():void
		{
			this._UpBtn.removeEventListener( MouseEvent.CLICK, this.onUpBtn );
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_DOWN, this.onScrollDown );
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
			_ListBack.removeEventListener( MouseEvent.CLICK, this.onBackHandler );
			this._DownBtn.removeEventListener( MouseEvent.CLICK, this.onDownBtn );
		}

		private function createMask():void
		{
			this._maskX = this._target.x;
			this._maskY = this._targetY;
			if ( _rect == null )
			{
				this._rect = new Shape();
				this._rect.graphics.beginFill( 0 );
				this._rect.graphics.drawRect( 0, 0, 1, 1 );
				this._rect.graphics.endFill();
			}
			_rect.width = _showWidth + 2;
			_rect.height = _showHeight;
			_rect.x = _maskX - 1;
			_rect.y = _maskY;
			this._target.parent.addChild( this._rect );
			this._target.mask = this._rect;
		}

		/**
		 * 清除遮罩
		 */
		private function clearMask():void
		{
			if ( _target )
			{
				_target.mask = null;
			}
			DisplayUtil.removedFromParent( _rect );
		}

		private function createWheel():void
		{
			this.clearWheel();
			this._wheel = new Sprite();
			this._wheel.graphics.beginFill( 0 );
			this._wheel.graphics.drawRect( 0, 0, _showWidth, this._mainHeight );
			this._wheel.graphics.endFill();
			this._target.addChildAt( this._wheel, 0 );
			this._target.addEventListener( MouseEvent.MOUSE_WHEEL, this.onScrollWheel );
			this._wheel.alpha = 0;
		}

		/**
		 * 清除滚动事件
		 */
		private function clearWheel():void
		{
			if ( this._target )
			{
				this._target.removeEventListener( MouseEvent.MOUSE_WHEEL, this.onScrollWheel );
			}
			DisplayUtil.removedFromParent( _wheel );
			this._wheel = null;
		}

		/**
		 * 滚动条
		 */
		private function onScrollWheel( event:MouseEvent ):void
		{
			if ( event.delta > 0 )
			{
				this.upMove();
			}
			else
			{
				this.downMove();
			}
		}

		/**
		 * 向下滚动
		 */
		private function onScrollDown( event:MouseEvent ):void
		{
			_ScrollMc.gotoAndStop( 3 );
			_stage = stage;
			stage.addEventListener( MouseEvent.MOUSE_UP, this.onScrollUp, false, 0, true );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, this.onScrollMove, false, 0, true );
			this._ScrollMc.startDrag( false, new Rectangle( _ScrollMc.x, 0, 0, this._move ));
			this._isMove = true;
		}

		/**
		 * 鼠标释放
		 */
		private function onScrollUp( event:MouseEvent ):void
		{
			_ScrollMc.gotoAndStop( 2 );
			scrollUpClear();
		}

		/**
		 * 停止拖动滚动
		 */
		private function scrollUpClear():void
		{
			this._ScrollMc.stopDrag();
			if ( _stage == null )
			{
				return;
			}
			_stage.removeEventListener( MouseEvent.MOUSE_UP, this.onScrollUp );
			_stage.removeEventListener( MouseEvent.MOUSE_MOVE, this.onScrollMove );
			_stage = null;
			this._isMove = false;
		}

		/**
		 * 滚动条拖动移动
		 */
		private function onScrollMove( event:MouseEvent ):void
		{
			this.scrollMove();
		}

		/**
		 * 向上移动
		 */
		private function onUpBtn( event:MouseEvent ):void
		{
			this.upMove();
		}

		private function onDownBtn( event:MouseEvent ):void
		{
			this.downMove();
		}

		/**
		 * 向上移动移动
		 */
		private function upMove():void
		{
			if ( this._ScrollMc.y - this.speed < 0 )
			{
				this._ScrollMc.y = 0;
			}
			else
			{
				this._ScrollMc.y = this._ScrollMc.y - this.speed;
			}
			this.scrollMove();
		}

		/**
		 * 向下移动
		 */
		private function downMove():void
		{
			if ( this._ScrollMc.y + this.speed > this._move )
			{
				this._ScrollMc.y = this._move;
			}
			else
			{
				this._ScrollMc.y = this._ScrollMc.y + this.speed;
			}
			this.scrollMove();
		}

		public function set showWidth( value:Number ):void
		{
			if ( _showHeight != value )
			{
				_showChange = true;
			}
			this._showWidth = value;
			this._widthBool = true;
			this.startList();
		}

		public function set showHeight( value:Number ):void
		{
			if ( _showHeight != value )
			{
				_showChange = true;
			}
			this._showHeight = value;
			this._heightBool = true;
			this.startList();
		}

		public function set mainHeight( value:Number ):void
		{
			this._isMainHeight = true;
			this._mainHeight = value;
			this.startList();
		}

		/**
		 * 设置滚动条x坐标
		 */
		public function set scrollbarX( value:int ):void
		{
			this._scrollbarX = value;
			this._scrollbarXBool = true;
		}

		/**
		 * 设置滚动条y坐标
		 */
		public function set scrollbarY( value:int ):void
		{
			this._scrollbarY = value;
			this._scrollbarYBool = true;
		}

		/**
		 * 初始化可是对象
		 */
		public function initShow( showWidth:Number, showHeight:Number ):void
		{
			this._showWidth = showWidth;
			this._widthBool = true;
			this._showHeight = showHeight;
			this._heightBool = true;
			startList();
		}

		/**
		 * 变化高度
		 */
		public function set barHeight( value:int ):void
		{
			var ratioY:Number = _ScrollMc.y / _barHeight;
			_barHeight = value - this._DownBtn.height * 2;
			_ScrollMc.y = Math.round( ratioY * _barHeight );
			startList();
		}

		public function clearTarget():void
		{
			_isLoadBar = false;
			clearMask();
			clearWheel();
			removeListener();
			scrollUpClear();
			if ( _target )
			{
				_target.y = _targetY;
			}
			DisplayUtil.removedFromParent( this );
			_target = null;
		}

		/**
		 *  销毁
		 */
		public function dispose():void
		{
			clearTarget();
			DisplayUtil.removedFromParent( _UpBtn );
			DisplayUtil.removedFromParent( _DownBtn );
			DisplayUtil.removedFromParent( _ListBack );
			DisplayUtil.removedFromParent( _ScrollMc );
			DisplayUtil.removedFromParent( _ScrollIcon );
			_rect = null;
			_UpBtn = null;
			_DownBtn = null;
			_ListBack = null;
			_ScrollMc = null;
			_ScrollIcon = null;
		}
	}
}
