package view.team_into
{

	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import global.Global;
	
	import ui.resource.ResourceAllRoleHeadPicture;
	import ui.resource.ResourceEmptyContainer;
	
	import utils.FunctionUtils;


	/**
	 * 说明：RoleItem
	 * @author Victor
	 * 2012-9-30
	 */

	public class TeamInfoRoleItem extends Sprite
	{
		private static var pool : Vector.<TeamInfoRoleItem>;

		private const PREFIX_FRAME_LAB : String = "lab_";

		private var _target : Sprite;
		private var _data : Object;
		private var _mark : int = 0;
		private var _vo : TeamInfoItemVO;

		public function TeamInfoRoleItem()
		{
			this.mouseChildren = false;

			initialization();
		}

		public static function create() : TeamInfoRoleItem
		{
			if ( pool == null )
			{
				pool = new Vector.<TeamInfoRoleItem>();
			}
			if ( pool.length > 0 )
			{
				var item : TeamInfoRoleItem = pool.pop();
				item.initialization();
				return item;
			}
			return new TeamInfoRoleItem();
		}

		public static function dispose() : void
		{
			if ( Global.isUsePool == true )
				return;
			while ( pool.length > 0 )
			{
				FunctionUtils.removeChild( pool.pop());
			}
			pool = null;
		}

		/**
		 * 该方法不必手动调用
		 */
		public function initialization() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );

			if ( _target )
			{
				if ( isEmpty == false )
				{
					var role : MovieClip = _target.hasOwnProperty( "role" ) ? _target[ "role" ] as MovieClip : _target as MovieClip;
					if ( role )
					{
						FunctionUtils.movieClipHasFrameLabel( role, PREFIX_FRAME_LAB + id, true, false );
					}
					role = null;
				}
				if ( _target.parent == null )
				{
					this.addChild( _target );
				}
			}
			this.x = vo.atParentX;
			this.y = vo.atParentY;
			this.scaleX = vo.endScaleX;
			this.scaleY = vo.endScaleY;
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );

			pool.push( this );

			clear();
		}

		private function clear() : void
		{
			TweenMax.killTweensOf( this );
			FunctionUtils.removeChild( _target );
			_target = null;
			_data = null;
			_vo = null;
		}

		private function tweenOnComplete() : void
		{
			TweenMax.killTweensOf( this );
			this.parent.mouseChildren = true;
		}

		override public function startDrag( lockCenter : Boolean = false, bounds : Rectangle = null ) : void
		{
			setThisIndexAtParent();
			this.mouseEnabled = false;
			super.startDrag( lockCenter, bounds );
		}

		override public function stopDrag() : void
		{
			this.mouseEnabled = true;
			super.stopDrag();
		}

		/**
		 * 移动本身到指定的位置和缩放的尺寸，调用前请确保以下几个属性值存在：atParentX, atParentY, endScaleX, endScaleY
		 */
		public function moveToParentXY() : void
		{
			setThisIndexAtParent();
			this.parent.mouseChildren = false;
			TweenMax.to( this, 0.5, { x: vo.atParentX, y: vo.atParentY, scaleX: vo.endScaleX, scaleY: vo.endScaleY, onComplete: tweenOnComplete });
		}

		private function setThisIndexAtParent() : void
		{
			if ( this.parent )
			{
				var parentNumChildren : int = this.parent.numChildren - 1;
				this.parent.setChildIndex( this, parentNumChildren );
			}
		}


		//////////////// getters/setters ////////////////////////////////////////////////////////

		public function get id() : int
		{
			return int( data.id );
		}

		/**
		 * 是否是一个空缺位置
		 */
		public function get isEmpty() : Boolean
		{
			return data.hasOwnProperty( "id" ) == false;
		}

		/**
		 * 是否是在已被编队队列中，是则true，否则false
		 */
		public function get isSelected() : Boolean
		{
			return vo.type == TeamInfoType.SELECTED;
		}

		/**
		 * 传给该对象的数据
		 */
		public function get data() : Object
		{
			return _data;
		}

		public function set data( value : Object ) : void
		{
			_data = value;
			FunctionUtils.removeChild( _target );
			_target = isEmpty ? new ResourceEmptyContainer() : new ResourceAllRoleHeadPicture();
		}

		/**
		 * 标识对象唯一的标记
		 */
		public function get mark() : int
		{
			return _mark;
		}

		/**
		 * @private
		 */
		public function set mark( value : int ) : void
		{
			_mark = value;
		}

		public function get vo() : TeamInfoItemVO
		{
			return _vo;
		}

		public function set vo( value : TeamInfoItemVO ) : void
		{
			_vo = value;
		}


	}

}
