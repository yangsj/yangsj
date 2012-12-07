package newview.team
{

	import datas.RolesID;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import newview.ui.HeadPhotoBase;

	import utils.BitmapUtils;


	/**
	 * 说明：TeamItemBase
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamItemBase extends Sprite
	{
		private var _data : Object = {};
		private var _isReady : Boolean = false;

		protected var headPhoto : HeadPhotoBase;

		public function TeamItemBase()
		{
			this.mouseChildren = false;
		}

		public function initialization() : void
		{
			addEvents();
			selectedItemNo();
		}

		/**
		 * 选中
		 */
		public function selectedItemYes() : void
		{
			if ( headPhoto )
				headPhoto.selectedEffectYes();
		}

		/**
		 * 未选中
		 */
		public function selectedItemNo() : void
		{
			if ( headPhoto )
				headPhoto.selectedEffectNo();
		}

		/**
		 * 从待队列表中添加到编队列表
		 */
		public function pushItemFromWaitListToSelectedList() : void
		{
		}

		/**
		 * 从编队列表移除到待队列表中
		 */
		public function pushItemFromSelectedListToWaitList() : void
		{
		}

		protected function clear() : void
		{
		}

		protected function addEvents() : void
		{
//			addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function removeEvents() : void
		{
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function mouseDownHandler( event : MouseEvent ) : void
		{
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

			if ( headPhoto )
			{
				headPhoto.setId( getId );
				if ( type == TeamType.TYPE_SELECTED )
					headPhoto.setLevel( getLevel );
			}
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();
			clear();
		}

		/////////////////////////////////////////////////////////

		public function get type() : int
		{
			return 0;
		}

		/**
		 * 人物id
		 */
		public function get getId() : int
		{
			if ( _data.hasOwnProperty( TeamType.DATA_ID ))
				return int( _data[ TeamType.DATA_ID ]);
			return -1;
		}

		/**
		 * 人物名字
		 */
		public function get getName() : String
		{
			if ( getId != -1 )
				return RolesID.getName( getId );
			return "";
		}

		/**
		 * 人物等级
		 */
		public function get getLevel() : int
		{
			if ( _data.hasOwnProperty( TeamType.DATA_LEVEL ))
				return int( _data[ TeamType.DATA_LEVEL ]);
			return 1;
		}

		/**
		 * 标明该人物是否启用（1=启用 / 0=未启用）
		 */
		public function get getStatus() : int
		{
			if ( _data.hasOwnProperty( TeamType.DATA_STATUS ))
				return int( _data[ TeamType.DATA_STATUS ]);
			return 1;
		}

		/**
		 * 攻击力值
		 */
		public function get getAtk() : int
		{
			if ( _data.hasOwnProperty( TeamType.DATA_ATK ))
				return int( _data[ TeamType.DATA_ATK ]);
			return 0;
		}

		/**
		 * 防御力值
		 */
		public function get getDefense() : int
		{
			if ( _data.hasOwnProperty( TeamType.DATA_DEFENSE ))
				return int( _data[ TeamType.DATA_DEFENSE ]);
			return 0;
		}


		public function get data() : Object
		{
			return _data;
		}

		public function set data( value : Object ) : void
		{
			_data = value;
		}

		public function get isReady() : Boolean
		{
			return _isReady;
		}

		public function set isReady( value : Boolean ) : void
		{
			_isReady = value;
		}


	}

}
