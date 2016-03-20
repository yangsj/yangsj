package core 
{
	import api.*;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class PaintBoard extends Sprite implements IPaintBoard 
	{
		private var _art:IArt;
		private var _toolBox:IToolBox;
		private var _optionArea:IOption;
		private var _controlBox:IControlBox;
		private var _startX:Number;
		private var _startY:Number;
		private var _sprite:Sprite;
		private var _canPaint:Boolean;
		
		
		public function PaintBoard() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			initToolBox();
			initArt();
			initEvent();
		}
		
		private function initToolBox():void
		{
			toolBox = new ToolBox(this);
			
			toolBox.addTool(new Arrow   ());
			toolBox.addTool(new Hand    ());			
			toolBox.addTool(new Pen     ());
			toolBox.addTool(new Straight());
			toolBox.addTool(new Square  ());
			toolBox.addTool(new Circle  ());
			toolBox.addTool(new Triangle());
			toolBox.addTool(new Zoom    ());
			
			controlBox = new ControlBox(this);
			controlBox.addControlTool(new Revocation());
			controlBox.addControlTool(new Advance   ());
			controlBox.addControlTool(new Memory    ());
			
			DisplayObject(toolBox).x = 5;			
			addChild(toolBox as DisplayObject);
			
			DisplayObject(controlBox).y = 370;
			addChild(controlBox as DisplayObject);
	
			toolBox.tool = toolBox.getToolIndex(0);
		}
		
		private function initArt():void
		{
			var mc = new MC();
			var newBorder:NewBorder = new NewBorder();
			addChildAt(newBorder, numChildren);
			addChild(mc);
			mc.x = newBorder.x = 45;
			mc.y = newBorder.y = 60;
			art = new Art(this);
			//DisplayObject(art).x = 45;
			//DisplayObject(art).y = 60;
			
			DisplayObject(art).x = 295;
			DisplayObject(art).y = 210;			
			DisplayObject(art).mask = mc;
			
			addChildAt(art as DisplayObject, 0);
		}
		
		private function initEvent():void
		{
			//stage.addEventListener(MouseEvent.MOUSE_DOWN , stageHandler);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE , stageHandler);
			//stage.addEventListener(MouseEvent.MOUSE_UP   , stageHandler);
			//stage.addEventListener(Event.MOUSE_LEAVE     , stageHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stageHandler);
			//stage.addEventListener(KeyboardEvent.KEY_UP  , stageHandler);
		}
		
		private function stageHandler(e:KeyboardEvent):void
		{
			if ( e.keyCode == 32 ) art.del();
			
		}
		
		public function get art():IArt { return _art; }
		
		public function set art(value:IArt):void 
		{
			_art = value;
		}
		
		public function get toolBox():IToolBox { return _toolBox; }
		
		public function set toolBox(value:IToolBox):void 
		{
			_toolBox = value;
		}
		
		public function get optionArea():IOption { return _optionArea; }
		
		public function set optionArea(value:IOption):void 
		{
			_optionArea = value;
		}
		
		public function get controlBox():IControlBox { return _controlBox; }
		
		public function set controlBox(value:IControlBox):void 
		{
			_controlBox = value;
		}
	}

}