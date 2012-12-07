package newview.intensify
{

	import datas.RolesID;
	import datas.TeamInfoData;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import global.Global;
	
	import newview.SpriteBase;
	import newview.ui.ConstType;
	
	import ui.intensify.ResourceIntensifyView;
	
	import utils.FunctionUtils;
	import utils.Numeric;


	/**
	 * 说明：IntensifyView
	 * @author Victor
	 * 2012-11-16
	 */

	public class IntensifyView extends SpriteBase
	{
		private const HEAD_START_X : Number = 26;
		private const HEAD_START_Y : Number = 72;
		private const HEAD_DISTANCE_X : Number = 137;

		private const SKILL_START_X : Number = 50; //41.5;
		private const SKILL_START_Y : Number = 198; //194.65;
		private const SKILL_DISTANCE_X : Number = 133; //142.4;

		private const INFO_START_X : Number = 592;
		private const INFO_START_Y : Number = 57;
		private const INFO_DISTANCE_Y : Number = 102;

		private var intensifyView : ResourceIntensifyView;
		private var intensifyShowArea : IntensifyShowArea;
		private var headItemSelected : IntensifyRoleItem;
		private var weaponItemSelected : IntensifyWeaponItem;
		private var headContainer : Sprite;
		private var weaponContainer : Sprite;
		private var infoContainer : Sprite;
		private var levelSprite : Sprite;
		private var infoContainerMask : Shape;
		private var showContainer : Sprite;
		private var currentShowAreaTyoe : int = -1;
		private var infoContainerDragRect : Rectangle = new Rectangle();

		private var _isMouseMoved : Boolean = false;


		private var _data : Object;


		public function IntensifyView()
		{
			super();

			createTestData();
			createRoleHeadListLayout();
		}

		override protected function createResource() : void
		{
			intensifyView = new ResourceIntensifyView();
			addChild( intensifyView );

			showContainer = intensifyView.showContainer;
			headContainer = new Sprite();
			weaponContainer = new Sprite();
			infoContainer = new Sprite();

			infoContainerMask = new Shape();
			infoContainerMask.graphics.beginFill( 0 );
			infoContainerMask.graphics.drawRect( INFO_START_X - 5, INFO_START_Y - 5, 422, INFO_DISTANCE_Y * 5 + 40 );
			infoContainerMask.graphics.endFill();

			addChild( infoContainer );
			addChild( infoContainerMask );
			addChild( headContainer );
			addChild( weaponContainer );

			infoContainer.mask = infoContainerMask;

			intensifyView.iconStar.stop();
			intensifyView.iconStar.visible = false;

			intensifyShowArea = new IntensifyShowArea( showContainer );
		}

		override protected function clear() : void
		{
			super.clear();

			intensifyShowArea.dispose();

			headContainer = null;
			weaponContainer = null;
			infoContainer = null;
			showContainer = null;
			intensifyShowArea = null;
			headItemSelected = null;
			weaponItemSelected = null;
			_data = null;
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			headContainer.addEventListener( MouseEvent.CLICK, headContainerClickHandler );
			weaponContainer.addEventListener( MouseEvent.CLICK, weaponContainerClickHandler );
			infoContainer.addEventListener( MouseEvent.MOUSE_DOWN, infoContainerMouseHandler );
			infoContainer.addEventListener( MouseEvent.MOUSE_UP, infoContainerMouseHandler );
			intensifyView.btnClear.addEventListener( MouseEvent.CLICK, btnClearClickHandler );
			intensifyView.btnUse.addEventListener( MouseEvent.CLICK, btnUseClickHandler );
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			headContainer.removeEventListener( MouseEvent.CLICK, headContainerClickHandler );
			weaponContainer.removeEventListener( MouseEvent.CLICK, weaponContainerClickHandler );
			infoContainer.removeEventListener( MouseEvent.MOUSE_DOWN, infoContainerMouseHandler );
			infoContainer.removeEventListener( MouseEvent.MOUSE_UP, infoContainerMouseHandler );
			intensifyView.btnClear.addEventListener( MouseEvent.CLICK, btnClearClickHandler );
			intensifyView.btnUse.addEventListener( MouseEvent.CLICK, btnUseClickHandler );
		}

		protected function headContainerClickHandler( event : MouseEvent ) : void
		{
			var item : IntensifyRoleItem = event.target as IntensifyRoleItem;
			if ( item == null || ( currentShowAreaTyoe == IntensifyType.SHOW_ROLE && item == headItemSelected ))
				return;
			if ( headItemSelected )
				headItemSelected.selectedEffectNo();
			headItemSelected = item;
			headItemSelected.selectedEffectYes();
			createWeaponItemListLayout( item.getList );
//			intensifyShowArea.showRole( item.getId );
			intensifyView.iconStar.visible = false;
			displaySelectedItemInfoValue( item );

			if ( currentShowAreaTyoe == IntensifyType.SHOW_ROLE )
				return;
//			createInfoItemListlayout( _data.peoples, IntensifyType.INFO_LIST_ROLE );
			currentShowAreaTyoe = IntensifyType.SHOW_ROLE;
		}

		protected function weaponContainerClickHandler( event : MouseEvent ) : void
		{
			var item : IntensifyWeaponItem = event.target as IntensifyWeaponItem;
			if ( item == null || ( currentShowAreaTyoe == IntensifyType.SHOW_EQUIP && item == weaponItemSelected ))
				return;
			if ( weaponItemSelected )
				weaponItemSelected.seletectedEffectNo();
			weaponItemSelected = item;
			weaponItemSelected.seletectedEffectYes();
			intensifyShowArea.showEquip( item.getType, item.getId );
			intensifyView.iconStar.gotoAndStop( item.getStar );
			intensifyView.iconStar.visible = true;
			displaySelectedItemInfoValue( item );

			if ( currentShowAreaTyoe == IntensifyType.SHOW_EQUIP )
				return;
			createInfoItemListlayout( _data.weapons, IntensifyType.INFO_LIST_EQUIP );
			currentShowAreaTyoe = IntensifyType.SHOW_EQUIP;
		}

		private function infoContainerMouseHandler( event : MouseEvent ) : void
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
				var item : IntensifyListItemBase = event.target as IntensifyListItemBase;
				if ( item )
				{
					if ( item.isSelected )
						item.selectedEffectNo();
					else
						item.selectedEffectYes();
				}

			}
			else if ( eventType == MouseEvent.MOUSE_MOVE )
			{
				_isMouseMoved = true;
			}
		}

		protected function btnUseClickHandler( event : MouseEvent ) : void
		{

		}

		protected function btnClearClickHandler( event : MouseEvent ) : void
		{
			for each ( var item : IntensifyListItemBase in getListItemHasSelected )
			{
				if ( item )
					item.selectedEffectNo();
			}
		}

		private function createTestData() : void
		{
			/*
			 data:
			{
				roles:已编队的人物
				{
					[0]:
					{
						id:人物id,
						level:等级值
						atk:攻击值
						defense:防御值
						list:
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
				weapons:空闲武器装备
				{
					[0]:
					{
						id:编号id
						star:星级值
						level:等级值
						type:所属类型（1=法宝 、2=武器、3=装备、4=坐骑）
						name:名称
						atk:攻击值
						defense:防御值
					}
				}
				peoples:空闲人物资源
				{
					[0]:
					{
						id:编号id
						name:名称
						level:等级值
						star:星级值
					}
				}
			}

			*/
			_data = [];
			var myId : Array = TeamInfoData.selected;
			var useRoleId : Array = [ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 ];
			var roles : Array = [];
			var weapons : Array = [];
			var peoples : Array = [];
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
					id = int( Math.random() * ConstType[ "TYPE_" + i + "_MAX" ]) + 1;
					arr1.push({ id: id, name: "skill NO." + i, type: i, star: int( Math.random() * 5 + 1 ), level: int( Math.random() * 90 + 10 ), atk: int( Math.random() * 15 + 15 ), defense: int( Math.random() * 5 + 5 )});
				}
				obj.list = arr1;
				roles.push( obj );
			}

			var leng : int = 7;
			for ( i = 0; i < leng; i++ )
			{
				var type : int = int( Math.random() * 4 + 1 );
				id = int( Math.random() * ConstType[ "TYPE_" + type + "_MAX" ]) + 1;
				weapons.push({ id: id, name: "weapons NO." + i, type: type, level: int( Math.random() * 90 + 10 ), star: int( Math.random() * 5 + 1 ), atk: int( Math.random() * 15 + 15 ), defense: int( Math.random() * 5 + 5 )});
			}

			leng = 5;
			for ( i = 0; i < leng; i++ )
			{
				id = int( useRoleId[ int( useRoleId.length * Math.random())]);
				peoples.push({ id: id, name: RolesID.getName( id ), level: int( Math.random() * 90 + 10 ), star: int( Math.random() * 5 + 1 )});
			}

			_data.roles = roles;
			_data.weapons = weapons;
			_data.peoples = peoples;
		}

		private function createRoleHeadListLayout() : void
		{
			var i : int = 0;
			var array : Array = _data.roles as Array;
			for each ( var keyVal : * in array )
			{
				var item : IntensifyRoleItem = new IntensifyRoleItem();
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
				var item : IntensifyWeaponItem = new IntensifyWeaponItem();
				item.txtName = intensifyView[ "txtSkillName" + i ] as TextField;
				item.data = keyVal;
				item.x = SKILL_START_X + SKILL_DISTANCE_X * i;
				item.y = SKILL_START_Y;
				weaponContainer.addChild( item );
				if (i==0)
					item.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				i++;
			}
		}

		private function createInfoItemListlayout( infoData : Object, type : int ) : void
		{
			infoContainer.removeChildren();
			infoContainer.graphics.clear();
			infoContainer.x = infoContainer.y = 0;

			var i : int = 0;
			for each ( var keyVal : * in infoData )
			{
				var item : IntensifyListItemBase = type == IntensifyType.INFO_LIST_EQUIP ? new IntensifyListItem1() : new IntensifyListItem2();
				item.data = keyVal;
				item.x = INFO_START_X;
				item.y = INFO_START_Y + INFO_DISTANCE_Y * i;
				infoContainer.addChild( item );
				i++;
			}

			infoContainer.graphics.beginFill( 0, 0 );
			infoContainer.graphics.drawRect( INFO_START_X - 5, INFO_START_Y - 5, infoContainer.width + 10, infoContainer.height + 10 );
			infoContainer.graphics.endFill();

			infoContainerDragRect.x = 0;
			infoContainerDragRect.y = 0;
			infoContainerDragRect.width = 0;
			infoContainerDragRect.height = infoContainer.height > infoContainerMask.height ? infoContainerMask.height - infoContainer.height : 0;
		}

		private function displaySelectedItemInfoValue( item : * ) : void
		{
			const WIDTH : Number = 18.75;
			const HEIGHT : Number = 29.2;
			const START_X : Number = 55.5;
			const START_Y : Number = 339.4;

			FunctionUtils.removeChild( levelSprite );

			intensifyView.txtAtk.text = item.getAtk + "";
			intensifyView.txtDefense.text = item.getDefense + "";
			levelSprite = Numeric.getNumeric( item.getLevel + "", Numeric.NUM_LEVEL_WHITE );
			var scaley : Number = HEIGHT / levelSprite.height;
			levelSprite.scaleX = levelSprite.scaleY = scaley;
			levelSprite.x = START_X + ( WIDTH - levelSprite.width ) * 0.5;
			levelSprite.y = START_Y;
			addChild( levelSprite );
		}

		private function get getListItemHasSelected() : Vector.<IntensifyListItemBase>
		{
			var vec : Vector.<IntensifyListItemBase> = new Vector.<IntensifyListItemBase>();
			var leng : int = infoContainer.numChildren;
			for ( var i : int = 0; i < leng; i++ )
			{
				var item : IntensifyListItemBase = infoContainer.getChildAt( i ) as IntensifyListItemBase;
				if ( item )
					vec.push( item );
			}
			return vec;
		}


	}

}
