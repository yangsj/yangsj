package core 
{
	import api.*;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author King
	 */
	public class Art extends Sprite implements IArt 
	{
		
		/**
		 * _element 存放工具所绘制的图形
		 */
		private var _element:Array;
		
		/**
		 * 记录鼠标select()方法中传入的参数
		 */
		private var _selectedElement:DisplayObject;
		
		/**
		 * 是一个数组  记录框选的对象
		 */
		private var _multiSelectedElement:Array;
		
		/**
		 * 是一个容器  框选单个或多个对象存放到该容器
		 */
		private var _spriteContainer:Sprite;
				
		/**
		 * 
		 */
		private var _paindBord:IPaintBoard;
		
		/**
		 * 记录鼠标在画板上按下时的 mouseX
		 */
		private var _startX:Number;
		
		/**
		 * 记录鼠标在画板上按下时的 mouseY
		 */
		private var _startY:Number;
		
		/**
		 * _element 数组长度
		 */
		private var _elementLength:int;
		private var _newElement:Array;
		
		
		public function Art(pb:IPaintBoard) 
		{
			paindBord = pb;
			init();			
		}
		
		private function init():void
		{
			_element = [];
			_newElement = [];
			_multiSelectedElement = [];
			
			// MouseEvent 的三个状态
			addEventListener(MouseEvent.MOUSE_DOWN, stageArtHandler);
			addEventListener(MouseEvent.MOUSE_MOVE, stageArtHandler);
			addEventListener(MouseEvent.MOUSE_UP  , stageArtHandler);
			//
			//addEventListener(KeyboardEvent.KEY_DOWN, stageKeyboardHandler);
			//addEventListener(KeyboardEvent.KEY_UP  , stageKeyboardHandler);
		}
		
		/**
		 * 响应 MouseEvent 侦听的方法
		 * @param	e
		 */
		private function stageArtHandler(e:MouseEvent):void
		{
			paindBord.toolBox.tool.draw(e);
			
			if ( e.type == MouseEvent.MOUSE_DOWN && e.target is IArt ) { this.select(e.target as DisplayObject) }
			else if (e.type == MouseEvent.MOUSE_MOVE) paindBord.toolBox.tool.draw(e);
			else{}
		}
		
		public function del():void
		{
			if ( _selectedElement && _selectedElement.parent ) _selectedElement.parent.removeChild(_selectedElement);
			trace(Boolean(_spriteContainer && _spriteContainer.parent));
			if (_multiSelectedElement && _spriteContainer)
				{
					for (var i:uint = 0; i < _multiSelectedElement.length; i++)
					{
						if (DisplayObject(_multiSelectedElement[i]).parent ) DisplayObject(_multiSelectedElement[i]).parent.removeChild(DisplayObject(_multiSelectedElement[i]));
						if ( _spriteContainer.parent) _spriteContainer.parent.removeChild(_spriteContainer);
					}
					_multiSelectedElement = [];
				}
		}
		
		/* INTERFACE api.IArt */
		
		public function addElement(value:DisplayObject):uint 
		{
			addChild(value);
			Sprite(value).buttonMode = true;
			
			_element.push(value);
			_newElement.push(value);
			
			value.addEventListener(MouseEvent.MOUSE_DOWN, clickToDrawHandler);
			value.addEventListener(MouseEvent.MOUSE_UP  , clickToDrawHandler);
			
			_elementLength = _element.length;
			
			return _element.length;
		}
		
		/* INTERFACE api.IArt */
		
		public function getElementAt(index:int):DisplayObject 
		{
			if ( _element[index] is DisplayObject ) 
				return _element[index];
			return new Sprite();
		}
		
		/* INTERFACE api.IArt */
		
		public function getLastEmlement():DisplayObject 
		{
			return getElementAt(_element.length - 1);
		}
		
		/* INTERFACE api.IArt */
		
		public function select(value:DisplayObject):void
		{
			recoverElement();
			if ( _element.indexOf(value) != -1 )
			{
				value.alpha = 0.5;				
				_selectedElement = value;
			}
		}
		
		private function clickToDrawHandler(e:MouseEvent):void
		{
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				//如果此对象没有子项（此对象不是框选中的），则将此对象作为select(value:DisplayObject)方法的参数运行
				if (DisplayObjectContainer(e.target).numChildren == 0) select(e.target as DisplayObject);
				e.currentTarget.startDrag();
			}
			else e.currentTarget.stopDrag();
		}
		
		/* INTERFACE api.IArt */
		
		public function multiSelect(value:DisplayObject):void 
		{
			recoverElement();
			if (value is IArt ) return;
			_spriteContainer = new Sprite();
			_spriteContainer.buttonMode = true;
			_spriteContainer.mouseChildren = false;			
			addChild(_spriteContainer);
			for (var i:uint = 0; i < _element.length; i++)
			{
				//如果画板中的子项与 value 相交
				if (value.hitTestObject(DisplayObject(_element[i])))
				{
					_multiSelectedElement.push(_element[i]);
					DisplayObject(_element[i]).alpha = 0.5;
					
					_spriteContainer.addChild(DisplayObject(_element[i]));						
					_spriteContainer.addEventListener(MouseEvent.MOUSE_DOWN, clickToDrawHandler);
					_spriteContainer.addEventListener(MouseEvent.MOUSE_UP  , clickToDrawHandler);
				}
			}
		}
		
		public function recoverElement():void
		{
			if (_selectedElement) _selectedElement.alpha = 1;
			if (_multiSelectedElement && _spriteContainer)
			{
				for (var i:uint = 0; i < _multiSelectedElement.length; i++)
				{
					DisplayObject(_multiSelectedElement[i]).alpha = 1;
					
					if (DisplayObject(_multiSelectedElement[i]).parent ) DisplayObject(_multiSelectedElement[i]).parent.removeChild(DisplayObject(_multiSelectedElement[i]));
					addChild(DisplayObject(_multiSelectedElement[i]));
					DisplayObject(_multiSelectedElement[i]).x = DisplayObject(_multiSelectedElement[i]).x + _spriteContainer.x;
					DisplayObject(_multiSelectedElement[i]).y = DisplayObject(_multiSelectedElement[i]).y + _spriteContainer.y;
					if ( _spriteContainer.parent) _spriteContainer.parent.removeChild(_spriteContainer);
				}
				_multiSelectedElement = [];
			}
		}
		
		/* INTERFACE api.IArt */
		
		public function nextElement():void 
		{
			if ( _elementLength >= _element.length)
			{
				_elementLength = _element.length;
			}
			else if (_element.length != 0)
			{
				addChild(_element[_elementLength]);
				_elementLength++;
			}
		}
		
		public function backElement():void 
		{
			if ( _elementLength < 1)
			{
				_elementLength = 0;
			}
			else if (_element.length != 0)
			{
				_elementLength--;
				if (DisplayObject(_element[_elementLength]).parent) DisplayObject(_element[_elementLength]).parent.removeChild(DisplayObject(_element[_elementLength]));
			}
		}
		
		/* INTERFACE api.IArt */
		
		public function addArrayToArray(value:Array):void 
		{
			
		}
		
		/* INTERFACE api.IArt */
		
		public function delElement():void 
		{
			_element.length = _elementLength;
		}
		
		public function get paindBord():IPaintBoard { return _paindBord; }
		
		public function set paindBord(value:IPaintBoard):void 
		{
			_paindBord = value;
		}

	}

}