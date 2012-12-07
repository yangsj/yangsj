package view.arena
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.resource.arena.ResourceArenaListItem;


	/**
	 * 说明：ArenaItem
	 * @author Victor
	 * 2012-10-1
	 */

	public class ArenaItem extends Sprite
	{
		private var item : ResourceArenaListItem;

		private var _data : Object;
		private var _callBackFunction:Function;

		public function ArenaItem()
		{
			super();

			item = new ResourceArenaListItem();
			addChild(item);

			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			item.btn.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			item.btn.removeEventListener(MouseEvent.MOUSE_DOWN, onClick);
			if (callBackFunction != null)
			{
				callBackFunction.call(this, this);
			}
		}
		
		protected function removedFromStageHandler(event : Event) : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			callBackFunction = null;
			data = null;
		}
		
		public function initialization():void
		{
			item.txtName.text = playerName;
//			item.txtPower.text = power.toString();
			item.txtPower.text = team.toString(); //test 
			item.txtAward.text = award.toString();
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data(value : Object) : void
		{
			_data = value;
		}

		/**
		 * 点击【比试】按钮的回调函数
		 */
		public function get callBackFunction():Function
		{
			return _callBackFunction;
		}

		/**
		 * @private
		 */
		public function set callBackFunction(value:Function):void
		{
			_callBackFunction = value;
		}
		
		public function get team():Array
		{
			return data.team as Array;
		}
		
		public function get playerName():String
		{
			return String(data.name);
		}
		
		public function get power():Number
		{
			return Number(data.power);
		}
		
		public function get award():Number
		{
			return Number(data.award);
		}
		
		
		


	}

}
