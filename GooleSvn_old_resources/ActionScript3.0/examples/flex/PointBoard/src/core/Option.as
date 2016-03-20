package core 
{
	import api.IOption;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author King
	 */
	public class Option extends Sprite implements IOption 
	{
		private var _options:Object;
		
		public function Option() 
		{
			_options = [];
			
			addEventListener(Event.ADDED_TO_STAGE, stageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, stageHandler);
		}
		
		protected function stageHandler(e:Event):void 
		{
			
		}
		
		public function get options():Object { return _options; }
		
		public function set options(value:Object):void 
		{
			_options = value;
		}
		
		override public function toString():String 
		{
			var s:String = '';
			for ( var i:* in this.options )
			{
				s += i + ' : '  + this.options[i] + '; ';
			}
			return "[Option options: " + s + "]";
		}
	}

}