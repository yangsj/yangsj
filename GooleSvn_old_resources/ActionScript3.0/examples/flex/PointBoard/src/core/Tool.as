package core 
{
	import api.IArt;
	import api.IOption;
	import api.IPaintBoard;
	import api.ITool;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author King
	 */
	public class Tool extends Sprite implements ITool 
	{
		private   var _option:IOption;
		private   var _toolName:String;
		protected var canPaint:Boolean;
		protected var startX:Number;
		protected var startY:Number;
		protected var _paintBoard:IPaintBoard;
		
		public static const ARROW:String    = 'Arrow';
		public static const PEN:String 		= 'Pen';
		public static const TRIANGLE:String = 'Triangle';
		public static const CIRCLE:String 	= 'Circle';
		public static const SQUARE:String 	= 'Square';
		public static const ZOOM:String 	= 'Zoom';
		public static const HAND:String 	= 'Hand';
		public static const STRAIGHT:String = 'Straight';
		
		public function Tool($toolName:String = 'DEFAULT_NAME') 
		{
			toolName = $toolName;
			
			addEventListener(Event.ADDED_TO_STAGE, stageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, stageHandler);
		}
		
		protected function stageHandler(e:Event):void
		{
			
		}
		
		public function get option():IOption { return _option; }
		
		public function set option(value:IOption):void 
		{
			_option = value;
		}
		
		public function get toolName():String { return _toolName; }
		
		public function set toolName(value:String):void 
		{
			_toolName = value;
		}
		
		public function get paintBoard():IPaintBoard { return _paintBoard; }
		
		public function set paintBoard(value:IPaintBoard):void 
		{
			_paintBoard = value;
		}
		
		override public function toString():String 
		{
			return "[Tool toolName=\"" + toolName + "\"]";
		}
		
		/* INTERFACE api.ITool */
		
		public function draw(e:Event):void
		{
			if ( e.type == MouseEvent.MOUSE_DOWN )
			{
				startX = drawMouseX;
				startY = drawMouseY;
			}
		}
		
		protected function get drawArea():IArt
		{
			return paintBoard.art;
		}
		
		protected function get drawMouseX():Number
		{
			return DisplayObjectContainer(paintBoard.art).mouseX;
		}
		
		protected function get drawMouseY():Number
		{
			return DisplayObjectContainer(paintBoard.art).mouseY;
		}
	}

}