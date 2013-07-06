package victor.view.scenes.game.logic
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import victor.GameStage;
	import victor.components.Button;
	import victor.core.interfaces.IItem;
	import victor.data.LevelVo;
	import victor.utils.ArrayUtil;
	import victor.view.EffectPlayCenter;
	import victor.view.events.GameEvent;
	import victor.view.res.Item;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class GameLogicComp extends Sprite
	{
		private const cols:int = 6;
		private const rows:int = 9;
		private const COMB_TIME_UNIT:int = 2000;
		private const COMB_REWAR_SCORE_UNIT:int = 5;

		// item 列表显示容器
		private var _listContainer:Sprite;
		// 路径线显示容器
		private var _lineContainer:Sprite;
		private var drawPathLine:DrawPathLine;

		private var markList:Vector.<int>;
		private var listAry:Vector.<Vector.<IItem>>;
		private var markAry:Vector.<int>;
		private var seekGroups:Vector.<Vector.<IItem>>;
		private var startItem:IItem;
		private var endItem:IItem;
		private var dispelNumber:int = 0;
		private var levelVo:LevelVo;
		private var lastClickTime:Number = 0;
		private var combNumber:int = 0;

		private var isOver:Boolean = false;

		public var btnRefresh:Button;

		public function GameLogicComp()
		{
			mouseEnabled = false;
			intiData();
		}

		private function intiData():void
		{
			var leng:int = cols * rows;
			var i:int = 0;
			var j:int = 0;

			listAry = new Vector.<Vector.<IItem>>( rows );
			for ( i = 0; i < rows; i++ )
			{
				var vec1:Vector.<IItem> = new Vector.<IItem>( cols );
				for ( j = 0; j < cols; j++ )
				{
					vec1[ j ] = new Item();
				}
				listAry[ i ] = vec1;
			}

			_listContainer = new Sprite();
			_lineContainer = new Sprite();
			addChild( _listContainer );
			addChild( _lineContainer );
			_listContainer.y = 130;
			GameStage.adjustXY( _listContainer );
			_listContainer.x = ( GameStage.stageWidth - (( listAry[ 0 ][ 0 ].itemWidth + 5 ) * cols )) >> 1;

			btnRefresh = new Button( " 刷 新 ", btnRefreshHandler );
			GameStage.adjustScaleXY( btnRefresh );
			btnRefresh.x = GameStage.stageWidth >> 1;
			btnRefresh.y = GameStage.stageHeight - btnRefresh.height - 10;
			addChild( btnRefresh );
			btnRefresh.mouseEnabled = false;


			drawPathLine ||= new DrawPathLine();
			_lineContainer.addChild( drawPathLine );
		}

		private function initMarkData( limit:int ):void
		{
			var i:int;
			var leng:int = cols * rows;
			markList ||= new <int>[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40 ];
			ArrayUtil.randomSort( markList );
			var ary:Vector.<int> = markList.slice( 0, limit );
			markAry = new Vector.<int>( leng );
			for ( i = 0; i < leng; i += 2 )
			{
				markAry[ i ] = markAry[ i + 1 ] = ary[ int( Math.random() * limit )];
			}
		}

		private function btnRefreshHandler():void
		{
			refresh();
		}

		public function initialize():void
		{
			btnRefresh.mouseEnabled = false;
			mouseChildren = true;
			_listContainer.removeChildren();
		}

		public function startAndReset( levelVo:LevelVo ):void
		{
			isOver = false;
			btnRefresh.mouseEnabled = false;
			dispelNumber = 0;
			lastClickTime = 0;
			combNumber = 0;
			this.levelVo = levelVo;
			initMarkData( levelVo.picNum );
			ArrayUtil.randomSort( markAry );

			for ( var i:int = 0; i < rows; i++ )
			{
				var groupAry:Array = [];
				var tweenGroup:TimelineMax = new TimelineMax();
				tweenGroup.addEventListener( TweenEvent.COMPLETE, complete );
				tweenGroup.stop();
				for ( var j:int = 0; j < cols; j++ )
				{
					var item:IItem = listAry[ i ][ j ];
					item.cols = j;
					item.rows = i;
					item.mark = markAry[ i * cols + j ];
					item.initialize();
					_listContainer.addChild( item as DisplayObject );

					var endx:Number = item.x;
					var endy:Number = item.y;
					groupAry.push( TweenMax.from( item, 0.5, { x: endx, y: endy - 1000, ease: Back.easeOut }));
				}
				tweenGroup.appendMultiple( groupAry, 1, TweenAlign.START, 0.1 );
				tweenGroup.play();
			}
			_listContainer.mouseEnabled = false;
			_listContainer.addEventListener( MouseEvent.CLICK, clickHandler );

			function complete( event:TweenEvent ):void
			{
				var target:TimelineMax = event.target as TimelineMax;
				if ( target )
				{
					target.removeEventListener( TweenEvent.COMPLETE, complete );
				}

				if ( btnRefresh )
					btnRefresh.mouseEnabled = true;
			}
		}

		private function refresh():void
		{
			listAry.sort( abc );
			function abc( a:*, b:* ):Number
			{
				return int( Math.random() * 3 ) - 1;
			}
			for ( var i:int = 0; i < rows; i++ )
			{
				for ( var j:int = 0; j < cols; j++ )
				{
					var item:IItem = listAry[ i ][ j ];
					item.cols = j;
					item.rows = i;
					item.refresh();
				}
			}
		}

		protected function clickHandler( event:MouseEvent ):void
		{
			var target:IItem = event.target as IItem;
			if ( target )
			{
				if ( startItem == null )
				{
					startItem = target;
					startItem.selected = true;
				}
				else
				{
					endItem = target;
					if ( endItem == startItem )
					{
						startItem.selected = false;
						startItem = null;
					}
					else if ( startItem.mark != target.mark )
					{
						startItem.selected = false;
						startItem = target;
						startItem.selected = true;
					}
					else
					{
						endItem.selected = true;

						seek();
					}
				}
			}
		}

		private function createTempItem( cols:int, rows:int ):IItem
		{
			var item:IItem = new Item();
			item.cols = cols;
			item.rows = rows;
			item.initialize();
			item.visible = false;
			_listContainer.addChild( item as DisplayObject );
			return item;
		}

		private function sortVec( a:Vector.<IItem>, b:Vector.<IItem> ):Number
		{
			if ( a.length > b.length )
				return -1;
			else if ( a.length < b.length )
				return 1;
			return 0;
		}

		///////////// seek

		private function seek():void
		{
			// set init vars
			seekGroups = new Vector.<Vector.<IItem>>();
			s_cols = startItem.cols;
			s_rows = startItem.rows;
			e_cols = endItem.cols;
			e_rows = endItem.rows;

			// seek
			goLeft();
			goRight();
			goUp();
			goDown();

			// get short path
			if ( seekGroups.length > 0 )
			{
				seekGroups.sort( sortVec );
				var tempVec1:Vector.<IItem> = seekGroups.pop();
				var tempVec2:Vector.<Point> = new Vector.<Point>();
				for each ( var item:IItem in tempVec1 )
				{
					tempVec2.push( item.globalPoint );
					item.removeFromParent();
				}
				drawPathLine.setPoints( tempVec2 );
				startItem = null;

				dispatchEvent( new GameEvent( GameEvent.ADD_TIME, 1 ));

				dispelNumber++;

				if ( dispelNumber >= rows * cols * 0.5 )
				{
					isOver = true;
					dispatchEvent( new GameEvent( GameEvent.DISPEL_SUCCESS ));
				}
				// score
				var score:int = levelVo.score;
				if ( getTimer() - lastClickTime <= COMB_TIME_UNIT )
				{
					combNumber++;
					score += combNumber * COMB_REWAR_SCORE_UNIT;
					EffectPlayCenter.instance.playCombWords( combNumber );
				}
				else
				{
					combNumber = 0;
				}

				if ( combNumber > 0 && combNumber % 3 == 0 )
				{
					TweenMax.delayedCall(0.5, EffectPlayCenter.instance.playGoodWords);
				}

				lastClickTime = getTimer();
				trace( "连击：" + combNumber, "》》》》》增加分数：" + score );
				dispatchEvent( new GameEvent( GameEvent.ADD_SCORE, score ));

			}
			else
			{
				startItem.selected = false;
				endItem.selected = true;
				startItem = endItem;
			}
			endItem = null;
		}

//******************************** seek path functions ********************

		private var vecFirst:Vector.<IItem>; // 记录未发生拐点的节点
		private var vecSecond:Vector.<IItem>; // 记录第一次拐点后的节点
		private var vecThird:Vector.<IItem>; // 记录第二次拐点后的节点
		private var s_cols:int = 0; // 起始节点的列号
		private var s_rows:int = 0; // 起始节点的行号
		private var e_cols:int = 0; // 终止节点的列号
		private var e_rows:int = 0; // 终止节点的行号

		/**
		 * 向左查找
		 */
		private function goLeft():void
		{
			vecFirst = new Vector.<IItem>();
			vecFirst.push( startItem );
			for ( var i:int = s_cols - 1; i >= -1; i-- ) //从起始节点向左循环
			{
				if ( goLeftRightLoop( i ))
					break;
			}
		}

		/**
		 * 向右查找
		 */
		private function goRight():void
		{
			vecFirst = new Vector.<IItem>();
			vecFirst.push( startItem );
			for ( var i:int = s_cols + 1; i <= cols; i++ ) //从起始节点向右循环
			{
				if ( goLeftRightLoop( i ))
					break;
			}
		}

		/**
		 * 向上查找
		 */
		private function goUp():void
		{
			vecFirst = new Vector.<IItem>();
			vecFirst.push( startItem );
			for ( var i:int = s_rows - 1; i >= -1; i-- ) //从起始节点向上循环
			{
				if ( goUpDownLoop( i ))
					break;
			}
		}

		/**
		 * 向上查找
		 */
		private function goDown():void
		{
			vecFirst = new Vector.<IItem>();
			vecFirst.push( startItem );
			for ( var i:int = s_rows + 1; i <= rows; i++ ) //从起始节点向下循环
			{
				if ( goUpDownLoop( i ))
					break;
			}
		}

		/**
		 * 开始向左或右方向查询循环
		 * @param col 当前要查询的列号
		 * @return 若是查询到终止节点，则返回true，否则返回false
		 *
		 */
		private function goLeftRightLoop( col:int ):Boolean
		{
			if ( col == -1 || col == cols ) // 超出边界
			{
				goLeftRightAtEdge( col );
			}
			else
			{
				if ( goLeftRightCorner1( col ))
					return true;
			}
			return false;
		}

		private function goUpDownLoop( row:int ):Boolean
		{
			if ( row == -1 || row == rows ) // 超出边界
			{
				goUpDownAtEdge( row );
			}
			else
			{
				if ( goUpDownCorner1( row ))
					return true;
			}
			return false;
		}

		/**
		 * 到达左或右边缘
		 * @param col 列数，-1为到达左边缘
		 */
		private function goLeftRightAtEdge( col:int ):void
		{
			vecThird = new Vector.<IItem>();
			//添加边界外的节点
			var i:int = 0;
			if (s_rows > e_rows)
			{
				for (i = s_rows; i >= e_rows; i--)
				{
					vecThird.push(createTempItem( col, i ));
				}
			}
			else
			{
				for (i = s_rows; i <= e_rows; i++)
				{
					vecThird.push(createTempItem( col, i ));
				}
			}
			if ( col == -1 )
			{
				for ( var a:int = 0; a <= e_cols; a++ )
				{
					if ( goEdgeAddItem( e_rows, a ))
						break;
				}
			}
			else
			{
				for ( a = cols - 1; a >= e_cols; a-- )
				{
					if ( goEdgeAddItem( e_rows, a ))
						break;
				}
			}
		}

		/**
		 * 到达上或下边缘
		 * @param row 行数 ， -1为到达上边缘
		 */
		private function goUpDownAtEdge( row:int ):void
		{
			vecThird = new Vector.<IItem>();
			//添加边界外的节点
			var i:int = 0;
			if (s_cols > e_cols)
			{
				for (i = s_cols; i >= e_cols; i--)
				{
					vecThird.push(createTempItem( i, row ));
				}
			}
			else
			{
				for (i = s_cols; i <= e_cols; i++)
				{
					vecThird.push(createTempItem( i, row ));
				}
			}
			if ( row == -1 )
			{
				for ( var a:int = 0; a <= e_rows; a++ )
				{
					if ( goEdgeAddItem( a, e_cols ))
						break;
				}
			}
			else
			{
				for ( a = rows - 1; a >= e_rows; a-- )
				{
					if ( goEdgeAddItem( a, e_cols ))
						break;
				}
			}
		}

		/**
		 * 左右方向查询时第一个拐点查询
		 * @param col 指定的列数，将作为拐点尝试查询
		 * @return 若是在当前拐点是终点目标，则返回true，停止向后查询，否则返回false，向后继续查询
		 */
		private function goLeftRightCorner1( col:int ):Boolean
		{
			var item:IItem = listAry[ s_rows ][ col ];
			vecFirst.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点 
					seekGroups.push( vecFirst );
				return true;
			}
			else
			{
				vecSecond = new Vector.<IItem>();
				for ( var j:int = s_rows - 1; j >= 0; j-- )
				{
					if ( goLeftRightCorner2( col, j ))
						break;
				}
				vecSecond = new Vector.<IItem>();
				for ( j = s_rows + 1; j < rows; j++ )
				{
					if ( goLeftRightCorner2( col, j ))
						break;
				}
			}
			return false;
		}

		/**
		 * 上下方向查询时第一个拐点查询
		 * @param col 指定的列数，将作为拐点尝试查询
		 * @return 若是在当前拐点是终点目标，则返回true，停止向后查询，否则返回false，向后继续查询
		 */
		private function goUpDownCorner1( row:int ):Boolean
		{
			var item:IItem = listAry[ row ][ s_cols ];
			vecFirst.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点 
					seekGroups.push( vecFirst );
				return true;
			}
			else
			{
				vecSecond = new Vector.<IItem>();
				for ( var j:int = s_cols - 1; j >= 0; j-- )
				{
					if ( goUpDownCorner2( row, j ))
						break;
				}
				vecSecond = new Vector.<IItem>();
				for ( j = s_cols + 1; j < cols; j++ )
				{
					if ( goUpDownCorner2( row, j ))
						break;
				}
			}
			return false;
		}

		/**
		 * 查询第二次拐点
		 * @param col 拐点所在的列数
		 * @param row 拐点所在的行数
		 * @return 若是当前的拐点是终点目标，则返回true，停止向后查询，都在返回false，会继续向后查询
		 */
		private function goLeftRightCorner2( col:int, row:int ):Boolean
		{
			var item:IItem = listAry[ row ][ col ];
			vecSecond.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点 
					seekGroups.push( vecFirst.concat( vecSecond ));
				return true;
			}
			else
			{
				vecThird = new Vector.<IItem>();
				for ( var k:int = col - 1; k >= e_cols; k-- )
				{
					if ( goThirdAddItem( row, k ))
						break;
				}
				vecThird = new Vector.<IItem>();
				for ( k = col + 1; k <= e_cols; k++ )
				{
					if ( goThirdAddItem( row, k ))
						break;
				}
			}
			return false;
		}

		/**
		 * 查询第二次拐点
		 * @param row 拐点所在的行数
		 * @param col 拐点所在的列数
		 * @return 若是当前的拐点是终点目标，则返回true，停止向后查询，都在返回false，会继续向后查询
		 */
		private function goUpDownCorner2( row:int, col:int ):Boolean
		{
			var item:IItem = listAry[ row ][ col ];
			vecSecond.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点
					seekGroups.push( vecFirst.concat( vecSecond ));
				return true;
			}
			else
			{
				vecThird = new Vector.<IItem>();
				for ( var k:int = row - 1; k >= e_rows; k-- )
				{
					if ( goThirdAddItem( k, col ))
						break;
				}
				vecThird = new Vector.<IItem>();
				for ( k = row + 1; k <= e_rows; k++ )
				{
					if ( goThirdAddItem( k, col ))
						break;
				}
			}
			return false;
		}

		/**
		 * 查询到边缘时对当前指定点判定
		 * @param row 当前行号
		 * @param col 当前列号
		 * @return 若是当前节点为终点目标，则返回true，否则返回false
		 */
		private function goEdgeAddItem( row:int, col:int ):Boolean
		{
			var item:IItem = listAry[ row ][ col ];
			vecThird.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点 
					seekGroups.push( vecFirst.concat( vecThird ));
				return true;
			}
			return false;
		}

		/**
		 * 第二次拐点后的节点判定
		 * @param row 当前行号
		 * @param col 当前列号
		 * @return 若是当前节点为终点目标，则返回true，否则返回false
		 */
		private function goThirdAddItem( row:int, col:int ):Boolean
		{
			var item:IItem = listAry[ row ][ col ];
			vecThird.push( item );
			if ( item.isReal )
			{
				if ( item == endItem ) // 是结束节点
					seekGroups.push( vecFirst.concat( vecSecond, vecThird ));
				return true;
			}
			return false;
		}

	}
}
