package newview.equip
{

	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;

	import datas.RolesID;
	import datas.TeamInfoData;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	import global.Global;

	import newview.SpriteBase;
	import newview.ui.ConstType;
	import newview.utils.TweenMaxUtils;

	import ui.equip.ResourceEquipView;

	import utils.FunctionUtils;
	import utils.Numeric;


	/**
	 * 说明：EquipView
	 * @author Victor
	 * 2012-11-16
	 */

	public class EquipView extends SpriteBase
	{
		private const HEAD_START_X : Number = 26;
		private const HEAD_START_Y : Number = 72;
		private const HEAD_DISTANCE_X : Number = 137;

//		private const SKILL_START_X : Number = 473.35;
//		private const SKILL_START_Y : Number = 214.75;
//		private const SKILL_DISTANCE_Y : Number = 116.4;
		private const SKILL_START_X : Number = 50; //41.5;
		private const SKILL_START_Y : Number = 198; //194.65;
		private const SKILL_DISTANCE_X : Number = 133; //142.4;

		private const SKILL_INFO_START_X : Number = 592;
		private const SKILL_INFO_START_Y : Number = 57;
		private const SKILL_INFO_DISTANCE_Y : Number = 102;


		private var equipView : ResourceEquipView;
		private var roleShowContainer : Sprite;
		private var headContainer : Sprite;
		private var weaponContainer : Sprite;
		private var infoContainer : Sprite;
		private var infoContainerMask : Shape;
		private var equipShowInfo : EquipShowArea;
		private var levelSprite : Sprite;

		private var headItemSelected : EquipRoleItem;
		private var weaponItemSelected : EquipWeaponItem;
		private var infoListItemSeleted : EquipListItem;

		private var infoContainerDragRect : Rectangle = new Rectangle();

		private var _data : Object;
		private var _isMouseMoved : Boolean = false;

		public function EquipView()
		{
			super();

			createTestData();
			createRoleHeadListLayout();
		}

		override protected function createResource() : void
		{
			equipView = new ResourceEquipView();
			addChild( equipView );

			roleShowContainer = equipView.roleContainer;
			weaponContainer = new Sprite();
			headContainer = new Sprite();
			infoContainer = new Sprite();

			infoContainerMask = new Shape();
			infoContainerMask.graphics.beginFill( 0 );
			infoContainerMask.graphics.drawRect( SKILL_INFO_START_X - 5, SKILL_INFO_START_Y - 5, 422, SKILL_INFO_DISTANCE_Y * 5 + 40 );
			infoContainerMask.graphics.endFill();

			addChild( infoContainer );
			addChild( infoContainerMask );
			addChild( weaponContainer );
			addChild( headContainer );

			infoContainer.mask = infoContainerMask;

			equipShowInfo = new EquipShowArea( roleShowContainer );
		}

		override protected function clear() : void
		{
			super.clear();
			roleShowContainer = null;
			weaponContainer = null;
			headItemSelected = null;
			weaponItemSelected = null;
			infoListItemSeleted = null;
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			headContainer.addEventListener( MouseEvent.CLICK, headContainerClickHandler );
			weaponContainer.addEventListener( MouseEvent.CLICK, weaponContainerClickHandler );
			infoContainer.addEventListener( MouseEvent.MOUSE_DOWN, infoContainerMouseHandler );
			infoContainer.addEventListener( MouseEvent.MOUSE_UP, infoContainerMouseHandler );
			equipView.btnReplace.addEventListener( MouseEvent.CLICK, btnReplaceClickHandler );
			equipView.btnCancel.addEventListener( MouseEvent.CLICK, btnCancelClickHandler );
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			headContainer.removeEventListener( MouseEvent.CLICK, headContainerClickHandler );
			weaponContainer.removeEventListener( MouseEvent.CLICK, weaponContainerClickHandler );
			infoContainer.removeEventListener( MouseEvent.MOUSE_DOWN, infoContainerMouseHandler );
			infoContainer.removeEventListener( MouseEvent.MOUSE_UP, infoContainerMouseHandler );
			equipView.btnReplace.removeEventListener( MouseEvent.CLICK, btnReplaceClickHandler );
			equipView.btnCancel.removeEventListener( MouseEvent.CLICK, btnCancelClickHandler );
		}

		protected function headContainerClickHandler( event : MouseEvent ) : void
		{
			var item : EquipRoleItem = event.target as EquipRoleItem;
			if ( item == null || headItemSelected == item )
				return;
			if ( headItemSelected )
				headItemSelected.selectedEffectNo();
			headItemSelected = item;
			headItemSelected.selectedEffectYes();
			createWeaponItemListLayout( item.getList );
//			equipShowInfo.showRole( item.getId );
//			displaySelectedItemInfoValue( item );
		}

		protected function weaponContainerClickHandler( event : MouseEvent ) : void
		{
			var item : EquipWeaponItem = event.target as EquipWeaponItem;
			if ( item == null || weaponItemSelected == item )
				return;
			if ( weaponItemSelected )
				weaponItemSelected.seletectedEffectNo();
			weaponItemSelected = item;
			weaponItemSelected.seletectedEffectYes();
			equipShowInfo.showEquip( item.getType, item.getId );
			createInfoItemListLayout( item );
			displaySelectedItemInfoValue( item );
		}

		protected function infoContainerMouseHandler( event : MouseEvent ) : void
		{
			var eventType : String = event.type;
			if ( eventType == MouseEvent.MOUSE_DOWN )
			{
				_isMouseMoved = false;
				Global.stage.addEventListener( MouseEvent.MOUSE_MOVE, infoContainerMouseHandler );
				infoContainer.startDrag( false, infoContainerDragRect );
			}
			else if ( eventType == MouseEvent.MOUSE_UP )
			{
				Global.stage.removeEventListener( MouseEvent.MOUSE_MOVE, infoContainerMouseHandler );

				infoContainer.stopDrag();

				if ( _isMouseMoved )
					return;
				var item : EquipListItem = event.target as EquipListItem;
//				if ( item == null || infoListItemSeleted == item )
				if ( item == null )
					return;
				if ( item.isSelected )
				{
					item.seletectedEffectNo();
					infoListItemSeleted = null;
				}
				else
				{
					if ( infoListItemSeleted )
						infoListItemSeleted.seletectedEffectNo();
					infoListItemSeleted = item;
					infoListItemSeleted.seletectedEffectYes();
				}

				sortItemFromInfoContainer();
				if ( item.isLast )
				{
					TweenMaxUtils.to( infoContainer, 0.3, { y: infoContainerDragRect.height });
				}
			}
			else if ( eventType == MouseEvent.MOUSE_MOVE )
			{
				_isMouseMoved = true;
			}
		}

		protected function btnReplaceClickHandler( event : MouseEvent ) : void
		{
			if ( weaponItemSelected && infoListItemSeleted )
			{
				var newData1 : Object = infoListItemSeleted.data;
				var newData2 : Object = weaponItemSelected.data;
				weaponItemSelected.refresh( newData1 );
				infoListItemSeleted.refresh( newData2 );
				infoListItemSeleted.seletectedEffectNo();

				var tempData : Array = _data.weapons as Array;
				var i : int = 0;
				var leng : int = tempData.length;
				var keyVal : Object;

				for ( i = 0; i < leng; i++ )
				{
					keyVal = tempData[ i ];
					if ( keyVal.type == newData1.type && keyVal.id == newData1.id )
					{
						tempData[ i ] = newData2;
						break;
					}
				}

				if ( headItemSelected )
				{
					tempData = headItemSelected.getList;
					leng = tempData.length;
					for ( i = 0; i < leng; i++ )
					{
						keyVal = tempData[ i ];
						if ( keyVal.type == newData2.type && keyVal.id == newData2.id )
						{
							tempData[ i ] = newData1;
							break;
						}
					}
				}
				infoListItemSeleted = null;
			}
		}

		protected function btnCancelClickHandler( event : MouseEvent ) : void
		{
			if ( infoListItemSeleted )
				infoListItemSeleted.seletectedEffectNo();
		}

		private function createTestData() : void
		{
			/*
			data:
			{
				roles:编队人物
				{
					[0]:
					{
						id:人物id,
						level:等级值
						atk:攻击值
						defense:防御值
						list:当前人物装备的武器列表
						{
							[0]:
							{
								id:编号id
								type:所属类型（1=法宝 、2=武器、3=装备、4=坐骑）
								name:名称
								star:星级值
								level:等级值
								atk:攻击值
								defense:防御值
							}
						}
					}
				}
				weapons:未使用的装备
				{
					[0]:
					{
						id:编号id
						type:所属类型（1=法宝 、2=武器、3=装备、4=坐骑）
						name:名称
						star:星级值
						level:等级值
						atk:攻击值
						defense:防御值
					}
				}
			}
			*/

			_data = [];
			var myId : Array = TeamInfoData.selected;
			var useRoleId : Array = [ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 ];
			var roles : Array = [];
			var weapons : Array = [];
			var i : int = 0;
			var id : int;
			for each ( var keyVal : * in myId )
			{
				var obj : Object = {};
				obj.id = int( keyVal );
				obj.level = int( Math.random() * 90 + 10 );
				obj.atk = int( Math.random() * 15 + 15 );
				obj.defense = int( Math.random() * 5 + 5 );
				var arr1 : Array = [];
				for ( i = 1; i < 5; i++ )
				{
					arr1.push({ id: 1, name: "skill NO." + i, type: i, star: int( Math.random() * 5 + 1 ), level: int( Math.random() * 90 + 10 ), atk: int( Math.random() * 15 + 15 ), defense: int( Math.random() * 5 + 5 )});
				}
				obj.list = arr1;
				roles.push( obj );
			}

			var leng : int = 5;
			for ( i = 1; i < 5; i++ )
			{
				var len : int = ConstType[ "TYPE_" + i + "_MAX" ];
				for ( var j : int = 2; j <= len; j++ )
				{
					weapons.push({ id: j, name: "weapons NO." + j, type: i, level: int( Math.random() * 90 + 10 ), star: int( Math.random() * 5 + 1 ), atk: int( Math.random() * 15 + 15 ), defense: int( Math.random() * 5 + 5 )});
				}
			}

			_data.roles = roles;
			_data.weapons = weapons;
		}


		private function createRoleHeadListLayout() : void
		{
			var i : int = 0;
			var roles : Array = _data.roles as Array;
			for each ( var keyVal : * in roles )
			{
				var item : EquipRoleItem = new EquipRoleItem();
				item.data = keyVal;
				item.x = HEAD_START_X + HEAD_DISTANCE_X * i;
				item.y = HEAD_START_Y;
				headContainer.addChild( item );
				if ( i == 0 )
					item.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));

				i++;
			}
		}

		private function createWeaponItemListLayout( skillData : Object ) : void
		{
			if ( weaponContainer.numChildren > 0 )
				weaponContainer.removeChildren();
			var i : int = 0;
			for each ( var keyVal : * in skillData )
			{
				var item : EquipWeaponItem = new EquipWeaponItem();
				item.txtName = equipView[ "txtEquipName" + ( i + 1 )] as TextField;
				item.data = keyVal;
//				item.x = SKILL_START_X;
//				item.y = SKILL_START_Y + SKILL_DISTANCE_Y * i;
				item.x = SKILL_START_X + SKILL_DISTANCE_X * i;
				item.y = SKILL_START_Y;
				weaponContainer.addChild( item );
				if ( i == 0 )
					item.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
				i++;
			}
		}

		private function createInfoItemListLayout( item : EquipWeaponItem ) : void
		{
			infoContainer.removeChildren();
			infoContainer.graphics.clear();
			infoContainer.x = infoContainer.y = 0;

			var skillInfoData : Object = _data.weapons;
			var i : int = 0;
			var listItem : EquipListItem;
			for each ( var keyVal : * in skillInfoData )
			{
				if ( int( keyVal.type ) == item.getType )
				{
					listItem = new EquipListItem();
					listItem.data = keyVal;
					listItem.x = SKILL_INFO_START_X;
//					listItem.y = SKILL_INFO_START_Y + SKILL_INFO_DISTANCE_Y * i;
					infoContainer.addChild( listItem );
					i++;
				}
			}
			if ( infoContainer.height < 5 )
			{
				for ( i = 0; i < 3; i++ )
				{
					listItem = new EquipListItem();
					listItem.data = item.data;
					listItem.x = SKILL_INFO_START_X;
//					listItem.y = SKILL_INFO_START_Y + SKILL_INFO_DISTANCE_Y * i;
					infoContainer.addChild( listItem );
				}
			}

			sortItemFromInfoContainer();
		}

		private function sortItemFromInfoContainer() : void
		{
			var lastHeight : Number = 0;
			var numChild : int = infoContainer.numChildren;
			for ( var i : int = 0; i < numChild; i++ )
			{
				var item : EquipListItem = infoContainer.getChildAt( i ) as EquipListItem;
				var endx : Number = SKILL_INFO_START_X;
				var endy : Number = SKILL_INFO_START_Y + lastHeight;
				lastHeight += item.itemHeight + 10;
				TweenMax.killTweensOf( item );
				TweenMax.to( item, 0.3, { x: endx, y: endy, onCompleteListener: function( e : TweenEvent ) : void
				{
					TweenMax.killTweensOf( e.target.target );
				}});
				item.isLast = ( i == ( numChild - 1 ));
			}

			infoContainer.graphics.beginFill( 0, 0 );
			infoContainer.graphics.drawRect( SKILL_INFO_START_X - 5, SKILL_INFO_START_Y - 5, infoContainer.width + 10, lastHeight + 10 );
			infoContainer.graphics.endFill();

			infoContainerDragRect.x = 0;
			infoContainerDragRect.y = 0;
			infoContainerDragRect.width = 0;
			infoContainerDragRect.height = infoContainer.height > infoContainerMask.height ? infoContainerMask.height - lastHeight : 0;
		}

		private function displaySelectedItemInfoValue( item : * ) : void
		{
			const WIDTH : Number = 18.75;
			const HEIGHT : Number = 29.2;
			const START_X : Number = 55.6;
			const START_Y : Number = 652.85;

			FunctionUtils.removeChild( levelSprite );

			equipView.txtAtk.text = item.getAtk + "";
			equipView.txtDefense.text = item.getDefense + "";
			levelSprite = Numeric.getNumeric( item.getLevel + "", Numeric.NUM_LEVEL_WHITE );
			var scaley : Number = HEIGHT / levelSprite.height;
			levelSprite.scaleX = levelSprite.scaleY = scaley;
			levelSprite.x = START_X + ( WIDTH - levelSprite.width ) * 0.5;
			levelSprite.y = START_Y;
			addChild( levelSprite );
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
