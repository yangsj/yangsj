package view.battle
{

	import datas.RolesID;
	import datas.TeamInfoData;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.DeviceType;
	import global.Global;
	
	import view.ViewBase;


	/**
	 * 说明：BattleRoleStatusView
	 * @author Victor
	 * 2012-10-18
	 */

	public class BattleRoleStatusView extends Sprite
	{
		private var item_const_width : Number = 83;
		private var item_const_height : Number = 83;
		private var item_start_x : Number = 35;
		private var item_start_y : Number = 2.2;
		private var item_distance : Number = 95;


		private var _data : Array = TeamInfoData.selected;

		private var container : Sprite;
		private var blackColorMask : Sprite;

		public var callBackFromItemClick : Function;

		public function BattleRoleStatusView()
		{
			super();

			setConstVars();
			createResource();
		}

		public function initialize() : void
		{
			layoutItem();
		}

		private function dispose() : void
		{
			_data = null;
			container = null;
			blackColorMask = null;
			callBackFromItemClick = null;
		}

		private function createResource() : void
		{
			container = new Sprite();
//			blackColorMask = new Sprite();

			addChild(container);
		}

		private function layoutItem() : void
		{
			container.graphics.clear();
			while (container.numChildren > 0)
				container.removeChildAt(0);

			var num : int = 0;
			var length : int = data.length;
			for (var i : int = 0; i < length; i++)
			{
				var item : BattleRoleItem = new BattleRoleItem();
				item.x = item_start_x + item_distance * num;
				item.y = item_start_y;
				item.isSkillEnabled = (RolesID.canUseSkillRoleId.indexOf(data[i]) != -1) && i < 4;
				item.width = item_const_width;
				item.height = item_const_height;
				item.id = data[i];
				item.callBackFun = callBackFromItemClick;
				item.initialize();
				container.addChild(item);
				num++;
			}
			var w : Number = item_start_x + item_distance * num;
			var h : Number = item_const_height;

			container.graphics.beginFill(0x000000, 0.8);
			container.graphics.drawRoundRect(0, 0, w, h + item_start_y * 2, 10, 10);
			container.graphics.endFill();
		}

		private function setConstVars() : void
		{
			if (Global.isDifferenceSwf && Global.deviceType == DeviceType.ANDROID)
			{
				item_const_width = 65;
				item_const_height = 65;
				item_start_x = 26;
				item_start_y = 1.7;
				item_distance = 74;
			}
			else
			{
				item_const_width = 83;
				item_const_height = 83;
				item_start_x = 33;
				item_start_y = 2.2;
				item_distance = 95;
			}
		}

		private function addEvents() : void
		{
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		private function removeEvents() : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}

		protected function removedFromStageHandler(event : Event) : void
		{
			removeEvents();
		}

		///////////////////// getter/setter //////////////////////////

		public function get data() : Array
		{
			return _data;
		}

		public function set data(value : Array) : void
		{
			_data = value;
		}


	}

}
