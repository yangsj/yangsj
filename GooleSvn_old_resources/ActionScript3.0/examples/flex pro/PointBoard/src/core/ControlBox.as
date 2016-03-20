package core 
{
	import api.IControl;
	import api.IControlBox;
	import api.IPaintBoard;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author King
	 */
	public class ControlBox extends Sprite implements IControlBox 
	{
		private var _controls:Array;
		private const CONTROL_WIDTH:Number = 30;
		private var _toolControl:IControl;
		
		private var _txt:TextField;
		
		protected var _paintBoard:IPaintBoard;
		
		public function ControlBox(pb:IPaintBoard) 
		{
			paintBoard = pb;
			init();
		}
		
		private function init():void
		{
			_controls = [];
			_txt = new TextField();
			addEventListener(MouseEvent.MOUSE_MOVE, controlBoxHandler);
			addEventListener(MouseEvent.MOUSE_OUT , controlBoxHandler);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function controlBoxHandler(e:MouseEvent):void
		{
			if ( e.type == MouseEvent.MOUSE_MOVE )
			{
				e.target.y = -3;
				if (_txt) addChild(_txt);
				if (e.target is Advance) _txt.text = '前进';
				else if (e.target is Revocation) _txt.text = '撤消';
				else _txt.text = '保存';
				_txt.background = true;
				_txt.backgroundColor = 0xffffff;
				_txt.x = this.mouseX - 5;
				_txt.y = this.mouseY - 20;
				_txt.height = 18;
				_txt.width = 30;
			}
			else
			{
				if (_txt.parent) _txt.parent.removeChild(_txt);
				e.target.y = 0
			}
		}
		
		/* INTERFACE api.IControlBox */
		
		public function addControlTool(toolControl:IControl):void 
		{
			if (controls.indexOf(toolControl) == -1)
			{
				controls.push(toolControl);
				toolControl.paintBoard = this.paintBoard;
			}
			DisplayObject(toolControl).x = numControlTools * CONTROL_WIDTH + 370;
			
			Sprite(toolControl).buttonMode = true;
			
			addChild(toolControl as DisplayObject);
		}
		
		public function getControlToolIndex(index:int):IControl 
		{
			return _controls[index] as IControl;
		}
		
		public function getControlToolByName(name:String):IControl 
		{
			for (var i:* in this.controls )
			{
				if ( IControl(controls[i]).toolControlName == name ) return controls[i] as IControl;
			}			
			return new Control();
		}
		
		public function get numControlTools():int 
		{
			return controls.length;
		}
		
		public function get toolControl():IControl 
		{
			return _toolControl;
		}
		
		public function set toolControl(value:IControl):void 
		{
			_toolControl = value;
		}
		
		public function get controls():Array { return _controls; }
		
		public function set controls(value:Array):void 
		{
			_controls = value;
		}
		
		public function get paintBoard():IPaintBoard { return _paintBoard; }
		
		public function set paintBoard(value:IPaintBoard):void 
		{
			_paintBoard = value;
		}
		
	}

}