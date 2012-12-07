package newview.adventure
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import global.Global;
	
	import utils.BitmapUtils;
	import utils.FunctionUtils;
	import utils.Numeric;


	/**
	 * 说明：EctypalLevelItem
	 * @author Victor
	 * 2012-10-1
	 */

	public class AdventureLevelItem
	{
		private static var pool : Vector.<AdventureLevelItem>;

		private const LAB_FRAME : String = "lab_";

		private var _target : MovieClip;
		private var _data : Object;

		public function AdventureLevelItem()
		{
		}

		public static function create() : AdventureLevelItem
		{
			if ( pool == null )
				pool = new Vector.<AdventureLevelItem>();
			if ( pool.length > 0 )
				return pool.pop();
			return new AdventureLevelItem();
		}

		public static function dispose() : void
		{
			if ( Global.isUsePool == false )
				return;
			if ( pool )
			{
				while ( pool.length > 0 )
					pool.pop();
				pool = null;
			}
		}

		public function initialization() : void
		{
			if ( _target )
			{
				if ( _target.hasOwnProperty( "iconLockMc" ))
					_target[ "iconLockMc" ].visible = isLocked;
				if ( _target.hasOwnProperty( "iconPassMc" ))
					_target[ "iconPassMc" ].visible = isPassed;
				if ( _target.hasOwnProperty( "numContainer" ))
				{
					var numContainer : Sprite = _target[ "numContainer" ] as Sprite;
					var numSprite : Sprite = Numeric.getNumeric( getLevel + "" );
					var rect1 : Rectangle = _target.getBounds( _target );
					var rect2 : Rectangle = numSprite.getBounds( numSprite );
					numContainer.removeChildren();
					numSprite.x = ( _target.width - numSprite.width ) * 0.5 + rect1.x - rect2.x;
					numSprite.y = ( _target.height - numSprite.height ) * 0.5 + rect1.y - rect2.y;
					numContainer.addChild( numSprite );

					numSprite = null;
					numContainer = null;
					rect1 = null;
				}

				if ( isBoss )
					_target.gotoAndStop( AdventureType.LABEL_FRAME_4 );
				else
					_target.gotoAndStop( isLocked ? AdventureType.LABEL_FRAME_1 : AdventureType[ "LABEL_FRAME_" + getStatus ]);

				_target.mouseChildren = false;
				_target[ "levelItem" ] = this;
				BitmapUtils.cacheAsBitmap(_target);

				addEvents();
			}
		}

		private function addEvents() : void
		{
			if ( _target ) 
				_target.addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );  
		}

		private function removeEvents() : void
		{
			if ( _target ) 
				_target.removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );  
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvents();

			_target = null;
			_data = null;

			if ( pool )
				pool.push( this );
		}


		/**
		 * 表示解锁和过关状态
		 */
		private function get getStatus() : int
		{
			return int( data.status );
		}

		/**
		 * 关卡等级
		 */
		public function get getLevel() : int
		{
			return int( data.level );
		}

		/**
		 * 当前关卡的类型
		 */
		public function get getType() : int
		{
			return int( data.type );
		}

		/**
		 * 关卡名称
		 */
		public function get getName() : String
		{
			return String( data.name );
		}

		/**
		 * 指向设定的队伍id值
		 */
		public function get teamId() : String
		{
			return String( data.team );
		}

		/**
		 * 关卡描述
		 */
		public function get getDes() : String
		{
			return String( data.des );
		}

		/**
		 * 未解锁的
		 */
		public function get isLocked() : Boolean
		{
			return ( getStatus == AdventureType.STATUS_1 );
		}

		/**
		 * 是否是解锁的（未打过和已打过两状态）
		 */
		public function get isUnlocked() : Boolean
		{
			return ( getStatus == AdventureType.STATUS_2 ) || ( getStatus == AdventureType.STATUS_3 );
		}

		/**
		 * 胜利关卡
		 */
		public function get isPassed() : Boolean
		{
			return ( getStatus == AdventureType.STATUS_3 );
		}

		/**
		 * 该关卡为打boss关
		 */
		public function get isBoss() : Boolean
		{
			return ( getType == AdventureType.TYPE_2 );
		}

		public function get target() : MovieClip
		{
			return _target;
		}

		public function set target( value : MovieClip ) : void
		{
			_target = value;
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
