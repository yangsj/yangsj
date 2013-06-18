package victor.components.scroll
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;


	public class TouchScrollPanel implements ITouchScrollPanel
	{
		//------- List --------

		private var _scrollList:Sprite;
		private var _listHeight:Number = 100;
		private var _listWidth:Number = 100;
		private var _scrollListLength:Number;
		private var _scrollAreaLength:Number;
		private var _listRefreshTimer:Timer; // timer for all events

		//------ Scrolling ---------------

		private var _scrollBar:DisplayObject;
		private var _lastY:Number = 0; // last touch position
		private var _firstY:Number = 0; // first touch position
		private var _listY:Number = 0; // initial list position on touch 
		private var _diffY:Number = 0;
		private var _inertiaY:Number = 0;
		private var _minY:Number = 0;
		private var _maxY:Number = 0;
		private var _totalY:Number;
		private var _scrollRatio:Number = 30; // how many pixels constitutes a touch

		//------- local vars --------

		private var _isTouching:Boolean = false;
		private var _parent:DisplayObjectContainer; // scrollList父容器
		private var _stage:Stage; //引用舞台对象
		private var _isVertical:Boolean = true; //是否是垂直方向
		private var _barSkin:DisplayObject; // 指定scrollBar资源皮肤，若是使用默认的则可以不指定该值，将isBarSkin指定为true
		private var _isBarSkin:Boolean = false; // 若是barSkin不指定时，是否用默认scrollBar皮肤
		private var _shape:Shape; //使对象没有间隙
		private var _isDispose:Boolean = false;
		private var _tempContainer:Sprite;
		private var _startPosx:Number = 0; //起始位置x
		private var _startPosy:Number = 0; //起始位置y

		private const DISPOSE_ERROR:String = "已经调用了dispose不能再使用，若要重新使用需要重新创建！";

		// ------ Constructor --------

		/**
		 * 构造函数。规定：showRect的范围由scrollList的父容器(0,0)算起，scrollList在父容器中从（0,0）位置开始滚动
		 * @param scrollList scroll list target
		 * @param showRect 可视的一个区域，只有width和height两个值有效
		 * @param barSkin 指定scrollBar资源皮肤，若是使用默认的则可以不指定该值，将isBarSkin指定为true
		 * @param isVertical 是否垂直滚动，否则为水平滚动
		 * @param isBarSkin 若是barSkin不指定时，是否用默认scrollBar皮肤
		 */
		public function TouchScrollPanel( scrollList:Sprite, showRect:Rectangle = null, barSkin:DisplayObject = null, isVertical:Boolean = true, isBarSkin:Boolean = true )
		{
			_listWidth = showRect.width;
			_listHeight = showRect.height;
			_isVertical = isVertical;
			_barSkin = barSkin;
			_isBarSkin = barSkin ? true : isBarSkin;

			this.scrollList = scrollList;
		}

//*************** public functions ***********************

		/**
		 * 当需要完全销毁对象时使用
		 */
		public function dispose():void
		{
			removeInitEvent();
			removeEvent();
			stopTimer();


			// 移除
			removeSafeFromParent( _shape );

			// 移除临时容器
			removeSafeFromParent( _tempContainer );

			// 当创建默认滚动条时移除显示列表
			if ( _barSkin == null )
				removeSafeFromParent( _scrollBar );
			// 还原容器原来的位置
			if ( _parent && _scrollList && _tempContainer )
			{
				_scrollList.x = _startPosx;
				_scrollList.y = _startPosy;
				_parent.addChild( _scrollList );
			}

			_listRefreshTimer = null;
			_tempContainer = null;
			_scrollList = null;
			_isDispose = true;
			_barSkin = null;
			_parent = null;
			_stage = null;
			_shape = null;
		}

		public function refresh():void
		{
			if ( _isDispose )
			{
				throw new Error( DISPOSE_ERROR );
			}
			else if ( _scrollList )
			{
				if ( _scrollList.stage )
				{
					removeSafeFromParent( _shape );
					initLocalVars();
					createFullArea();
					createScrollBar();
					removeEvent();
					startTimer();
					addEvent();
					if ( _tempContainer )
					{
						if ( _tempContainer.parent == null )
							_parent.addChild( _tempContainer );
						_tempContainer.addChild( _scrollList );
					}
				}
			}
		}

//**************** events handler functions ****************************

		/**
		 * Timer event handler.  This is always running keeping track
		 * of the mouse movements and updating any scrolling or
		 * detecting any tap events.
		 *
		 * Mouse x,y coords come through as negative integers when this out-of-window tracking happens.
		 * The numbers usually appear as -107374182, -107374182. To avoid having this problem we can
		 * test for the mouse maximum coordinates.
		 * */
		protected function onRefreshTimerHandler( e:Event ):void
		{
			var key:String = _isVertical ? "y" : "x";
			if ( !_isTouching )
			{
				if ( _scrollList[ key ] > 0 )
				{
					_inertiaY = 0;
					_scrollList[ key ] *= 0.3;

					if ( _scrollList[ key ] < 1 )
						_scrollList[ key ] = 0;
				}
				else if ( _scrollListLength >= _scrollAreaLength && _scrollList[ key ] < _scrollAreaLength - _scrollListLength )
				{
					_inertiaY = 0;
					var diff:Number = ( _scrollAreaLength - _scrollListLength ) - _scrollList[ key ];
					if ( diff > 1 )
						diff *= 0.1;
					_scrollList[ key ] += diff;
				}
				else if ( _scrollListLength < _scrollAreaLength && _scrollList[ key ] < 0 )
				{
					_inertiaY = 0;
					_scrollList[ key ] *= 0.8;
					if ( _scrollList[ key ] > -1 )
						_scrollList[ key ] = 0;
				}

				if ( Math.abs( _inertiaY ) > 1 )
				{
					_scrollList[ key ] += _inertiaY;
					_inertiaY *= 0.9;
				}
				else
				{
					_inertiaY = 0;
				}

				if ( _scrollBar )
				{
					if ( _inertiaY != 0 )
					{
						_scrollBar[ key ] = _scrollAreaLength * Math.min( 1, ( -_scrollList[ key ] / _scrollListLength ));
						if ( _scrollBar.alpha < 1 )
							_scrollBar.alpha = Math.min( 1, _scrollBar.alpha + 0.1 );
					}
					else if ( _scrollBar.alpha > 0 )
					{
						_scrollBar.alpha = Math.max( 0, _scrollBar.alpha - 0.1 );
					}
				}
			}
			else
			{
				if ( _scrollBar )
				{
					_scrollBar[ key ] = _scrollAreaLength * Math.min( 1, ( -_scrollList[ key ] / _scrollListLength ));
					if ( _scrollBar.alpha < 1 )
						_scrollBar.alpha = Math.min( 1, _scrollBar.alpha + 0.1 );

				}
			}
		}

		protected function onMouseDownHandler( event:MouseEvent ):void
		{
			if ( _stage )
			{
				_stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMoveHandler, false, 0, false );
				_stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUpHandler, true, int.MAX_VALUE, false );
			}

			var scrollListPos:Number = _scrollList[ _isVertical ? "y" : "x" ];
			_inertiaY = 0;
			_firstY = _isVertical ? _parent.mouseY : _parent.mouseX;
			_listY = scrollListPos;
			_minY = Math.min( -scrollListPos, -_scrollListLength + _scrollAreaLength - scrollListPos );
			_maxY = -scrollListPos;
		}

		protected function onMouseMoveHandler( event:MouseEvent ):void
		{
			var key:String = _isVertical ? "y" : "x";
			var temoMousePos:Number = _isVertical ? _parent.mouseY : _parent.mouseX;
			_totalY = temoMousePos - _firstY;

			if ( Math.abs( _totalY ) > _scrollRatio )
				_isTouching = true;

			if ( _isTouching )
			{
				_diffY = temoMousePos - _lastY;
				_lastY = temoMousePos;

				if ( _totalY < _minY )
					_totalY = _minY - Math.sqrt( _minY - _totalY );

				if ( _totalY > _maxY )
					_totalY = _maxY + Math.sqrt( _totalY - _maxY );

				_scrollList[ key ] = _listY + _totalY;
			}
		}

		protected function onMouseUpHandler( event:MouseEvent ):void
		{
			if ( _stage )
			{
				_stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMoveHandler );
				_stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUpHandler );
			}
			onTapDisabled();

			if ( _isTouching )
				event.stopImmediatePropagation();
		}

		protected function listAddedToStageHandler( event:Event ):void
		{
			refresh();
		}

		protected function listRemovedFromStageHandler( event:Event ):void
		{
			removeEvent();
			stopTimer();
		}

//******************* private functions ***********************

		private function initLocalVars():void
		{
			_stage = _scrollList.stage ? _scrollList.stage : _stage;
			_parent = _scrollList.parent;
			_scrollAreaLength = _isVertical ? _listHeight : _listWidth;
			_scrollListLength = _isVertical ? _scrollList.height + 10 : _scrollList.width + 10; // - listHeight;
			if ( _tempContainer )
				_tempContainer.scrollRect = new Rectangle( 0, 0, _listWidth, _listHeight );
			else
				_parent.scrollRect = new Rectangle( 0, 0, _listWidth, _listHeight );
		}

		/**
		 * 只在销毁时和重新指定_scrollList与当前不是同一个对象时会调用
		 */
		private function addInitEvent():void
		{
			if ( _scrollList )
			{
				_scrollList.addEventListener( Event.ADDED_TO_STAGE, listAddedToStageHandler ); // 注册后仅在调用dipose之后才会移除事件
				_scrollList.addEventListener( Event.REMOVED_FROM_STAGE, listRemovedFromStageHandler ); // 注册后仅在调用dipose之后才会移除事件
			}
		}

		private function removeInitEvent():void
		{
			if ( _scrollList )
			{
				_scrollList.removeEventListener( Event.ADDED_TO_STAGE, listAddedToStageHandler ); // 注册后仅在调用dipose之后才会移除事件
				_scrollList.removeEventListener( Event.REMOVED_FROM_STAGE, listRemovedFromStageHandler ); // 注册后仅在调用dipose之后才会移除事件
			}
		}

		/**
		 *
		 */
		private function onTapDisabled():void
		{
			if ( _isTouching )
			{
				_isTouching = false;
				_inertiaY = _diffY;
			}
		}

		private function removeEvent():void
		{
			if ( _scrollList )
			{
				_scrollList.removeEventListener( MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			}
		}

		private function addEvent():void
		{
			if ( _scrollList )
			{
				_scrollList.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			}
		}

		/**
		 * 防止指定的对象有空隙，而创建一个与其大小相等的透萌色块
		 */
		private function createFullArea():void
		{
			var w:Number = _isVertical ? _listWidth : _scrollListLength;
			var h:Number = _isVertical ? _scrollListLength : _listHeight;
			_shape ||= new Shape();
			_shape.graphics.clear();
			_shape.graphics.beginFill( 0, 0 );
			_shape.graphics.drawRect( 0, 0, w, h );
			_shape.graphics.endFill();
			_scrollList.addChildAt( _shape, 0 );
		}

		/**
		 * 创建默认滚动条
		 */
		private function createScrollBar():void
		{
			var areaWH:Number = _scrollAreaLength < _scrollListLength ? ( _scrollAreaLength / ( _scrollListLength ) * _scrollAreaLength ) : _scrollAreaLength;
			if ( _barSkin == null )
			{
				_scrollBar ||= new Sprite();
				if ( _isBarSkin )
				{
					var areaW:Number = _isVertical ? 4 : areaWH;
					var areaH:Number = _isVertical ? areaWH : 4;
					var graphics:Graphics = _scrollBar[ "graphics" ] as Graphics;

					if ( _scrollAreaLength < _scrollListLength )
					{
						graphics.clear();
						graphics.beginFill( 0x505050, .8 );
						graphics.lineStyle( 1, 0x5C5C5C, .8 );
						graphics.drawRoundRect( 0, 0, areaW, areaH, 6, 6 );
						graphics.endFill();
					}
					_scrollBar[ _isVertical ? "x" : "y" ] = ( _scrollAreaLength - _scrollBar[ _isVertical ? "width" : "height" ]);
				}
			}
			else
			{
				_scrollBar = _barSkin;
				_scrollBar[ _isVertical ? "height" : "width" ] = areaWH;
			}
			_scrollBar.alpha = 0;
			if ( _scrollBar.parent == null )
			{
				if ( _tempContainer )
					_tempContainer.addChild( _scrollBar );
				else
					_parent.addChild( _scrollBar );
			}
		}

		private function startTimer():void
		{
			_listRefreshTimer ||= new Timer( 30 );
			_listRefreshTimer.addEventListener( TimerEvent.TIMER, onRefreshTimerHandler );
			_listRefreshTimer.reset();
			_listRefreshTimer.start();
		}

		private function stopTimer():void
		{
			if ( _listRefreshTimer )
			{
				_listRefreshTimer.removeEventListener( TimerEvent.TIMER, onRefreshTimerHandler );
				_listRefreshTimer.stop();
			}
		}

		private function removeSafeFromParent( target:DisplayObject ):void
		{
			if ( target && target.parent )
				target.parent.removeChild( target );
		}

//************* getter/setter ********************************

		public function get scrollList():Sprite
		{
			return _scrollList;
		}

		public function set scrollList( value:Sprite ):void
		{
			if ( _isDispose )
			{
				throw new Error( DISPOSE_ERROR );
			}
			else
			{
				if ( value && _scrollList != value )
				{
					removeInitEvent();
					_startPosx = value.x;
					_startPosy = value.y;
					_scrollList = value;
					if ( _startPosx != 0 && _startPosy != 0 )
					{
						_tempContainer ||= new Sprite();
						_tempContainer.x = _startPosx;
						_tempContainer.y = _startPosy;
						_scrollList.x = 0;
						_scrollList.y = 0;
						removeSafeFromParent( _tempContainer );
					}
					addInitEvent();
				}
			}
		}

	}
}
