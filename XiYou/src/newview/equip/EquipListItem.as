package newview.equip
{

	import com.greensock.TweenMax;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	import newview.ShowAreaBase;
	import newview.utils.TweenMaxUtils;

	import ui.equip.ResourceEquipListItem;
	import ui.weapon.ResourceIconBackground;
	import ui.weapon.ResourceWeaponIcons;


	/**
	 * 说明：EquipListItem
	 * @author Victor
	 * 2012-11-19
	 */

	public class EquipListItem extends Sprite
	{
		private const WIDTH : Number = 66;

		private var item : ResourceEquipListItem;

		protected var iconBg : MovieClip;
		protected var iconChild : MovieClip;


		private var _data : Object;
		private var _isSelected : Boolean = false;
		private var _isLast : Boolean = false;
		private var equipImage : DisplayObject;

		public var itemHeight : Number = 0;

		public function EquipListItem()
		{
			item = new ResourceEquipListItem();
			addChild( item );

			iconBg = new ResourceIconBackground();
			iconChild = new ResourceWeaponIcons();
			item.container.addChild( iconBg );
			item.container.addChild( iconChild );
			item.container.width = item.container.height = WIDTH;

			this.mouseChildren = false;
			seletectedEffectNo();
			addEvents();
		}

		public function seletectedEffectYes() : void
		{
			if ( item )
				item.gotoAndStop( 2 );

			_isSelected = true;
			if ( equipImage == null )
			{
				equipImage = ShowAreaBase.getResourceEquip( getType, getId );
				var scale : Number = ( equipImage.width / item.width );
				equipImage.scaleX = equipImage.scaleY = scale;
			}

			itemHeight = item.height + equipImage.height;
			addChildAt( equipImage, 0 );
			equipImage.y = 0;
			TweenMaxUtils.to( equipImage, 0.3, { y: item.height, alpha: 1 });
		}

		public function seletectedEffectNo() : void
		{
			if ( item )
				item.gotoAndStop( 1 );
			_isSelected = false;
			itemHeight = item.height;
			if ( equipImage == null )
				return;
			TweenMaxUtils.to( equipImage, 0.3, { y: 0, alpha: 0, onComplete: function() : void
			{
				if ( equipImage && equipImage.parent )
					equipImage.parent.removeChild( equipImage );
			}});
		}

		public function refresh( newData : Object = null ) : void
		{
			if ( newData )
				_data = newData;
			if ( item )
			{
				item.iconStar.gotoAndStop( getStar );
				item.txtLevel.text = getLevel + "";

				if ( iconBg )
					iconBg.gotoAndStop( getStar );
				if ( iconChild )
					iconChild.gotoAndStop( "lab_" + getResID );
			}
		}

		private function addEvents() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		private function removeEvens() : void
		{
			addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
		}

		protected function addedToStageHandler( event : Event ) : void
		{
			refresh();
		}

		protected function removedFromStageHandler( event : Event ) : void
		{
			removeEvens();
			if ( equipImage )
			{
//				if ( equipImage.bitmapData )
//				{
//					equipImage.bitmapData.dispose();
//					equipImage.bitmapData = null;
//				}
				if ( equipImage.parent )
					equipImage.parent.removeChild( equipImage );
				equipImage = null;
			}
		}

		public function get getResID() : String
		{
			return getType + "_" + getId;
		}

		public function get getStar() : int
		{
			if ( _data.hasOwnProperty( "star" ))
				return int( _data[ "star" ]);
			return 1;
		}

		public function get getLevel() : int
		{
			if ( _data.hasOwnProperty( "level" ))
				return int( _data[ "level" ]);
			return 1;
		}

		public function get getId() : int
		{
			if ( _data.hasOwnProperty( "id" ))
				return int( _data[ "id" ]);
			return 1;
		}

		public function get getType() : int
		{
			if ( _data.hasOwnProperty( "type" ))
				return int( _data[ "type" ]);
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

		public function get isSelected() : Boolean
		{
			return _isSelected;
		}

		public function get isLast():Boolean
		{
			return _isLast;
		}

		public function set isLast(value:Boolean):void
		{
			_isLast = value;
		}



	}

}
