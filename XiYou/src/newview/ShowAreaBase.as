package newview
{

	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	import newview.ui.ConstType;
	import newview.ui.ResourceRoles;

	import ui.weapon.ResourceWeapon_1_1;
	import ui.weapon.ResourceWeapon_2_1;
	import ui.weapon.ResourceWeapon_3_1;
	import ui.weapon.ResourceWeapon_4_1;

	import utils.BitmapUtils;


	/**
	 * 说明：ShowAreaBase
	 * @author Victor
	 * 2012-12-2
	 */

	public class ShowAreaBase
	{
		protected static var pool : Dictionary = new Dictionary();

		protected var width : Number = 537;
		protected var height : Number = 377;
		protected var startX : Number = 270;
		protected var startY : Number = 340;

		protected var container : DisplayObjectContainer;
		protected var isFristRuning : Boolean = true;


		public function ShowAreaBase( container : DisplayObjectContainer )
		{
			this.container = container;
		}

		public function showRole( roleId : int ) : void
		{
			clear();
			var sprite : Sprite = getResourceRole( roleId );
			container.addChild( sprite );
		}

		public function showEquip( equipType : int, equipId : int ) : void
		{
			clear();
			var sprite : Sprite = getResourceEquip( equipType, equipId );
			sprite.addEventListener( Event.REMOVED_FROM_STAGE, clipRemovedFromStageHandler );
			sprite.x = ( width - sprite.width ) * 0.5;
			sprite.y = ( height - sprite.height ) * 0.5;
			container.addChild( sprite );
			BitmapUtils.cacheAsBitmap( sprite );
		}

		public function clear() : void
		{
			container.removeChildren();
		}

		public function dispose() : void
		{
			clear();
			container = null;
		}

		public static function getResourceEquip( equipType : int, equipId : int ) : Sprite
		{
			var id : String = equipType + "_" + equipId;
			var poolName : String = "weapon" + id;
			var sprite : Sprite = pool[ poolName ] as Sprite;
			var cls : Class;
			if ( sprite == null )
			{
				try
				{
					cls = getDefinitionByName( ConstType.PREFIX_WEAPON_LINKAGE + id ) as Class;
					sprite = ( new cls()) as Sprite;
					pool[ poolName ] = sprite;
				}
				catch ( e : * )
				{
					throw new Error( "未能找到资源：" + ConstType.PREFIX_WEAPON_LINKAGE + id );
				}
			}
			if ( sprite && sprite.parent )
			{
				cls = getDefinitionByName( ConstType.PREFIX_WEAPON_LINKAGE + id ) as Class;
				sprite = ( new cls()) as Sprite;
			}
			sprite.scaleX = sprite.scaleY = 1;
			return sprite;
		}

		private function getResourceRole( id : int ) : Sprite
		{
			var clip : MovieClip = ResourceRoles.create( id );
			var scalex : Number = ( width / clip.width );
			var scaley : Number = ( height / clip.height );
			clip.scaleX = clip.scaleY = Math.min( scalex, scaley ) * 0.8;
			clip.x = startX;
			clip.y = startY;
			clip.addEventListener( Event.REMOVED_FROM_STAGE, clipRemovedFromStageHandler );
			if ( isFristRuning )
			{
				clip.stop();
				TweenMax.delayedCall( 1, clip.play );
				isFristRuning = false;
			}
			return clip;
		}

		protected function clipRemovedFromStageHandler( event : Event ) : void
		{
			var clip : DisplayObject = event.target as DisplayObject;
			if ( clip is MovieClip )
				MovieClip( clip ).stop();
			clip.removeEventListener( Event.REMOVED_FROM_STAGE, clipRemovedFromStageHandler );
			clip = null;
		}

		private function importResourceLinkage() : void
		{
			ui.weapon.ResourceWeapon_1_1;

			ui.weapon.ResourceWeapon_2_1;
			ui.weapon.ResourceWeapon_2_2;
			ui.weapon.ResourceWeapon_2_3;
			ui.weapon.ResourceWeapon_2_4;
			ui.weapon.ResourceWeapon_2_5;
			ui.weapon.ResourceWeapon_2_6;
			ui.weapon.ResourceWeapon_2_7;
			ui.weapon.ResourceWeapon_2_8;
			ui.weapon.ResourceWeapon_2_9;
			ui.weapon.ResourceWeapon_2_10;
			ui.weapon.ResourceWeapon_2_11;
			ui.weapon.ResourceWeapon_2_12;
			ui.weapon.ResourceWeapon_2_13;
			ui.weapon.ResourceWeapon_2_14;
			ui.weapon.ResourceWeapon_2_15;
			ui.weapon.ResourceWeapon_2_16;

			ui.weapon.ResourceWeapon_3_1;
			ui.weapon.ResourceWeapon_3_2;
			ui.weapon.ResourceWeapon_3_3;
			ui.weapon.ResourceWeapon_3_4;
			ui.weapon.ResourceWeapon_3_5;
			ui.weapon.ResourceWeapon_3_6;
			ui.weapon.ResourceWeapon_3_7;
			ui.weapon.ResourceWeapon_3_8;
			ui.weapon.ResourceWeapon_3_9;
			ui.weapon.ResourceWeapon_3_10;
			ui.weapon.ResourceWeapon_3_11;

			ui.weapon.ResourceWeapon_4_1;
			ui.weapon.ResourceWeapon_4_2;
			ui.weapon.ResourceWeapon_4_3;
			ui.weapon.ResourceWeapon_4_4;
		}

		public function set showRect( value : Rectangle ) : void
		{
			if ( value )
			{
				width = value.width;
				height = value.height;
				startX = value.x;
				startY = value.y;
			}
		}



	}

}
