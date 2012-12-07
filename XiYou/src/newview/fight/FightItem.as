package newview.fight
{

	import datas.RolesID;

	import flash.display.InteractiveObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import global.Global;

	import ui.fight.ResourceFightItem;


	/**
	 * 说明：FightItem
	 * @author Victor
	 * 2012-11-17
	 */

	public class FightItem extends Sprite
	{
		private static var pool : Vector.<FightItem>;

		private var item : ResourceFightItem;
		private var btnFight : InteractiveObject;
		private var _data : Object;
		private var _getTeamID : Array;
		private var _getTeamInfo : String;

		public function FightItem()
		{
			item = new ResourceFightItem();
			btnFight = item.btnFight;
			addChild( item );
		}

		public static function create( itemData : Object ) : FightItem
		{
			var item : FightItem;
			if ( pool == null )
				pool = new Vector.<FightItem>();
			if ( pool.length > 0 )
				item = pool.pop();
			else
				item = new FightItem();
			item.data = itemData;
			item.initialization();
			return item;
		}

		public static function disposePool() : void
		{
			if ( Global.isUsePool == true )
				return;
			if ( pool )
			{
				while ( pool.length > 0 )
					pool.pop();
			}
		}

		public function initialization() : void
		{
			_getTeamInfo = "";
			_getTeamID = null;
			addEvents();
			setTxt();
		}

		private function setTxt() : void
		{
			item.txtLevel.text = getUserLevel + "";
			item.txtName.text = getUserName + "";
			item.txtTeam.htmlText = getTeamInfo;
		}

		private function addEvents() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			btnFight.addEventListener( MouseEvent.CLICK, btnFightClickHandler );
		}

		private function removeEvents() : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			btnFight.removeEventListener( MouseEvent.CLICK, btnFightClickHandler );
		}

		private function getDataIdAndInfo() : void
		{
			if ( getTeams )
			{
				_getTeamInfo = "";
				_getTeamID = [];
				for each ( var obj : Object in getTeams )
				{
					if ( obj )
					{
						var id : int = int( obj.id );
						var level : int = int( obj.level );
						var nameStr : String = RolesID.getName( id );
						_getTeamInfo += nameStr + " <font color='#ff0000'>LV" + level + "</font>  ";
						_getTeamID.push( id );
					}
				}
			}
		}

		protected function btnFightClickHandler( event : MouseEvent ) : void
		{
			Global.stage.dispatchEvent( new FightEvent( FightEvent.FIGHT_CLICK_ITEM, this ));
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();

			pool.push( this );
		}

		private function get getTeamInfo() : String
		{
			if ( !_getTeamInfo )
				getDataIdAndInfo();
			return _getTeamInfo;
		}

		private function get getUserLevel() : int
		{
			return int( _data[ "level" ]);
		}

		private function get getUserName() : String
		{
			return String( _data[ "name" ]);
		}

		private function get getTeams() : Array
		{
			return _data[ "team" ] as Array;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data( value : Object ) : void
		{
			_data = value;
		}

		public function get getTeamID() : Array
		{
			if ( _getTeamID == null )
				getDataIdAndInfo();
			return _getTeamID;
		}


	}

}
