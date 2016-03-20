package core 
{
	import api.IPaintBoard;
	import api.ITool;
	import api.IToolBox;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author King
	 */
	public class ToolBox extends Sprite implements IToolBox 
	{
		private var arrName:Array = ['Arrow', 'Pen', 'Triangle', 'Circle', 'Square', 'Zoom', 'Hand', 'Straight'];
		private var arrNameCN:Array = ['选取', '铅笔', '三角形', '圆形', '矩形', '放大缩小', '拖动画布', '直线'];
		private var _tools:Array;		
		private const TOOL_GRID_HEIGHT:Number = 30;		
		protected var _paintBoard:IPaintBoard;
		protected var _txt:TextField;
		private var _tool:ITool;
		
		public function ToolBox(pb:IPaintBoard) 
		{
			paintBoard = pb;
			init();
		}
		
		private function init():void
		{
			_tools = [];
			_txt = new TextField();
			addEventListener(MouseEvent.MOUSE_DOWN, buttonHandler);
			addEventListener(MouseEvent.MOUSE_UP  , buttonHandler);
		}
		
		/* INTERFACE api.IToolBox */
		
		public function addTool(tool:ITool):void 
		{
			if ( tools.indexOf(tool) == -1 )
			{
				tools.push(tool);
				Sprite(tool).buttonMode = true;
				tool.paintBoard = this.paintBoard;
				DisplayObject(tool).addEventListener(MouseEvent.MOUSE_MOVE, buttonHandler);
				DisplayObject(tool).addEventListener(MouseEvent.MOUSE_OUT , buttonHandler);
			}			
			DisplayObject(tool).y = numTools * TOOL_GRID_HEIGHT;			
			addChild(tool as DisplayObject);			
		}
		
		private function buttonHandler(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN)
			{
				this.tool = e.target as ITool;
				paintBoard.optionArea = this.tool.option;
			}
			else if (e.type == MouseEvent.MOUSE_UP)
			{
				if ( !(this.tool is Arrow) ) paintBoard.art.recoverElement();
				if ( this.tool is Hand ) Sprite(paintBoard.art).buttonMode = true;
				else Sprite(paintBoard.art).buttonMode = false;
			}
			else if (e.type == MouseEvent.MOUSE_MOVE)
			{
				DisplayObject(e.target).x = 3;
				if (_txt) addChild(_txt);
				_txt.background = true;
				_txt.backgroundColor = 0xffffff;
				for (var i:uint = 0; i < arrName.length; i++)
				{
					if (e.target.toolName == arrName[i]) _txt.text = arrNameCN[i];
				}
				_txt.x = this.mouseX + 10;
				_txt.y = this.mouseY - 10;
				_txt.width = 55;
				_txt.height = 20;
			}
			else 
			{
				DisplayObject(e.target).x = 0;
				if (_txt.parent) _txt.parent.removeChild(_txt);
			}
		}
		
		public function getToolIndex(index:int):ITool
		{
			return tools[index] as ITool;
		}
		
		public function getToolByName(name:String):ITool
		{
			for (var i:* in this.tools )
			{
				if ( ITool(tools[i]).toolName == name )
					return tools[i] as ITool;
			}
			
			return new Tool();
		}
		
		public function get numTools():int 
		{
			return tools.length;
		}
		
		private function get tools():Array { return _tools; }
		
		private function set tools(value:Array):void 
		{
			_tools = value;
		}
		
		public function get tool():ITool { return _tool; }
		
		public function set tool(value:ITool):void 
		{
			if ( paintBoard && paintBoard.art) DisplayObjectContainer(paintBoard.art).mouseChildren = ( value is Arrow );
			
			if ( _tool && _tool != value )
			{
				if ( DisplayObject(_tool.option).parent ) DisplayObject(_tool.option).parent.removeChild(DisplayObject(_tool.option) as DisplayObject);
			}
			if ( value.option && !DisplayObject(value.option).parent) stage.addChild(value.option as DisplayObject);
			
			_tool = value;
			
		}
		
		public function get paintBoard():IPaintBoard { return _paintBoard; }
		
		public function set paintBoard(value:IPaintBoard):void 
		{
			_paintBoard = value;
		}
		
	}

}