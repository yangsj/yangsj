package view.team_into
{

	import com.greensock.TweenMax;
	import com.greensock.events.TweenEvent;
	
	import datas.RolesID;
	import datas.TeamInfoData;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import global.DeviceType;
	import global.Global;
	
	import manager.ui.UIMainManager;
	
	import ui.resource.ResourceAllRoleHeadPicture;
	import ui.resource.ResourceEmptyContainer;
	import ui.resource.team_info.ResourceTeamIntoView;
	
	import utils.ArrayUtils;
	import utils.FunctionUtils;
	
	import view.ViewBase;
	import view.home.MainView;


	/**
	 * 说明：TeamInfoView  队伍编成
	 * @author Victor
	 * 2012-9-30
	 */

	public class TeamInfoView extends ViewBase
	{
		/** 标识每条数据的唯一性，这是一个自定义字段 */
		private const DEFINE_UNIQUE_IDENTIFIER : String = "unique_identifier";

		/** 已编队的队员最大值 */
		private const MAX_SELECTED_NUM : int = 8;

		/** 正等待编队的单页显示最大值 */
		private var MAX_NUM_PER_PAGE : int = ( Global.isDifferenceSwf && Global.deviceType == DeviceType.ANDROID ) ? 12 : 10;


		/** 资源 */
		private var teamInfoView : ResourceTeamIntoView;

		/** 角色头像显示容器 */
		private var roleContainer : Sprite;

		/** 被拖动的角色对象 */
		private var dragTarget : TeamInfoRoleItem;

		/** 已编队的人物记录 */
		private var selectdItemArray : Vector.<TeamInfoRoleItem>;

		/** 等待编队的人物记录 */
		private var waitingItemArray : Vector.<TeamInfoRoleItem>;

		private var selectedData : Array;
		private var waitingData : Array;

		private var pageNO : int = 1;
		private var totalPages : int = 1;
		private var totalItemWaitNum : int = 0;

		public function TeamInfoView()
		{
			super();

			createResource();

			// test data
			setData();

			// 应该在正确获取到数据后执行
			layout();
		}

		private function createResource() : void
		{
			teamInfoView = new ResourceTeamIntoView();
			this.addChild( teamInfoView );

			roleContainer = new Sprite();
			teamInfoView.addChild( roleContainer );

			adjustSize( teamInfoView );

			selectdItemArray = new Vector.<TeamInfoRoleItem>();
			waitingItemArray = new Vector.<TeamInfoRoleItem>();

			selectedData = [];
			waitingData = [];
		}

		private function setData() : void
		{
			var t_select : Array = TeamInfoData.selected;
			var t_wait : Array = TeamInfoData.waiting;
			if ( t_select == null && t_wait == null )
			{
				var tempArr : Array = ArrayUtils.createUniqueCopy( RolesID.canUseForUserRoleId );
				ArrayUtils.randomSortOn( tempArr );

				var index : int = tempArr.length > 4 ? int( Math.random() * 4 + 1 ) : int( Math.random() * tempArr.length + 1 );

				t_select = tempArr.slice( 0, index );
				t_wait = tempArr.slice( index );
			}

			var length1 : int = t_select.length;
			var length2 : int = t_wait.length;
			var i : int;
			var id : int;
			for ( i = 0; i < length1; i++ )
			{
				id = int( t_select[ i ]);
				selectedData.push({ id: id, name: RolesID.getName( id ), index: i + 1 });
			}
			for ( i = 0; i < length2; i++ )
			{
				id = int( t_wait[ i ]);
				waitingData.push({ id: t_wait[ i ], name: RolesID.getName( id ), index: i + 1 });
			}

		/****** 该函数当前代码为开发调试数据  2012-10-31
		 * 实际应为：
		 * 判断网络情况发送请求获取数据。
		 * 若网络不能发送请求，则取本地已存储的数据使用。
		 * 定义数据结构：
		 * 				{
		 * 					select:
		 * 						{
		 * 							id:人物id,
		 * 							name:人物名称,
		 * 							... ...
		 * 						},
		 * 					wait:
		 * 						{
		 * 							id:人物id,
		 * 							name:人物名称,
		 * 							... ...
		 * 						}
		 * 				}
		 *
		 * 在本地存储数据分别存取，可见：datas.TeamInfoData 类中的定义。
		 ******/

		}

		private function layout() : void
		{
			dividePageForWaittingList();
			layoutSelected();
			layoutWaiting();
		}
		
		/**
		 * 将待编队数据进行分页
		 */
		private function dividePageForWaittingList() : void
		{
			totalItemWaitNum = Math.ceil( waitingData.length / MAX_NUM_PER_PAGE ) * MAX_NUM_PER_PAGE;
			totalPages = Math.ceil( totalItemWaitNum / MAX_NUM_PER_PAGE );
			for ( var i : int = 0; i < totalItemWaitNum; i++ )
			{
				var object : Object = waitingData[ i ];
				var define : int = i + MAX_SELECTED_NUM;
				if ( object )
				{
					object[ DEFINE_UNIQUE_IDENTIFIER ] = define;
				}
				else
				{
					object = {};
					object[ DEFINE_UNIQUE_IDENTIFIER ] = define;
					waitingData.push( object );
				}
			}
		}

		private function layoutSelected() : void
		{
			var selectedLength : int = selectedData.length;

			var i : int = 0;
			var itemPointDis : DisplayObject;
			var tempData : Object;
			for ( i = 0; i < MAX_SELECTED_NUM; i++ )
			{
				tempData = ( i < selectedLength ) ? selectedData[ i ] : {};
				tempData[ DEFINE_UNIQUE_IDENTIFIER ] = i;
				createInitItem( TeamInfoType.SELECTED, i, tempData );
				tempData = null;
			}
		}

		private function layoutWaiting() : void
		{
			var tempData : Object;
			var i : int = ( pageNO - 1 ) * MAX_NUM_PER_PAGE;

			while ( waitingItemArray.length > 0 )
			{
				FunctionUtils.removeChild( waitingItemArray.pop());
			}

			for ( i; i < MAX_NUM_PER_PAGE; i++ )
			{
				tempData = ( i < totalItemWaitNum ) ? waitingData[ i ] : {};
				createInitItem( TeamInfoType.WAITING, i + MAX_SELECTED_NUM, tempData );
				tempData = null;
			}
		}

		/**
		 *
		 * @param type 属于编队类型
		 * @param mark 标记当前显示的对象唯一的值
		 * @param data data
		 */
		private function createInitItem( type : int, mark : int, data : Object ) : void
		{
			var itemPointDis : DisplayObject = teamInfoView[ "role" + mark ] as DisplayObject;
			var item : TeamInfoRoleItem = TeamInfoRoleItem.create();
			item.vo = new TeamInfoItemVO( type, itemPointDis.x, itemPointDis.y, itemPointDis.scaleX, itemPointDis.scaleY );
			item.mark = mark;
			item.data = data;
			roleContainer.addChild( item );

			( type == TeamInfoType.SELECTED ) ? selectdItemArray.push( item ) : waitingItemArray.push( item );

			itemPointDis = null;
			item = null;
		}

		override protected function addEvents() : void
		{
			super.addEvents();
			roleContainer.addEventListener( MouseEvent.MOUSE_DOWN, containerMouseHandler );
			stage.addEventListener( MouseEvent.MOUSE_UP, containerMouseHandler );
		}

		override protected function removeEvents() : void
		{
			super.addEvents();
			roleContainer.removeEventListener( MouseEvent.MOUSE_DOWN, containerMouseHandler );
			stage.removeEventListener( MouseEvent.MOUSE_UP, containerMouseHandler );
		}

		override protected function removedFromStageHandler( event : Event ) : void
		{
			super.removedFromStageHandler( event );

			if ( roleContainer )
			{
				if ( roleContainer.numChildren > 0 )
				{
					roleContainer.removeChildren();
				}
			}
			ArrayUtils.removeAll( selectdItemArray );
			ArrayUtils.removeAll( waitingItemArray );

			FunctionUtils.removeChild( teamInfoView );
			FunctionUtils.removeChild( roleContainer );

			teamInfoView = null;
			dragTarget = null;
			selectdItemArray = null;
			waitingItemArray = null;
			roleContainer = null;

			//清楚对象池
			TeamInfoRoleItem.dispose();
		}

		protected function containerMouseHandler( event : MouseEvent ) : void
		{
			var target : DisplayObject = event.target as DisplayObject;
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				if ( target is TeamInfoRoleItem )
				{
					dragTarget = target as TeamInfoRoleItem;
					( dragTarget.isEmpty == false ) ? dragTarget.startDrag() : dragTarget = null;
				}
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				if ( dragTarget )
				{
					dragTarget.stopDrag();
					if ( target is TeamInfoRoleItem )
					{
						mouseUpTargetIsItem( target as TeamInfoRoleItem );
					}
					dragTarget.moveToParentXY();
				}
				dragTarget = null;
			}
		}

		private function mouseUpTargetIsItem( tempTarget : TeamInfoRoleItem ) : void
		{
			var isNotSameObj : Boolean = tempTarget != dragTarget; 
			var hasDragTarget : Boolean = dragTarget.isEmpty == false;
			var hasItemTarget : Boolean = tempTarget.isEmpty == false;
			var isWaitingList : Boolean = dragTarget.isSelected == false;
			var canDragFromSelectedList : Boolean = ( hasSelectedToDragOut || tempTarget.isSelected == dragTarget.isSelected );
			if ( isNotSameObj && (( hasDragTarget && isWaitingList ) || canDragFromSelectedList || ( hasDragTarget && hasItemTarget )))
			{
				var targetVO : TeamInfoItemVO = dragTarget.vo;
				var temperVO : TeamInfoItemVO = tempTarget.vo;

				if ( dragTarget.isSelected ) // 拖动的对象是已编队的
				{
					if ( dragTarget.isSelected != tempTarget.isSelected ) // 从已编队中拖到带编队中
					{
						operationTheArrayFromTargetValue(dragTarget, tempTarget);
					}
					else // 交换已编队中的两个人物位置
					{
						replaceArrayElement( selectdItemArray, dragTarget, tempTarget, true );
					}
				}
				else // 拖动的对象是等待编队的
				{
					if ( dragTarget.isSelected != tempTarget.isSelected ) // 从带编队中拖动到已编队中
					{
						operationTheArrayFromTargetValue(tempTarget, dragTarget);
					}
					else // 交换带编队中两个人物位置
					{
						replaceWaitTotalData( dragTarget.data, tempTarget.data, true );
					}
				}

				// 交换两个人物位置数据
				dragTarget.vo = temperVO;
				tempTarget.vo = targetVO;

				tempTarget.moveToParentXY();
			}
		}
		
		private function operationTheArrayFromTargetValue(target1:TeamInfoRoleItem, target2:TeamInfoRoleItem):void
		{
			replaceArrayElement( selectdItemArray, target1, target2 );
			replaceArrayElement( waitingItemArray, target2, target1 );
			replaceWaitTotalData( target2.data, target1.data, false );
		}

		override protected function onClick( event : MouseEvent ) : void
		{
			super.onClick( event );
			if ( targetName == "'btnPrev" )
			{
				prevPage();
			}
			else if ( targetName == "btnNext" )
			{
				nextPage();
			}
			else if ( targetName == "btnReturn" )
			{
				storeDataToLocalAndService();

				// 退出当前界面
				exit();
			}
		}

		private function prevPage() : void
		{
			if ( pageNO > 1 )
			{
				pageNO -= 1;
				layoutWaiting();
			}
			//
			setBtnPageEnabled();
		}

		private function nextPage() : void
		{
			if ( pageNO < totalPages )
			{
				pageNO += 1;
				layoutWaiting();
			}
			//
			setBtnPageEnabled();
		}

		private function setBtnPageEnabled() : void
		{
			teamInfoView.btnPrev.mouseEnabled = isFristPage;
			teamInfoView.btnNext.mouseEnabled = isLastPage;
		}

		/**
		 * 数据存储
		 */
		private function storeDataToLocalAndService() : void
		{
			var selected : Array = [];
			var wait : Array = [];
			var item : TeamInfoRoleItem;
			for each ( item in selectdItemArray )
			{
				if ( item && item.isEmpty == false )
				{
					selected.push( item.id );
				}
			}
			for each ( var keyValue : Object in waitingData )
			{
				if ( keyValue && keyValue.hasOwnProperty( "id" ))
				{
					wait.push( keyValue[ "id" ]);
				}
			}

			// 储存队伍编队信息(本地数据存储)
			TeamInfoData.selected = selected;
			TeamInfoData.waiting = wait;

			// 将数据存储到服务器



			selected = null;
			wait = null;
		}

		/**
		 * 将制定数组
		 * @param array
		 * @param item1 被替换的对象
		 * @param item2 替换的对象
		 *
		 */
		private function replaceArrayElement( array : Vector.<TeamInfoRoleItem>, item1 : TeamInfoRoleItem, item2 : TeamInfoRoleItem, isSwap : Boolean = false ) : void
		{
			var length : int = array.length;
			var index1 : int = -1;
			var index2 : int = -1;
			for ( var i : int = 0; i < length; i++ )
			{
				var item : TeamInfoRoleItem = array[ i ] as TeamInfoRoleItem;
				if ( item )
				{
					if ( isSwap )
					{
						if ( item.mark == item1.mark )
						{
							index1 = i;
						}
						else if ( item.mark == item2.mark )
						{
							index2 = i;
						}
						if ( index1 != -1 && index2 != -1 )
						{
							array[ index1 ] = item2;
							array[ index2 ] = item1;
							return;
						}
					}
					else
					{
						if ( item.mark == item1.mark )
						{
							array[ i ] = item2;
							return;
						}
					}
				}
			}
		}

		private function get hasSelectedToDragOut() : Boolean
		{
			var i : int = 0;
			for each ( var item : TeamInfoRoleItem in selectdItemArray )
			{
				if ( item && item.isSelected && item.isEmpty == false )
				{
					i++;
					if ( i >= 2 )
					{
						return true;
					}
				}
			}
			return false;
		}

		/**
		 *
		 * @param object1
		 * @param object2
		 * @param isSwap true=object1和object2都是waitArrayTotalData中的元素且将其交换位置， false=object1是waitArrayTotalData中元素，object2不是，需用object2替换object1
		 *
		 */
		private function replaceWaitTotalData( object1 : Object, object2 : Object, isSwap : Boolean ) : void
		{
			var length : int = waitingData.length;
			var i : int = 0;
			var index1 : int = -1;
			var index2 : int = -1;
			var object : Object;
			for ( i = 0; i < length; i++ )
			{
				object = waitingData[ i ];
				if ( object )
				{
					if ( object[ DEFINE_UNIQUE_IDENTIFIER ] == object1[ DEFINE_UNIQUE_IDENTIFIER ])
					{
						index1 = i;
					}
					else if ( object[ DEFINE_UNIQUE_IDENTIFIER ] == object2[ DEFINE_UNIQUE_IDENTIFIER ])
					{
						index2 = i;
					}
				}
				if ( isSwap == false )
				{
					if ( index1 != -1 )
					{
						object2[ DEFINE_UNIQUE_IDENTIFIER ] = index1;
						waitingData[ index1 ] = object2;
						return;
					}
				}
				else
				{
					if ( index1 != -1 && index2 != -1 )
					{
						object1[ DEFINE_UNIQUE_IDENTIFIER ] = index2;
						object2[ DEFINE_UNIQUE_IDENTIFIER ] = index1;
						waitingData[ index1 ] = object2;
						waitingData[ index2 ] = object1;
						return;
					}
				}
			}
		}


		private function get isFristPage() : Boolean
		{
			return pageNO <= 1;
		}

		private function get isLastPage() : Boolean
		{
			return pageNO >= totalPages;
		}


	}

}
