package newview.fight
{

	import datas.TeamInfoData;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import global.Global;
	
	import manager.ui.UIMainManager;
	import manager.ui.UINaviManager;
	
	import newview.SpriteBase;
	import newview.navi.MainNaviView;
	import newview.pvp.PvpView;
	
	import ui.fight.ResourceFightView;
	import ui.team.ResourceTeamBGround;
	
	import utils.ArrayUtils;
	import utils.BitmapUtils;
	
	import view.arena.battle.ArenaBattleScene;


	/**
	 * 说明：FightView
	 * @author Victor
	 * 2012-11-14
	 */

	public class FightView extends SpriteBase
	{
		private const FRAME_SELECTED : int = 2; // 选项卡选中的状态标签号
		private const FRMAE_NORMAL : int = 1; // 选项卡未选中的状态标签

		private const START_X : Number = 17.45;
		private const START_Y : Number = 19.15;
		private const DISTANCE_Y : Number = 219.15;
		private const MASK_HEIGHT : Number = 455;


		private var fightBGround : Sprite;
		private var fightView : ResourceFightView;
		private var itemContainer : Sprite;
		private var btnOne : MovieClip;
		private var btnEnemys : MovieClip;
		private var btnFriends : MovieClip;
		private var tabBtnVector : Vector.<MovieClip> = new Vector.<MovieClip>();
		private var dragRect : Rectangle = new Rectangle();
		private var containerStartX : Number;
		private var containerStartY : Number;

		private var _data : Object;

		public function FightView()
		{
			super();

			createTestData();
		}

		override protected function createResource() : void
		{
			fightBGround = new ResourceTeamBGround();
			BitmapUtils.cacheAsBitmap( fightBGround );
			addChild( fightBGround );

			fightView = new ResourceFightView();
			addChild( fightView );

			itemContainer = fightView.itemContainer;
			btnOne = fightView.btnOne;
			btnEnemys = fightView.btnEnemys;
			btnFriends = fightView.btnFriends;
			tabBtnVector.push( btnOne, btnEnemys, btnFriends );
			containerStartX = itemContainer.x;
			containerStartY = itemContainer.y;

			setTabBtnEnbled();
		}

		override protected function clear() : void
		{
			super.clear();
			FightItem.disposePool();
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			itemContainer.addEventListener( MouseEvent.MOUSE_DOWN, itemContainerMouseDownHandler );
			Global.stage.addEventListener( MouseEvent.MOUSE_UP, itemContainerMouseDownHandler );
			Global.stage.addEventListener( FightEvent.FIGHT_CLICK_ITEM, fightClickItemHandler );
		}

		override protected function removeEvents() : void
		{
			super.removeEvents();
			itemContainer.removeEventListener( MouseEvent.MOUSE_DOWN, itemContainerMouseDownHandler );
			Global.stage.removeEventListener( MouseEvent.MOUSE_UP, itemContainerMouseDownHandler );
			Global.stage.removeEventListener( FightEvent.FIGHT_CLICK_ITEM, fightClickItemHandler );
		}

		protected function fightClickItemHandler( event : FightEvent ) : void
		{
			// start to battle
			if ( event.item )
			{
				TeamInfoData.enemyerTeams = event.item.getTeamID;
//				MainNaviView.instance.openUIMainPage(ArenaBattleScene);
				MainNaviView.instance.openUIMainPage(PvpView);
//				MainNaviView.instance.hide();
//				UIMainManager.addChild(new ArenaBattleScene(event.item.getTeamID));
			}
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );
			btnFriends.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ));
		}

		protected function itemContainerMouseDownHandler( event : MouseEvent ) : void
		{
			var type : String = event.type;
			if ( type == MouseEvent.MOUSE_DOWN )
			{
				if ( itemContainer.height > MASK_HEIGHT )
					itemContainer.startDrag( false, dragRect );
			}
			else if ( type == MouseEvent.MOUSE_UP )
			{
				itemContainer.stopDrag();
			}
		}

		override protected function mouseDownHandler( event : MouseEvent ) : void
		{
			super.mouseDownHandler( event );
			var target : MovieClip = event.target as MovieClip;
			if ( target == btnOne )
			{
				setTabBtnEnbled( target );
				initCreateItemList( FightType.TAB_ONE );
			}
			else if ( target == btnEnemys )
			{
				setTabBtnEnbled( target );
				initCreateItemList( FightType.TAB_ENEMYS );
			}
			else if ( target == btnFriends )
			{
				setTabBtnEnbled( target );
				initCreateItemList( FightType.TAB_FRIENDS );
			}
		}

		private function createTestData() : void
		{
			_data = [];
			var arr0 : Array = [ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 ];
			var leng : int = int( Math.random() * 6 + 3 );
			var i : int = 0;
			var j : int = 0;
			var arr1 : Array = [];
			var arr2 : Array = [];
			var arr3 : Array = [];
			var team : Array = [];
			var len : int;
			for ( i = 0; i < leng; i++ )
			{
				ArrayUtils.randomSortOn( arr0 );
				team = [];
				len = int( Math.random() * 3 + 2 );
				for ( j = 0; j < len; j++ )
					team.push({ id: arr0[ j ], level: int( Math.random() * 90 + 10 )});
				arr1.push({ level: int( Math.random() * 90 + 10 ), name: "单挑" + i, team: team });
			}
			leng = int( Math.random() * 6 + 3 );
			for ( i = 0; i < leng; i++ )
			{
				ArrayUtils.randomSortOn( arr0 );
				team = [];
				len = int( Math.random() * 3 + 2 );
				for ( j = 0; j < len; j++ )
					team.push({ id: arr0[ j ], level: int( Math.random() * 90 + 10 )});
				arr2.push({ level: int( Math.random() * 90 + 10 ), name: "宿敌" + i, team: team });
			}
			leng = int( Math.random() * 6 + 3 );
			for ( i = 0; i < leng; i++ )
			{
				ArrayUtils.randomSortOn( arr0 );
				team = [];
				len = int( Math.random() * 3 + 2 );
				for ( j = 0; j < len; j++ )
					team.push({ id: arr0[ j ], level: int( Math.random() * 90 + 10 )});
				arr3.push({ level: int( Math.random() * 90 + 10 ), name: "好友" + i, team: team });
			}
			_data[ FightType.TAB_ONE ] = arr1;
			_data[ FightType.TAB_ENEMYS ] = arr2;
			_data[ FightType.TAB_FRIENDS ] = arr3;
		}

		private function initCreateItemList( tabDataType : String ) : void
		{
			var tabData : Array = _data[ tabDataType ] as Array;
			itemContainer.graphics.clear();
			itemContainer.removeChildren();
			itemContainer.x = containerStartX;
			itemContainer.y = containerStartY;
			var leng : int = tabData.length;
			for ( var i : int = 0; i < leng; i++ )
			{
				var item : FightItem = FightItem.create( tabData[ i ]);
				item.x = START_X;
				item.y = START_Y + DISTANCE_Y * i;
				itemContainer.addChild( item );
			}
			var cw : Number = itemContainer.width + START_X * 2;
			var ch : Number = itemContainer.height + START_Y * 2;
			itemContainer.graphics.beginFill( 0, 0.0 );
			itemContainer.graphics.drawRect( 0, 0, cw, ch );
			itemContainer.graphics.endFill();

			dragRect.x = containerStartX;
			dragRect.y = MASK_HEIGHT - ch + containerStartY;
			dragRect.height = Math.abs( ch - MASK_HEIGHT );
		}

		private function setTabBtnEnbled( target : MovieClip = null ) : void
		{
			for each ( var btn : MovieClip in tabBtnVector )
			{
				if ( btn )
				{
					var boo : Boolean = ( btn != target );
					btn.mouseChildren = false;
					btn.mouseEnabled = boo;
					btn.gotoAndStop( boo ? FRMAE_NORMAL : FRAME_SELECTED );
				}
			}
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
