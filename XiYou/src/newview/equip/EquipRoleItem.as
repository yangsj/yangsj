package newview.equip
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import global.Global;

	import newview.ui.HeadPhotoBase;
	import newview.ui.HeadPhotoRound;

	import ui.team.ResourceTeamRoleHeadBgMask;


	/**
	 * 说明：EquipRoleItem
	 * @author Victor
	 * 2012-11-19
	 */

	public class EquipRoleItem extends Sprite
	{
		private const WIDTH : Number = 128;

		private var headPhoto : HeadPhotoBase;
		private var roleHeadMask : Sprite;

		private var _data : Object;

		public function EquipRoleItem()
		{
			this.mouseChildren = false;

			roleHeadMask = new ResourceTeamRoleHeadBgMask();
			addChild( roleHeadMask );

			headPhoto = new HeadPhotoRound();
			addChild( headPhoto );

			this.scaleX = this.scaleY = ( WIDTH / this.width );

			addEvents();
		}

		public function selectedEffectYes() : void
		{
			if ( headPhoto )
				headPhoto.selectedEffectYes();
		}

		public function selectedEffectNo() : void
		{
			if ( headPhoto )
				headPhoto.selectedEffectNo();
		}

		protected function addEvents() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler ); 
		}

		protected function removeEvents() : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler ); 
		} 

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			if ( headPhoto )
				headPhoto.setId( getId );
		}




		public function get getId() : int
		{
			if ( _data.hasOwnProperty( "id" ))
				return int( _data[ "id" ]);
			return 0;
		}

		public function get getLevel() : int
		{
			if ( _data.hasOwnProperty( "level" ))
				return int( _data[ "level" ]);
			return -1;
		}

		public function get getAtk() : int
		{
			if ( _data.hasOwnProperty( "atk" ))
				return int( _data[ "atk" ]);
			return 1;
		}

		public function get getDefense() : int
		{
			if ( _data.hasOwnProperty( "defense" ))
				return int( _data[ "defense" ]);
			return -1;
		}

		public function get getList() : Array
		{
			if ( _data.hasOwnProperty( "list" ))
				return _data[ "list" ] as Array;
			return [];
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
