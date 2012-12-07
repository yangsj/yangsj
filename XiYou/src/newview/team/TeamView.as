package newview.team
{

	import datas.TeamInfoData;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import global.Global;

	import newview.SpriteBase;

	import ui.team.ResourceTeamBGround;
	import ui.team.ResourceTeamInfoMc;
	import ui.team.ResourceTeamView;

	import utils.BitmapUtils;
	import utils.FunctionUtils;
	import utils.Numeric;


	/**
	 * 说明：TeamView
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamView extends SpriteBase
	{
		private const SELECTED_MAX_NUM : int = 4;
		private const PAGE_MAX_NUM : int = 32;
		private const listPointArr : Array = [[ 561.7, 123.85 ], [ 654.8, 96.65 ], [ 747.9, 70.25 ], [ 841, 43.05 ], [ 539.8, 205.15 ], [ 632.9, 177.95 ], [ 726, 151.55 ], [ 819.1, 124.35 ], [ 914.45, 95.9 ], [ 608.6, 259.5 ], [ 701.7, 232.3 ], [ 794.8, 205.9 ], [ 887.9, 178.7 ], [ 581.35, 341.55 ], [ 676.7, 315.2 ], [ 769.8, 288.8 ], [ 862.9, 261.6 ], [ 560.9, 424.5 ], [ 654, 397.3 ], [ 747.1, 370.9 ], [ 840.2, 343.7 ], [ 539, 505.8 ], [ 632.1, 478.6 ], [ 725.2, 452.2 ], [ 818.3, 425 ], [ 607.8, 560.15 ], [ 700.9, 532.95 ], [ 794, 506.55 ], [ 887.1, 479.35 ], [ 675.9, 615.85 ], [ 769, 589.45 ], [ 862.1, 562.25 ]];

		private var teamBg : Sprite;
		private var teamView : ResourceTeamView;
		private var btnPutoutTeam : SimpleButton;
		private var btnPutinTeam : SimpleButton;
		private var selectedTarget : TeamItemBase;
		private var selectedItemArray : Vector.<TeamItemBase>;
		private var waitingItemArray : Vector.<TeamItemBase>;
		private var data : Object;

		private var roleContainer : Sprite;
		private var levelSprite : Sprite;
		private var dragRect : Rectangle;
		private var isMouseMove : Boolean = false;
		private var teamShowRole : TeamShowAreaForSelect;
		private var infoMc : ResourceTeamInfoMc;

		public function TeamView()
		{
			super();
		}

		override protected function createResource() : void
		{
			selectedItemArray = new Vector.<TeamItemBase>();
			waitingItemArray = new Vector.<TeamItemBase>();

			teamBg = new ResourceTeamBGround();
			teamView = new ResourceTeamView();
			teamShowRole = new TeamShowAreaForSelect();
			teamView.showContainer.addChild( teamShowRole );

			roleContainer = new Sprite();
			teamView.addChild( roleContainer );

			addChild( teamBg );
			addChild( teamView );

			infoMc = teamView.infoMc;
			btnPutoutTeam = infoMc.btnPutoutTeam;
			btnPutinTeam = infoMc.btnPutinTeam;

			btnPutoutTeam.visible = false;
			btnPutinTeam.visible = false;
			infoMc.visible = false;

			BitmapUtils.cacheAsBitmap( teamBg );
		}

		override protected function removeEvents() : void
		{
			removeEventListener( MouseEvent.MOUSE_MOVE, mouseDownHandler );
			removeEventListener( MouseEvent.MOUSE_UP, mouseDownHandler );
			roleContainer.removeEventListener( MouseEvent.MOUSE_DOWN, roleContainermouseHandler );
			roleContainer.removeEventListener( MouseEvent.MOUSE_UP, roleContainermouseHandler );
			super.removeEvents();
		}

		override protected function addedToStageHandler( event : Event ) : void
		{
			super.addedToStageHandler( event );
			// test data
			createTestData();
			createLayoutForSelectedList();
			createLayoutForWaitingList();
		}

		override protected function removedFromStageHandler( event : Event ) : void
		{
			TeamInfoData.selected = selectedListItemIdArray;

			super.removedFromStageHandler( event );
		}

		override protected function mouseDownHandler( event : MouseEvent ) : void
		{
			super.mouseDownHandler( event );
			var target : TeamItemBase = event.target as TeamItemBase;
			if ( dragRect )
			{
				var type : String = event.type;
				if ( type == MouseEvent.MOUSE_MOVE )
					isMouseMove = true;
				else if ( type == MouseEvent.MOUSE_UP )
				{
					if ( isMouseMove == false )
						clickAndDownItem( target );
					isMouseMove = false;
				}
			}
			else
				clickAndDownItem( target );
		}

		private function clickAndDownItem( target : TeamItemBase ) : void
		{
			if ( target )
			{
				var isSameRole : Boolean = false;
				if ( selectedTarget )
				{
					if ( selectedTarget == target )
						return;
					selectedTarget.selectedItemNo();
					isSameRole = ( selectedTarget.getId == target.getId );
				}
				selectedTarget = target;
				selectedTarget.selectedItemYes();

				btnPutoutTeam.visible = selectedTarget.isReady; //( selectedTarget.type == TeamType.TYPE_SELECTED );
				btnPutinTeam.visible = ( selectedTarget.type == TeamType.TYPE_WAITING && ( hasEmptyPointAtSelctedList != -1 ));

				if ( isSameRole )
					return;

				teamShowRole.show( selectedTarget );
				showCurrentClickSelectedItemInfo( selectedTarget );
			}
			else
			{
				switch ( clickTargetName )
				{
					case "btnPutoutTeam":
						putoutFromTeamSelectedToWaiting( selectedTarget );
						break;
					case "btnPutinTeam":
						putinFromTeamWaitingToSelected( selectedTarget );
						break;
				}
			}
		}

		private function createTestData() : void
		{
			data = {};
			var arr1 : Array = TeamInfoData.selected;
			var arr2 : Array = [ 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 ];
			var selected : Array = [];
			var waiting : Array = [];

			/*
			item data:
			{
				id: 人物id,
				level: 人物等级值,
				status: 人物是否启用（1=启用，0=未启用）,
				atk: 人物的攻击力值,
				defense:人物的防御值
			}
			*/

			var val : *;
			for each ( val in arr1 )
			{
				var obj1 : Object = { id: val, level: int( Math.random() * 100 + 1 ), status: 1, atk: int( Math.random() * 20 + 20 ), defense: int( Math.random() * 5 + 5 )};
				selected.push( obj1 );
			}

			for each ( val in arr2 )
			{
				var status : int = waiting.length < 16 ? 1 : 0;
				var obj2 : Object = { id: val, level: int( Math.random() * 100 + 1 ), status: status, atk: int( Math.random() * 20 + 20 ), defense: int( Math.random() * 5 + 5 )};
				waiting.push( obj2 );
			}
			data.waiting = waiting;
			data.selected = selected;
		}

		private function createLayoutForSelectedList() : void
		{
			var selected : Array = data.selected as Array;
			var leng : int = selected ? selected.length : 0;
			for ( var index : int = 0; index < SELECTED_MAX_NUM; index++ )
			{
				createItemForSelectedList( index, selected[ index ]);
			}
		}

		private function createItemForSelectedList( index : int, obj : Object ) : void
		{
			const START_X : Number = 49.25;
			const START_Y : Number = 64.40;
			const DISTANCE_Y : Number = 146.8;

			var item : TeamSelectedItem;
			if ( obj )
			{
				item = TeamSelectedItem.create();
				item.x = START_X;
				item.y = START_Y + DISTANCE_Y * index;
				item.data = obj;
				teamView.addChild( item );
			}
			selectedItemArray[ index ] = item;
		}

		private function createLayoutForWaitingList() : void
		{
			const LENG : int = listPointArr.length;
			var waiting : Array = data.waiting;
			var len : int = waiting.length;
			var selectedIDArray : Array = selectedListItemIdArray;
			for ( var i : int = 0; i < len; i++ )
			{
				var point : Array = listPointArr[ i % LENG ] as Array;
				var item : TeamWaitItem = TeamWaitItem.create();
				item.x = point[ 0 ];
				item.y = point[ 1 ] + 300 * int( i / LENG );
				item.data = waiting[ i ];
				roleContainer.addChild( item );
				waitingItemArray.push( item );
				if ( selectedIDArray.indexOf( item.getId ) != -1 && item.getStatus == TeamType.STATUS_YES )
					item.pushItemFromWaitListToSelectedList();
			}

			var rectHeight : Number = Global.stageHeight - ( roleContainer.getBounds( roleContainer ).y * 3 );
			if ( i > PAGE_MAX_NUM )
			{
				roleContainer.addEventListener( MouseEvent.MOUSE_DOWN, roleContainermouseHandler );
				roleContainer.addEventListener( MouseEvent.MOUSE_UP, roleContainermouseHandler );
				addEventListener( MouseEvent.MOUSE_MOVE, mouseDownHandler );
				addEventListener( MouseEvent.MOUSE_UP, mouseDownHandler );

				dragRect = new Rectangle( 0, 0, 0, rectHeight - roleContainer.height );
			}
		}

		protected function roleContainermouseHandler( event : MouseEvent ) : void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
				roleContainer.startDrag( false, dragRect );
			else
				roleContainer.stopDrag();
		}

		private function putoutFromTeamSelectedToWaiting( item : TeamItemBase ) : void
		{
			var itm : TeamItemBase;

			if ( item.type == TeamType.TYPE_WAITING )
				itm = item;
			else
				itm = getItemFromWaitingList( item );

			if ( itm )
				itm.pushItemFromSelectedListToWaitList();

			delItemFromSelectedList( item );

			actionAfterOperateRole();
		}

		private function putinFromTeamWaitingToSelected( item : TeamItemBase ) : void
		{
			var index : int = hasEmptyPointAtSelctedList;
			if ( index > -1 )
			{
				var itm : TeamItemBase = getItemFromWaitingList( item );
				if ( itm )
					itm.pushItemFromWaitListToSelectedList();

				createItemForSelectedList( index, item.data );
			}

			actionAfterOperateRole();
		}

		private function actionAfterOperateRole() : void
		{
			selectedTarget.selectedItemNo();
			btnPutinTeam.visible = false;
			btnPutoutTeam.visible = false;
			teamShowRole.clear();
			showCurrentClickSelectedItemInfo( null );
			selectedTarget = null;
		}

		private function showCurrentClickSelectedItemInfo( item : TeamItemBase ) : void
		{
			if ( item )
			{
				infoMc.txtAtk.text = item.getAtk + "";
				infoMc.txtName.text = item.getName + "";
				infoMc.txtDefense.text = item.getDefense + "";
				infoMc.visible = true;

				const WIDTH : Number = 18.75;
				const HEIGHT : Number = 29.2;
				const START_X : Number = 37.3;
				const START_Y : Number = 198.6;

				FunctionUtils.removeChild( levelSprite );

				levelSprite = Numeric.getNumeric( item.getLevel + "", Numeric.NUM_LEVEL_WHITE );
				var scaley : Number = HEIGHT / levelSprite.height;
				levelSprite.scaleX = levelSprite.scaleY = scaley;
				levelSprite.x = START_X + ( WIDTH - levelSprite.width ) * 0.5;
				levelSprite.y = START_Y;
				infoMc.addChild( levelSprite );
			}
			else
			{
				infoMc.visible = false;
			}
		}

		private function getItemFromWaitingList( item : TeamItemBase ) : TeamItemBase
		{
			for each ( var itm : TeamItemBase in waitingItemArray )
			{
				if ( itm && itm.getId == item.getId )
					return itm;
			}
			return null;
		}

		private function delItemFromSelectedList( item : TeamItemBase ) : void
		{
			for ( var i : int = 0; i < SELECTED_MAX_NUM; i++ )
			{
				var itm : TeamItemBase = selectedItemArray[ i ] as TeamItemBase;
				if ( itm && itm.getId == item.getId )
				{
					if ( itm.parent )
						itm.parent.removeChild( itm );
					selectedItemArray[ i ] = null;
					return;
				}
			}
		}

		/**
		 * 返回 -1 时表示没有空位置
		 */
		private function get hasEmptyPointAtSelctedList() : int
		{
			for ( var i : int = 0; i < SELECTED_MAX_NUM; i++ )
			{
				if ( selectedItemArray.length <= i || selectedItemArray[ i ] == null || selectedItemArray[ i ] == undefined )
					return i;
			}
			return -1;
		}

		private function get selectedListItemIdArray() : Array
		{
			var array : Array = [];
			for each ( var item : TeamItemBase in selectedItemArray )
			{
				if ( item )
					array.push( item.getId );
			}
			return array;
		}


	}

}
