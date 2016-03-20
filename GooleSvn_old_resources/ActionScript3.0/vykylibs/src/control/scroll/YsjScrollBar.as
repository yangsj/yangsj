package pet.game.panels.continuousLanding.control.scroll
{
	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	/** 
	 * ...
	 * @author yangshengjin
	 */
	public class YsjScrollBar
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private const SCROLLBAR_COLOR:int			= 0XC5D6FC;
		private const SCROLLSLOT_COLOR:int			= 0Xf9f9f7;
		private const SCROLL_BUTTON_NEI_COLOR:int	= 0X4D6185;
		private const SCROLL_BUTTON_WAI_COLOR:int	= 0XC5D6FC;
		private const GLOWFILTER_COLOR:uint			= 0X3888E9;
		
		private const SCROLLBAR_CLICKED_MOVE:int	= 30;
		
		/** ScrollBar x坐标 */
		private var bar_startX:Number;
		/** ScrollBar y坐标 */
		private var bar_startY:Number;
		/** ScrollBar 滑动的 X 方向范围 */
		private var bar_rectangle_X:Number;
		/** ScrollBar 滑动的 Y 方向范围 */
		private var bar_rectangle_Y:Number;
		
		private var _targetValidRect:Number;
		private var _targetStartPointX:Number;
		private var _targetStartPointY:Number;
		private var _scrollBarStartPointX:Number;
		private var _scrollBarStartPointY:Number;
		
		private var _direction:String;						// 默认垂直方向
		private var _maxScrollPosition:Number = 100;		// 
		private var _minScrollPosition:Number = 0;			// 
		
		private var scrollSlotLength:Number = 100;			// 滑条槽 的 长度 或 高度
		private var scrollBarLength:Number = 15;			// 滑条块 的 长度 或 高度
		private var scrollBarThickness:int = 15;			// 厚度
		
		private var _target:DisplayObject;					// 控制的目标对象
		private var _rect:Rectangle;						// 显示范围
		private var _scrollUI:DisplayObjectContainer;		// 
		private var _scrollBar:Sprite;   		    		// 滑条块
		private var _scrollSlot:DisplayObject;  			// 滑条槽
		private var _scrollButtonUp:DisplayObject;			// 所指方向为 向上 或 向左
		private var _scrollButtonDown:DisplayObject;		// 所指方向为 向下 或 向右
		private var _canUseWheel:Boolean = true;
		private var _stage:Stage;
		private var _maskRes:Sprite;						// 遮罩层
		private var _isNeedFilter:Boolean = false;
		
		private var targetName:String;
		private var mouseIsUp:Boolean  = true;
		private var mouseIsOut:Boolean = true;
		private var isDraged:Boolean   = false;
		
		private var clickButtonStart_x:Number;
		private var clickButtonStart_y:Number;
		
		private var upAndDownClickTimer:Timer; // 时间计时器（ButtonUp 和 ButtonDown 按下时移动 bar）
		private var num_upAndDown:Number;	   // 时间计时器中的一个（移动ButtonUp 和 ButtonDown 按下时移动 bar）常量
		
		private var scrollContainer:DisplayObjectContainer;
		
		/** 是否初始化 */
		public var isInitialization:Boolean = false;
		/** 是否已销毁 */
		public var isDispose:Boolean = false;
		/** 是否自动隐藏滚动条显示 */
		public var isAutoVisible:Boolean = true;
		
		/**
		 * 说明：实例化后需要执行initialize方法启动，当target对象从舞台移除后会自动销毁自身里的对象以及引用的对象，用法如：<br>
		 * var scrollbar:ScrollBar = new ScrollBar(target, rect, scrollUI, ScrollBarDirection.VERTICAL);<br>
		 * scrollbar.initialize();//启动<br><br>或者：<br>
		 * var scrollbar:ScrollBar = new ScrollBar();
		 * scrollbar.target = target;<br>
		 * scrollbar.rect   = rect;<br>
		 * scrollbar.direction   = ScrollBarDirection.VERTICAL;<br>
		 * scrollbar.initialize();//启动<br><br>
		 * @param $target   <b>< 必须 ></b>需要滚动的对象
		 * @param $rect   <b>< 必须 ></b>显示的范围 
		 * @param $scrollUI  <b>< 可选 ></b>滚动条设置，对象内 至少包含 scrollSlot 和 scrollBar，另外还可以包含scrollButtonDown和 scrollButtonUp：
		 * <br><li>scrollSlot实例名：slot
		 * <br><li>scrollBar实例名：bar
		 * <br><li>scrollButtonUp实例名：up 或 left
		 * <br><li>scrollButtonDown实例名：down 或 right
		 * @param $direction   <b>< 可选 ></b>滚动条的滚动方向
		 * 
		 */
		public function YsjScrollBar($target:DisplayObject=null, $rect:Rectangle=null, $scrollUI:DisplayObjectContainer=null, $direction:String='vertical')
		{
			target    = $target;
			rect	  = $rect;
			scrollUI  = $scrollUI;
			direction = $direction;
			
			isInitialization = false;
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		public function initialize():void
		{
			isInitialization = true;
			isDispose = false;
			
			createMaskRes();
			initScrollRes();
			JudgeScrollExistent();
			
			upAndDownClickTimer = new Timer(30, int.MAX_VALUE);
			upAndDownClickTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			bar_startX 		= scrollBar.x = YsjScrollBarDirection.HORIZONTAL == direction ? scrollSlot.x : scrollBar.x;
			bar_startY 		= scrollBar.y = YsjScrollBarDirection.HORIZONTAL == direction ? scrollBar.y : scrollSlot.y;
			bar_rectangle_X = YsjScrollBarDirection.HORIZONTAL == direction ? scrollSlot.width  - scrollBar.width : 0;
			bar_rectangle_Y = YsjScrollBarDirection.HORIZONTAL == direction ? 0 : scrollSlot.height - scrollBar.height;
			
			setTargetPoint();
			
			if (stage)
				addAndRemoveEvents(true);
			else
				target.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		public function dispose():void
		{
			isInitialization = false;
			if (isDispose)
				return ;
			addAndRemoveEvents(false);
			if (scrollBar)
			{
				scrollBar.x = bar_startX;//sjScrollBarDirection.HORIZONTAL == direction ? scrollSlot.x : scrollBar.x;
				scrollBar.y = bar_startY;//YsjScrollBarDirection.HORIZONTAL == direction ? scrollBar.y : scrollSlot.y;
				TweenMax.killTweensOf(scrollBar);
			}
			if (_maskRes)
			{
				if (_maskRes.parent) _maskRes.parent.removeChild(_maskRes);
				_maskRes = null;
			}
			if (upAndDownClickTimer)
			{
				upAndDownClickTimer.stop();
				upAndDownClickTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
				upAndDownClickTimer = null;
			}
			if (scrollUI)
				scrollUI.visible = true;
			isDispose = true;
			
			scrollContainer  = null;
			target			 = null;
			scrollButtonUp   = null;
			scrollButtonDown = null;
			scrollBar        = null;
			scrollSlot       = null;
			scrollUI 		 = null;
			rect			 = null;
			
		}
		
		/** 刷新显示 */
		public function refurbish():void
		{
			setTargetPoint();
		}
		
		/** 将组件（scrollSlot 和 scrollBar）设置为指定宽度和高度 */
		public function setSizeScrollBar($scrollSlotLength:Number, $scrollBarLength:Number, $scrollBarThickness:Number):void
		{
			scrollSlotLength   = $scrollSlotLength - $scrollBarThickness * 2;
			scrollBarLength	   = $scrollBarLength;
			scrollBarThickness = $scrollBarThickness;
		}
		
		/** 获取或设置滑条的方向 */
		public function get direction():String { return _direction; }
		
		public function set direction(value:String):void 
		{
			_direction = value;
		}
		
		/** scroll 获取表示滑块当前的位置 或 设置表示滑块将要滚动位置的数字 */
		public function get scrollCurrentPosition():Number
		{
			if (YsjScrollBarDirection.HORIZONTAL == direction)
			{
				return int((scrollBar.x - scrollBarThickness) / barValidMoveLength * maxScrollPosition);
			}
			else if (YsjScrollBarDirection.VERTICAL == direction)
			{
				return int((scrollBar.y - scrollBarThickness) / barValidMoveLength * maxScrollPosition);
			}
			trace(';;;;;;;;;;;;;;;;;');
			new Error('scrollBar 的方向设置不正确');
			
			return  0;
		}
		
		public function set scrollCurrentPosition(value:Number):void 
		{
			if (value > barValidMoveLength) value = barValidMoveLength;
			else if (value < 0) value = 0;
			
			var temp:Number = (value / maxScrollPosition) * barValidMoveLength;
			
			if (scrollBar)
			{
				if (YsjScrollBarDirection.HORIZONTAL == direction) scrollBar.x = temp; 
				else if (YsjScrollBarDirection.VERTICAL == direction) scrollBar.y = temp;	
			}
			
			setTargetPoint();
		}
		
		/** scroll 获取或设置表示最高滚动位置的数字 */
		public function get maxScrollPosition():Number { return _maxScrollPosition; }
		
		public function set maxScrollPosition(value:Number):void 
		{
			_maxScrollPosition = value;
		}
		
		/** scroll 获取或设置表示最低滚动位置的数字 */
		public function get minScrollPosition():Number { return _minScrollPosition; }
		
		public function set minScrollPosition(value:Number):void 
		{
			_minScrollPosition = value;
		}
		
		/** 获取滑块的有效移动的长度 */
		public function get barValidMoveLength():Number { return scrollSlotLength - scrollBarLength; }
		
		/** 鼠标滚轮是否启用 */
		public function get canUseWheel():Boolean { return _canUseWheel; }
		
		public function set canUseWheel(value:Boolean):void 
		{
			_canUseWheel = value;
		}
		
		/** 设定指定的scrollBar（若设定该元素，则需要和scrollSlot、scrollButtonUp、scrollButtonDown） */
		public function get scrollBar():Sprite { return _scrollBar; }
		
		public function set scrollBar(value:Sprite):void 
		{
			_scrollBar = value;
			if (_scrollBar)
			{
				_scrollBarStartPointX = _scrollBar.x;
				_scrollBarStartPointY = _scrollBar.y;
				scrollBarLength = direction == YsjScrollBarDirection.HORIZONTAL ? value.width : value.height;
			}
		}
		
		/** 设定指定的scrollSlot（若设定该元素，则需要和scrollBar、scrollButtonUp、scrollButtonDown） */
		public function get scrollSlot():DisplayObject { return _scrollSlot; }
		
		public function set scrollSlot(value:DisplayObject):void 
		{
			_scrollSlot = value;
			if (_scrollSlot)
			{
				scrollSlotLength = direction == YsjScrollBarDirection.HORIZONTAL ? value.width : value.height;
			}
		}
		
		/** 设定指定的scrollButtonUp（若设定该元素，则需要和scrollBar、scrollSlot、scrollButtonDown） */
		public function get scrollButtonUp():DisplayObject { return _scrollButtonUp; }
		
		public function set scrollButtonUp(value:DisplayObject):void 
		{
			_scrollButtonUp = value;
		}
		
		/** 设定指定的scrollButtonDown（若设定该元素，则需要和scrollBar、scrollSlot、scrollButtonUp） */
		public function get scrollButtonDown():DisplayObject { return _scrollButtonDown; }
		
		public function set scrollButtonDown(value:DisplayObject):void 
		{
			_scrollButtonDown = value;
		}
		
		/** 控制的目标对象 */
		public function get target():DisplayObject { return _target; }
		
		public function set target(value:DisplayObject):void
		{
			_target = value;
			if (_target)
			{
				_targetStartPointX = _target.x;
				_targetStartPointY = _target.y;
				stage = _target.stage;
			}
		}
		
		/** 显示范围 */
		public function get rect():Rectangle { return _rect; }
		
		public function set rect(value:Rectangle):void
		{
			_rect = value;
		}
		
		/** 
		 * <b>scrollUI</b> 至少包含 <b>scrollSlot</b> 和<b> scrollBar</b>，另外还可以包含<b>scrollButtonDown</b> 和 <b>scrollButtonUp</b>。
		 * <br><li><b>scrollSlot</b>实例名：slot
		 * <br><li><b>scrollBar</b>         实例名：bar
		 * <br><li><b>scrollButtonUp</b>    实例名：up 或 left
		 * <br><li><b>scrollButtonDown</b>  实例名：down 或 right
		 */
		public function get scrollUI():DisplayObjectContainer { return _scrollUI; }
		
		public function set scrollUI(value:DisplayObjectContainer):void
		{
			_scrollUI = value;
		}
		
		public function get stage():Stage { return _stage; }
		
		public function set stage(value:Stage):void
		{
			_stage = value;
		}
		
		/** 目标对象的滑动范围 */
		public function get targetValidRect():Number
		{
			if (target)
			{
				if (direction == YsjScrollBarDirection.HORIZONTAL) _targetValidRect = target.width - rect.width;
				else _targetValidRect = target.height - rect.height;
				return _targetValidRect;
			}
			return 0;
		}
		
		private function get canMoveTo():Boolean
		{
			return targetValidRect > 0;
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		/** 判断 scrollBar 和 scrollSlot 是否存在， 若不存在则自动创建 */
		private function JudgeScrollExistent():void
		{
			if ( scrollBar == null || scrollSlot == null)
			{
				scrollContainer = new Sprite();
				if ( direction == YsjScrollBarDirection.HORIZONTAL)
				{	
					scrollSlot		   = setScrollSprite(SCROLLSLOT_COLOR, scrollSlotLength, scrollBarThickness);
					scrollBar 		   = setScrollSprite(SCROLLBAR_COLOR , scrollBarLength , scrollBarThickness);
					if (scrollButtonUp == null)
					{
						scrollButtonUp     = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 180, SCROLL_BUTTON_NEI_COLOR);
						scrollButtonDown   = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 0  , SCROLL_BUTTON_NEI_COLOR);
					}
					
					scrollButtonUp.x   =
						scrollButtonUp.y   = 
						scrollSlot.x 	   = 
						scrollBar.x 	   = scrollBarThickness;
					scrollButtonDown.x = scrollBarThickness + scrollSlotLength;
				}
				else if (direction == YsjScrollBarDirection.VERTICAL)
				{
					scrollSlot = setScrollSprite(SCROLLSLOT_COLOR, scrollBarThickness, scrollSlotLength);
					scrollBar  = setScrollSprite(SCROLLBAR_COLOR , scrollBarThickness, scrollBarLength );
					if (scrollButtonUp == null)
					{
						scrollButtonUp   = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 270, SCROLL_BUTTON_NEI_COLOR);
						scrollButtonDown = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 90 , SCROLL_BUTTON_NEI_COLOR);
					}
					
					scrollButtonUp.y   = 
						scrollSlot.y 	   = 
						scrollBar.y 	   = scrollBarThickness;
					scrollButtonDown.x = scrollBarThickness;
					scrollButtonDown.y = scrollBarThickness + scrollSlotLength;
				}
				scrollContainer.addChild(scrollButtonUp   as DisplayObject);
				scrollContainer.addChild(scrollSlot 	  as DisplayObject);
				scrollContainer.addChild(scrollBar		  as DisplayObject);
				scrollContainer.addChild(scrollButtonDown as DisplayObject);
				
				if (scrollUI)
				{
					scrollContainer.x = scrollUI.x;
					scrollContainer.y = scrollUI.y;
					scrollUI.visible = false;
				}
				else 
				{
					scrollContainer.x = (direction == YsjScrollBarDirection.HORIZONTAL) ? target.x : target.x + rect.width;
					scrollContainer.y = (direction == YsjScrollBarDirection.HORIZONTAL) ? target.y + rect.height : target.y;
				}
				
				target.parent.addChild(scrollContainer);
				
				_isNeedFilter = true;
			}
			else
			{
				scrollContainer = scrollUI;
				_isNeedFilter = false;
				if (scrollButtonUp == null)
				{
					scrollButtonUp   = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 270, SCROLL_BUTTON_NEI_COLOR);
				}
				if (scrollButtonDown == null)
				{
					scrollButtonDown = setScrollSprite(SCROLL_BUTTON_WAI_COLOR, scrollBarThickness, scrollBarThickness, true, 90 , SCROLL_BUTTON_NEI_COLOR);
				}
				scrollBarThickness = (direction == YsjScrollBarDirection.HORIZONTAL) ? scrollSlot.x : scrollSlot.y;
			}
		}
		
		private function initScrollRes():void
		{
			if (scrollUI)
			{
				if (scrollUI["slot"])
					scrollSlot = scrollUI["slot"];
				else 
					readScrollUIParam();
				
				if (scrollUI["bar"])
					scrollBar  = scrollUI["bar"];
				else 
					readScrollUIParam();
				
				if (scrollUI["up"])    scrollButtonUp = scrollUI["up"];
				if (scrollUI["left"])  scrollButtonUp = scrollUI["left"];
				if (scrollUI["down"])  scrollButtonDown = scrollUI["down"];
				if (scrollUI["right"]) scrollButtonDown = scrollUI["right"];
			}
			else
			{
				readScrollUIParam();
			}
		}
		
		/**
		 * 
		 */
		private function readScrollUIParam():void
		{
			if (scrollUI)
			{
				if (direction == YsjScrollBarDirection.HORIZONTAL)
					setSizeScrollBar(scrollUI.width, scrollUI.height, scrollUI.height);
				else
					setSizeScrollBar(scrollUI.height, scrollUI.width, scrollUI.width);
			}
			else if (rect)
			{
				if (direction == YsjScrollBarDirection.HORIZONTAL)
					setSizeScrollBar(rect.width, scrollBarLength, scrollBarThickness);
				else
					setSizeScrollBar(rect.height, scrollBarLength, scrollBarThickness);
			}
		}
		
		/** 
		 * 设置 目标对象 的动态位置
		 */
		private function setTargetPoint():void
		{
			if (scrollContainer && isAutoVisible)
				scrollContainer.visible = targetValidRect > 0 ? true : false;
			if (targetValidRect<=0)
			{
				if (target)
				{
					if (YsjScrollBarDirection.HORIZONTAL == direction) target.x = _targetStartPointX; 
					else if (YsjScrollBarDirection.VERTICAL == direction) target.y = _targetStartPointY;
				}
					
				return;
			}
			
			var temp:Number = scrollCurrentPosition / maxScrollPosition;
			if (temp > 1) temp = 1;
			else if (temp < 0) temp = 0;
			
			temp = temp * targetValidRect;
			if (target)
			{
				if (YsjScrollBarDirection.HORIZONTAL == direction) target.x = _targetStartPointX - temp; 
				else if (YsjScrollBarDirection.VERTICAL == direction) target.y = _targetStartPointY - temp;
			}
		}
		
		// 创建指定的元素（Sprite）
		private function setScrollSprite($color:uint, $width:Number, $height:Number, isButton:Boolean = false, $rotation:Number = 0, $color_2:uint = 0):Sprite
		{
			var spr:Sprite = new Sprite();
			
			spr.graphics.beginFill($color);
			spr.graphics.drawRect(0, 0, $width, $height);
			spr.graphics.endFill();
			
			if (isButton)
			{
				var spr1:Sprite = new Sprite();
				spr1.graphics.lineStyle(3, $color_2);
				spr1.graphics.moveTo($width / 3, $width / 5);
				spr1.graphics.lineTo($width * 3 / 4, $width / 2);
				spr1.graphics.lineTo($width / 3, $width * 4 / 5);
				spr1.graphics.endFill();
				spr.rotation = $rotation;
				
				spr.addChild(spr1);
			}
			spr.buttonMode    = true;
			spr.mouseChildren = false;
			return spr;
		}
		
		// 设置滤镜效果
		private function setGlowFilter(color:uint = 16711680, alpha:Number = 1, blurX:Number = 6, blurY:Number = 6, strength:Number = 2, quality:int = 1, inner:Boolean = false, knockout:Boolean = false):GlowFilter
		{
			var glowFilter:GlowFilter = new GlowFilter(color, alpha, blurX, blurY, strength, quality, inner, knockout);
			return glowFilter;
		}
		
		/** 创建遮罩层 */
		private function createMaskRes():void
		{
			_maskRes = new Sprite();
			_maskRes.graphics.beginFill(0xff0000);
			_maskRes.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			_maskRes.graphics.endFill();
			_maskRes.x = target.x;
			_maskRes.y = target.y;
			target.parent.addChild(_maskRes);
			target.mask = _maskRes;
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isDispose)
				return ;
			if (isAdd)
			{
				scrollBar.addEventListener(MouseEvent.MOUSE_DOWN , scrollBarHandler);
				scrollBar.addEventListener(MouseEvent.MOUSE_OVER , scrollBarHandler);
				scrollBar.addEventListener(MouseEvent.MOUSE_OUT  , scrollBarHandler);
				stage.addEventListener(MouseEvent.MOUSE_UP 	 , scrollBarHandler);
				stage.addEventListener(MouseEvent.MOUSE_MOVE , scrollBarHandler);
				if (canUseWheel)
				{
					scrollContainer.addEventListener(MouseEvent.MOUSE_WHEEL, scrollBarHandler);
					target.addEventListener(MouseEvent.MOUSE_WHEEL, scrollBarHandler);
				}
				
				target.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
				
				scrollSlot.addEventListener(MouseEvent.CLICK     , scrollSlotClickHandler);
				scrollSlot.addEventListener(MouseEvent.MOUSE_OVER, scrollSlotClickHandler);
				scrollSlot.addEventListener(MouseEvent.MOUSE_OUT , scrollSlotClickHandler);
				
				scrollButtonUp.addEventListener(MouseEvent.MOUSE_OVER  , scrollButtonHandler);
				scrollButtonUp.addEventListener(MouseEvent.MOUSE_OUT   , scrollButtonHandler);
				scrollButtonUp.addEventListener(MouseEvent.MOUSE_DOWN  , scrollButtonHandler);
				scrollButtonUp.addEventListener(MouseEvent.MOUSE_UP    , scrollButtonHandler);
				
				scrollButtonDown.addEventListener(MouseEvent.MOUSE_OVER, scrollButtonHandler);
				scrollButtonDown.addEventListener(MouseEvent.MOUSE_OUT , scrollButtonHandler);
				scrollButtonDown.addEventListener(MouseEvent.MOUSE_DOWN, scrollButtonHandler);
				scrollButtonDown.addEventListener(MouseEvent.MOUSE_UP  , scrollButtonHandler);
			}
			else
			{
				scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN , scrollBarHandler);
				scrollBar.removeEventListener(MouseEvent.MOUSE_OVER , scrollBarHandler);
				scrollBar.removeEventListener(MouseEvent.MOUSE_OUT  , scrollBarHandler);
				stage.removeEventListener(MouseEvent.MOUSE_UP   , scrollBarHandler);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE , scrollBarHandler);
				scrollBar.removeEventListener(MouseEvent.MOUSE_DOWN, scrollBarHandler);
				target.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
				
				if (canUseWheel)
				{
					scrollContainer.removeEventListener(MouseEvent.MOUSE_WHEEL, scrollBarHandler);
					target.removeEventListener(MouseEvent.MOUSE_WHEEL, scrollBarHandler);
				}
				
				target.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
				
				scrollSlot.removeEventListener(MouseEvent.CLICK     , scrollSlotClickHandler);
				scrollSlot.removeEventListener(MouseEvent.MOUSE_OVER, scrollSlotClickHandler);
				scrollSlot.removeEventListener(MouseEvent.MOUSE_OUT , scrollSlotClickHandler);
				
				scrollSlot.removeEventListener(MouseEvent.CLICK     , scrollSlotClickHandler);
				scrollSlot.removeEventListener(MouseEvent.MOUSE_OVER, scrollSlotClickHandler);
				scrollSlot.removeEventListener(MouseEvent.MOUSE_OUT , scrollSlotClickHandler);
				
				scrollButtonUp.removeEventListener(MouseEvent.MOUSE_DOWN  , scrollButtonHandler);
				scrollButtonUp.removeEventListener(MouseEvent.MOUSE_OVER  , scrollButtonHandler);
				scrollButtonUp.removeEventListener(MouseEvent.MOUSE_OUT   , scrollButtonHandler);
				scrollButtonUp.removeEventListener(MouseEvent.MOUSE_UP    , scrollButtonHandler);
				
				scrollButtonDown.removeEventListener(MouseEvent.MOUSE_DOWN, scrollButtonHandler);
				scrollButtonDown.removeEventListener(MouseEvent.MOUSE_OVER, scrollButtonHandler);
				scrollButtonDown.removeEventListener(MouseEvent.MOUSE_OUT , scrollButtonHandler);
				scrollButtonDown.removeEventListener(MouseEvent.MOUSE_UP  , scrollButtonHandler);
			}
		}
		
		private function addedToStageHandler(e:Event):void
		{
			stage = target.stage;
			addAndRemoveEvents(true);
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			if (direction == YsjScrollBarDirection.HORIZONTAL)
			{
				clickButtonStart_x = scrollBar.x + num_upAndDown;
				if (clickButtonStart_x > barValidMoveLength + scrollBarThickness) clickButtonStart_x = barValidMoveLength + scrollBarThickness;
				if (clickButtonStart_x < scrollBarThickness) clickButtonStart_x = scrollBarThickness;
				
				TweenMax.to(scrollBar, 0.3, { x:clickButtonStart_x   , roundProps:["x"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
			}
			else if (direction == YsjScrollBarDirection.VERTICAL)
			{
				clickButtonStart_y = scrollBar.y + num_upAndDown;
				if (clickButtonStart_y > barValidMoveLength + scrollBarThickness) clickButtonStart_y = barValidMoveLength + scrollBarThickness;
				if (clickButtonStart_y < scrollBarThickness) clickButtonStart_y = scrollBarThickness;
				
				TweenMax.to(scrollBar, 0.3, { y:clickButtonStart_y   , roundProps:["y"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
			}
		}
		
		private function removeFromStageHandler(e:Event):void 
		{
			dispose();
		}
		
		private function scrollBarHandler(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.MOUSE_OVER)
			{
				mouseIsOut = false;
				if (_isNeedFilter) scrollBar.filters = [ setGlowFilter(GLOWFILTER_COLOR,1,10,10,1,3,true,false)];
			}
			else if (e.type == MouseEvent.MOUSE_OUT)
			{
				mouseIsOut = true;
				if (mouseIsUp) scrollBar.filters = null;
			}
			else if (e.type == MouseEvent.MOUSE_DOWN)
			{
				if (canMoveTo)
				{
					scrollBar.startDrag(false, new Rectangle(bar_startX, bar_startY, bar_rectangle_X, bar_rectangle_Y));
					mouseIsUp = false;
					if (_isNeedFilter) scrollBar.filters = [ setGlowFilter(GLOWFILTER_COLOR, 1, 15, 15, 2, 3, true, false)];
					isDraged = true;
//					target.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLLBAR_PRESS_DOWN));
				}
			}
			else if (e.type == MouseEvent.MOUSE_UP)
			{
				scrollBar.stopDrag();
				if (isDraged)
//					target.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLLBAR_PRESS_UP));
					isDraged = false;
				
				if (mouseIsOut)scrollBar.filters = null;
				else if (_isNeedFilter) scrollBar.filters = [ setGlowFilter(GLOWFILTER_COLOR, 1, 15, 15, 1, 3, true, false)];
				
				mouseIsUp = true;
			}
			else if (e.type == MouseEvent.MOUSE_MOVE)
			{
				if (!mouseIsUp && canMoveTo)
				{
//					target.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLLBAR_DRAG));
					setTargetPoint();
				}
			}
			else if (e.type == MouseEvent.MOUSE_WHEEL)
			{
				if (canMoveTo == false)
					return ;
				var bar_move_y:Number;
				var bar_move_x:Number;
				if (direction == YsjScrollBarDirection.VERTICAL)
				{
					bar_move_y = scrollBar.y;
					bar_move_y -= e.delta * 20;
					if (bar_move_y < scrollBarThickness) bar_move_y = scrollBarThickness;
					if (bar_move_y > bar_rectangle_Y + scrollBarThickness) bar_move_y = bar_rectangle_Y + scrollBarThickness;
					
					TweenMax.to(scrollBar, 1, { y:bar_move_y   , roundProps:["y"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
				else if (direction == YsjScrollBarDirection.HORIZONTAL)
				{
					bar_move_x = scrollBar.x;
					bar_move_x += e.delta * 15;
					if (bar_move_x < scrollBarThickness) bar_move_x = scrollBarThickness;
					if (bar_move_x > bar_rectangle_X + scrollBarThickness) bar_move_x = bar_rectangle_X + scrollBarThickness;
					
					TweenMax.to(scrollBar, 1, { x:bar_move_x   , roundProps:["x"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
			}
		}
		
		private function scrollButtonHandler(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.CLICK)
			{
				if (canMoveTo == false)
					return ;
				var tempStart:Number;
				if (direction == YsjScrollBarDirection.HORIZONTAL)
				{
					tempStart = e.target == scrollButtonUp ? (scrollBar.x - SCROLLBAR_CLICKED_MOVE) : (scrollBar.x + SCROLLBAR_CLICKED_MOVE);
					
					if ( tempStart > barValidMoveLength + scrollBarThickness) tempStart = barValidMoveLength + scrollBarThickness;
					if ( tempStart < scrollBarThickness) tempStart = scrollBarThickness;
					
					scrollButtonUp.scaleX = scrollButtonUp.scaleY = 1;
					
					TweenMax.to(scrollBar, 1, { x:tempStart, roundProps:["x"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
				else if (direction == YsjScrollBarDirection.VERTICAL)
				{
					tempStart = e.target == scrollButtonUp ? (scrollBar.y - SCROLLBAR_CLICKED_MOVE) : (scrollBar.y + SCROLLBAR_CLICKED_MOVE);
					
					if ( tempStart > barValidMoveLength + scrollBarThickness) tempStart = barValidMoveLength + scrollBarThickness;
					if ( tempStart < scrollBarThickness) tempStart = scrollBarThickness;
					
					scrollButtonDown.scaleX = scrollButtonDown.scaleY = 1;
					
					TweenMax.to(scrollBar, 1, { y:tempStart, roundProps:["y"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
			}
			else if (e.type == MouseEvent.MOUSE_OVER)
			{
				if (e.target == scrollButtonUp && _isNeedFilter) scrollButtonUp.filters = [ setGlowFilter(SCROLL_BUTTON_WAI_COLOR, 1, 15, 15, 1, 3, true, false)];
				else if (e.target == scrollButtonDown && _isNeedFilter) scrollButtonDown.filters = [ setGlowFilter(SCROLL_BUTTON_WAI_COLOR, 1, 15, 15, 1, 3, true, false)];
			}
			else if (e.type == MouseEvent.MOUSE_OUT)
			{
				scrollButtonUp.filters = null; 
				scrollButtonDown.filters = null;
			}
			else if (e.type == MouseEvent.MOUSE_DOWN)
			{
				if (canMoveTo == false)
					return ;
				if (e.target == scrollButtonUp) num_upAndDown = -15;
				else if (e.target == scrollButtonDown) num_upAndDown = 15;
				upAndDownClickTimer.start();
			}
			else if (e.type == MouseEvent.MOUSE_UP)
			{
				upAndDownClickTimer.stop();
			}
		}
		
		private function scrollSlotClickHandler(e:MouseEvent):void 
		{
			if (e.type == MouseEvent.CLICK)
			{
				if (canMoveTo == false)
					return ;
				if (direction == YsjScrollBarDirection.VERTICAL)
				{
					var bar_move_y:Number = DisplayObject(e.target).mouseY - (scrollBar.height* 0.5) + scrollBarThickness;
					if (bar_move_y < scrollBarThickness) bar_move_y = scrollBarThickness;
					if (bar_move_y > bar_rectangle_Y + scrollBarThickness) bar_move_y = bar_rectangle_Y + scrollBarThickness;
					
					TweenMax.to(scrollBar, 1, { y:bar_move_y   , roundProps:["y"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
				else if (direction == YsjScrollBarDirection.HORIZONTAL)
				{
					var bar_move_x:Number = DisplayObject(e.target).mouseX - (scrollBar.width * 0.5) + scrollBarThickness;
					if (bar_move_x < scrollBarThickness) bar_move_x = scrollBarThickness;
					if (bar_move_x > bar_rectangle_X + scrollBarThickness) bar_move_x = bar_rectangle_X + scrollBarThickness;
					
					TweenMax.to(scrollBar, 1, { x:bar_move_x   , roundProps:["x"], onUpdateListener:onUpdateHandler, onCompleteListener:completeHandler } );
				}
			}
			else if (e.type == MouseEvent.MOUSE_OVER)
			{
				if (_isNeedFilter) scrollSlot.filters = [ setGlowFilter(GLOWFILTER_COLOR, 1, 2, 2, 1, 3, true, false)];
			}
			else if (e.type == MouseEvent.MOUSE_OUT)
			{
				scrollSlot.filters = null;
			}
		}
		
		private function onUpdateHandler(e:TweenEvent):void 
		{
			//			target.dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLLBAR_CHENGE));
			setTargetPoint();
		}
		
		private function completeHandler(e:TweenEvent):void
		{
			TweenMax.killTweensOf(e.target);
			setTargetPoint();
		}
		
		
	}
	
}