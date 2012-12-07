package newview.intensify
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 说明：IntensifyListItemBase
	 * @author Victor
	 * 2012-11-20
	 */
	
	public class IntensifyListItemBase extends Sprite
	{
		protected var item:MovieClip;
		
		protected var _isSelected:Boolean;
		protected var _data:Object;
		
		public function IntensifyListItemBase()
		{
			super();
			createResource(); 
			mouseChildren = false;
			selectedEffectNo();
			addEvents();
		}
		
		protected function createResource():void
		{ 
			this.graphics.beginFill(0xff0000, 0.7);
			this.graphics.drawRect(0,0,412,94);
			this.graphics.endFill();
		}
		
		protected function addEvents():void
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function removeEvents():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function clear():void
		{
			item = null;
		}
		
		
		protected function addedToStageHandler(event:Event):void
		{
			
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEvents();
			clear();
		}		
		
		
		public function selectedEffectYes():void
		{
			if (item)
				item.gotoAndStop(2);
			_isSelected = true;
		}
		
		public function selectedEffectNo():void
		{
			if (item)
				item.gotoAndStop(1);
			_isSelected = false;
		}

		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function get listType():int
		{
			return 0;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get getResID():String
		{
			return getType + "_" + getId;
		}
		
		public function get getId():int
		{
			if (_data.hasOwnProperty("id"))
				return int(_data["id"]);
			return 1;
		}
		
		public function get getStar():int
		{
			if (_data.hasOwnProperty("star"))
				return int(_data["star"]);
			return 1;
		}
		
		public function get getLevel():int
		{
			if (_data.hasOwnProperty("level"))
				return int(_data["level"]);
			return 1;
		}
		
		public function get getName():String
		{
			if (_data.hasOwnProperty("name"))
				return String(_data["name"]);
			return "";
		}
		
		public function get getType():int
		{
			if (_data.hasOwnProperty("type"))
				return int(_data["type"]);
			return 1;
		}
		
		
		
	}
	
}