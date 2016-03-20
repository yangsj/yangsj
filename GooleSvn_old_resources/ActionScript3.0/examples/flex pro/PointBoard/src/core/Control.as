package core 
{
	import api.IControl;
	import api.IPaintBoard;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author King
	 */
	public class Control extends Sprite implements IControl 
	{
		private var _toolControlName:String;
		private var _paintBoard:IPaintBoard;
		
		public static const ADVANCE:String = 'Advance';
		public static const REVOCATION:String = 'Revocation';
		public static const MEMORY:String = 'Memory';
		
		public function Control($toolControName:String = 'DEFAULT_NAME') 
		{
			_toolControlName = $toolControName;
			addEventListener(MouseEvent.CLICK, revocationAndAdvanceHandler);
		}
		
		protected function revocationAndAdvanceHandler(e:MouseEvent):void
		{
			
		}
		
		/* INTERFACE api.IControl */
		
		public function get toolControlName():String {return _toolControlName;}
		
		public function set toolControlName(value:String):void 
		{
			_toolControlName = value;
		}
		
		public function draw(e:Event):void {}
		
		/* INTERFACE api.IControl */
		
		public function get paintBoard():IPaintBoard { return _paintBoard; }
		
		public function set paintBoard(value:IPaintBoard):void 
		{
			_paintBoard = value;
		}
		
	}

}