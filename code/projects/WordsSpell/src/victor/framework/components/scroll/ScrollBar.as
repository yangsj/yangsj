package victor.framework.components.scroll
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MathUtil;
	import victor.framework.utils.UtilsFilter;

	/**
	 *  滚动条
	 * @author fireyang
	 */
	public class ScrollBar extends Sprite implements IDisposable
	{
		// 外型
		private var _skin:Sprite;
		private var _UpBtn:SimpleButton;
		private var _DownBtn:SimpleButton;
		private var _ScrollMc:MovieClip;
		private var _ScrollIcon:Sprite;
		// 背景
		private var _ListBack:Sprite;
		private var _barHeight:int;
		// 滚动区域的长度
		private var _scrollLen:int;
		private var _upPos:int;
		private var _cur:Number;
		private var _radio:Number;
		private var _emptyLen:int;
		private var _stage:Stage;
		private var _isMove:Boolean;
		private var _isOver:Boolean;
		private var _speed:int = 5;
		private var _curPos:Number;
		// 发生值更改
		public var onChange:Function;
		private var _isLock:Boolean;

		/**
		 * Construct a <code>FyBaseScrollBar</code>.
		 */
		public function ScrollBar( skin:Sprite )
		{
			_skin = skin;
			// GlobalFun.assetsManager.createClassByName("ui_oneFight_scrollBar");
			_UpBtn = _skin.getChildByName( "_UpBtn" ) as SimpleButton;
			_DownBtn = _skin.getChildByName( "_DownBtn" ) as SimpleButton;
			_ScrollMc = _skin.getChildByName( "_ScrollBtn" ) as MovieClip;
			_ScrollIcon = _skin.getChildByName( "_ScrollIcon" ) as Sprite;
			_ListBack = _skin.getChildByName( "_back" ) as Sprite;
			_ScrollMc.y = 0;
			_ScrollMc.stop();
			_ScrollMc.visible = false;
			// _moveNum = 0;
			_ScrollIcon.mouseEnabled = false;
			addChild( _skin );
		}

		public function init( value:int ):void
		{
			setBarHeight( value );
			addEvents();
		}

		public function setBarHeight( value:int ):void
		{
			_barHeight = value;
			_UpBtn.y = 0;
			_DownBtn.y = _barHeight - _DownBtn.height;
			_upPos = _UpBtn.height + 1;
			_scrollLen = _barHeight - 2 * _upPos;
			_ListBack.y = _upPos - 3;
			_ListBack.height = _scrollLen + 6;
			_ScrollMc.y = _upPos;
			_ScrollMc.height = _scrollLen;
		}

		/**
		 * 滚动条大小
		 */
		public function set radio( value:Number ):void
		{
			_radio = value;
			if ( _radio > 1 )
			{
				_radio = 1;
			}
			if ( _radio == 1 )
			{
				this.mouseEnabled = false;
				this.mouseChildren = false;
				lock();
			}
			else
			{
				unlock();
				update();
			}
		}

		private function lock():void
		{
			if ( _isLock )
			{
				return;
			}
			this.mouseEnabled = false;
			this.mouseChildren = false;
			_ScrollMc.visible = false;
			_isLock = true;
			this.filters = [ UtilsFilter.COLOR_GREW ];
		}

		private function unlock():void
		{
			if ( !_isLock )
			{
				return;
			}
			this.mouseEnabled = true;
			this.mouseChildren = true;
			_ScrollMc.visible = true;
			_isLock = false;
			this.filters = null;
		}

		/**
		 * 范围 0~1
		 */
		public function set pos( value:Number ):void
		{
			value = MathUtil.range( value, 0, 1 );
			setScrollMcPos( value );
			changeValue( value, false );
		}

		private function setScrollMcPos( value:Number ):void
		{
			var len:Number = _upPos + _emptyLen * value;
			_ScrollMc.y = len;
		}

		private function update():void
		{
			var len:int = _radio * _scrollLen;
			if ( len < 10 )
			{
				len = 10;
				_radio = 10 / _scrollLen;
			}
			_ScrollMc.height = len;
			_emptyLen = _scrollLen - len;
			_ScrollMc.y = _upPos;
		}

		public function change( value:Number ):void
		{
			_cur = value;
		}

		private function scrollMove():void
		{
			if ( stage == null )
			{
				return;
			}
			var cPos:Number;
			if ( _emptyLen == 0 )
			{
				cPos = 0;
			}
			else
			{
				cPos = ( _ScrollMc.y - _upPos ) / _emptyLen;
			}
			changeValue( cPos );
		}

		private function changeValue( value:Number, isDispatch:Boolean = true ):void
		{
			if ( _curPos == value )
			{
				return;
			}
			_curPos = value;
			if ( isDispatch && onChange != null )
			{
				onChange( _curPos );
			}
		}

		private function addEvents():void
		{
			_ScrollMc.addEventListener( MouseEvent.MOUSE_DOWN, onScrollDown );
			_ScrollMc.addEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
			_ScrollMc.addEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
			_UpBtn.addEventListener( MouseEvent.CLICK, this.onUpBtn );
			_DownBtn.addEventListener( MouseEvent.CLICK, this.onDownBtn );
			_ListBack.addEventListener( MouseEvent.CLICK, this.onBackHandler );
		}

		/**
		 * 点击滚动条 滚动
		 */
		private function onBackHandler( event:MouseEvent ):void
		{
			var mid:Number = _ScrollMc.y + _ScrollMc.height >> 1;
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

		private function onDownBtn( event:MouseEvent ):void
		{
			this.downMove();
		}

		public function downMove():void
		{
			var endPos:int = _emptyLen + _upPos;
			if ( _ScrollMc.y + _speed > endPos )
			{
				_ScrollMc.y = _emptyLen + _upPos;
			}
			else
			{
				_ScrollMc.y += _speed;
			}
			scrollMove();
		}

		private function onUpBtn( event:MouseEvent ):void
		{
			upMove();
		}

		public function upMove():void
		{
			if ( _ScrollMc.y - _speed < _upPos )
			{
				_ScrollMc.y = _upPos;
			}
			else
			{
				_ScrollMc.y = _ScrollMc.y - _speed;
			}
			scrollMove();
		}

		private function removeEvents():void
		{
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_DOWN, onScrollDown );
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_OVER, onScrollOver );
			_ScrollMc.removeEventListener( MouseEvent.MOUSE_OUT, onScrollOut );
		}

		private function onScrollDown( event:MouseEvent ):void
		{
			_ScrollMc.gotoAndStop( 3 );
			if ( _stage == null )
			{
				_stage = stage;
			}
			_stage.addEventListener( MouseEvent.MOUSE_UP, onScrollUp, false, 0, true );
			_stage.addEventListener( MouseEvent.MOUSE_MOVE, onScrollMove, false, 0, true );
			_ScrollMc.startDrag( false, new Rectangle( _ScrollMc.x, _upPos, 0, _emptyLen ));
			_isMove = true;
		}

		private function onScrollMove( event:MouseEvent ):void
		{
			scrollMove();
		}

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
			_isMove = false;
			if ( _isOver )
			{
				_ScrollMc.gotoAndStop( 2 );
			}
			else
			{
				_ScrollMc.gotoAndStop( 1 );
			}
		}

		private function onScrollOut( event:MouseEvent ):void
		{
			if ( _isMove == false )
			{
				_ScrollMc.gotoAndStop( 1 );
			}
			_isOver = false;
		}

		private function onScrollOver( event:MouseEvent ):void
		{
			if ( _isMove == false )
			{
				_ScrollMc.gotoAndStop( 2 );
			}
			_isOver = true;
		}

		public function dispose():void
		{
			DisplayUtil.removedAll( _skin );
		}

		public function setSpeed( value:int ):void
		{
			_speed = value;
		}

		public function goEnd():void
		{
			setScrollMcPos( 1 );
			changeValue( 1 );
		}

		public function goFirst():void
		{
			setScrollMcPos( 0 );
			changeValue( 0 );
		}

		public function get curPos():Number
		{
			return _curPos;
		}
	}
}
