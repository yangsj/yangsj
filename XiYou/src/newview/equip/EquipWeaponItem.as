package newview.equip
{

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import global.Global;

	import ui.equip.ResourceSkillIconSelectedEffectStatus;
	import ui.weapon.ResourceIconBackground;
	import ui.weapon.ResourceWeaponIcons;


	/**
	 * 说明：EquipSkillItem
	 * @author Victor
	 * 2012-11-19
	 */

	public class EquipWeaponItem extends Sprite
	{
		private const WIDTH_HEIGHT : Number = 88;

		private var selectedEffectStatus : Sprite;
		private var _txtName : TextField;
		private var _data : Object;

		protected var iconBg : MovieClip;
		protected var item : MovieClip;

		public function EquipWeaponItem()
		{
			super();
			iconBg = new ResourceIconBackground();
			item = new ResourceWeaponIcons();
			addChild( iconBg );
			iconBg.addChild( item );
			iconBg.width = iconBg.height = WIDTH_HEIGHT;

			selectedEffectStatus = new ResourceSkillIconSelectedEffectStatus();
			selectedEffectStatus.x = -10.6;
			selectedEffectStatus.y = -11.05;
			addChildAt( selectedEffectStatus, 0 );
			selectedEffectStatus.visible = false;

			this.mouseChildren = false;
			addEvents();
		}

		public function seletectedEffectYes() : void
		{
			if ( selectedEffectStatus )
				selectedEffectStatus.visible = true;
		}

		public function seletectedEffectNo() : void
		{
			if ( selectedEffectStatus )
				selectedEffectStatus.visible = false;
		}

		public function refresh( newData : Object = null ) : void
		{
			if ( newData )
				_data = newData;

			if ( txtName )
				txtName.text = getName + "";
			if ( iconBg )
				iconBg.gotoAndStop( 1 );
			if ( item )
				item.gotoAndStop( "lab_" + getResID );
		}

		private function clear() : void
		{
			removeEvents();
			_txtName = null;
		}

		private function addEvents() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromeStageHandler );
		}

		private function removeEvents() : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromeStageHandler );
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			refresh();
		}

		protected function removedFromeStageHandler( event : Event ) : void
		{
			clear();
		}


		///////////////////// get/set ///////////////

		public function get txtName() : TextField
		{
			return _txtName;
		}

		public function set txtName( value : TextField ) : void
		{
			_txtName = value;
		}

		public function get getResID() : String
		{
			return getType + "_" + getId;
		}

		public function get getId() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_ID ))
				return int( data[ EquipType.DATA_ID ]);
			return 1;
		}

		public function get getStar() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_STAR ))
				return int( data[ EquipType.DATA_STAR ]);
			return 1;
		}

		public function get getType() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_TYPE ))
				return int( data[ EquipType.DATA_TYPE ]);
			return 1;
		}

		public function get getName() : String
		{
			if ( _data.hasOwnProperty( EquipType.DATA_NAME ))
				return String( _data[ EquipType.DATA_NAME ]);
			return "";
		}

		public function get getLevel() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_LEVEL ))
				return int( data[ EquipType.DATA_LEVEL ]);
			return 1;
		}

		public function get getAtk() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_ATK ))
				return int( data[ EquipType.DATA_ATK ]);
			return 1;
		}

		public function get getDefense() : int
		{
			if ( _data.hasOwnProperty( EquipType.DATA_DEFENSE ))
				return int( data[ EquipType.DATA_DEFENSE ]);
			return 1;
		}

		public function get data() : Object
		{
			return _data;
		}

		public function set data( value : Object ) : void
		{
			_data = value;
		}



	}

}
