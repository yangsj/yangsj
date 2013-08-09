package app.module.main.view.child
{
	import app.module.main.view.ElementConfig;
	import app.module.main.view.element.Element;
	import app.module.main.view.element.IElement;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-2
	 */
	public class FindPath
	{
		private var _seekGroups:Vector.<Vector.<IElement>>;
		private var _vecFirst:Vector.<IElement>; // 记录未发生拐点的节点
		private var _vecSecond:Vector.<IElement>; // 记录第一次拐点后的节点
		private var _vecThird:Vector.<IElement>; // 记录第二次拐点后的节点
		private var _s_cols:int = 0; // 起始节点的列号
		private var _s_rows:int = 0; // 起始节点的行号
		private var _e_cols:int = 0; // 终止节点的列号
		private var _e_rows:int = 0; // 终止节点的行号

		private var _startItem:IElement; // 起始节点
		private var _endItem:IElement; // 结束节点
		private var _map:Vector.<Vector.<IElement>>;
		
		private var _cols:uint = ElementConfig.COLS;
		private var _rows:uint = ElementConfig.ROWS;

		public function FindPath()
		{
		}

		public function initMap( map:Vector.<Vector.<IElement>> ):void
		{
			_map = map;
		}

		public function seek( startItem:IElement, endItem:IElement ):Vector.<IElement>
		{
			_startItem = startItem;
			_endItem = endItem;

			// set init vars
			_seekGroups = new Vector.<Vector.<IElement>>();
			_s_cols = _startItem.cols;
			_s_rows = _startItem.rows;
			_e_cols = _endItem.cols;
			_e_rows = _endItem.rows;

			// seek
			goLeft();
			goRight();
			goUp();
			goDown();

			// sort paths : According to the small to large order
			_seekGroups.sort( sortVec );

			return _seekGroups.pop();
		}

		/**
		 * 向左查找
		 */
		private function goLeft():void
		{
			_vecFirst = new Vector.<IElement>();
			_vecFirst.push( _startItem );
			for ( var i:int = _s_cols - 1; i >= -1; i-- ) //从起始节点向左循环
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
			_vecFirst = new Vector.<IElement>();
			_vecFirst.push( _startItem );
			for ( var i:int = _s_cols + 1; i <= _cols; i++ ) //从起始节点向右循环
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
			_vecFirst = new Vector.<IElement>();
			_vecFirst.push( _startItem );
			for ( var i:int = _s_rows - 1; i >= -1; i-- ) //从起始节点向上循环
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
			_vecFirst = new Vector.<IElement>();
			_vecFirst.push( _startItem );
			for ( var i:int = _s_rows + 1; i <= _rows; i++ ) //从起始节点向下循环
			{
				if ( goUpDownLoop( i ))
					break;
			}
		}

		/**
		 * 开始向左或右方向查询循环
		 * @param col 当前要查询的列号
		 * @return 若是查询到终止节点，则返回true，否则返回false
		 */
		private function goLeftRightLoop( col:int ):Boolean
		{
			if ( col == -1 || col == _cols ) // 超出边界
			{
				goLeftOrRightAtEdge( col );
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
			if ( row == -1 || row == _rows ) // 超出边界
			{
				goUpOrDownAtEdge( row );
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
		private function goLeftOrRightAtEdge( col:int ):void
		{
			_vecThird = new Vector.<IElement>();
			//添加边界外的节点
			var i:int = 0;
			if ( _s_rows > _e_rows )
			{
				for ( i = _s_rows; i >= _e_rows; i-- )
				{
					_vecThird.push( createTempItem( col, i ));
				}
			}
			else
			{
				for ( i = _s_rows; i <= _e_rows; i++ )
				{
					_vecThird.push( createTempItem( col, i ));
				}
			}
			if ( col == -1 )
			{
				for ( var a:int = 0; a <= _e_cols; a++ )
				{
					if ( goEdgeAddItem( _e_rows, a ))
						break;
				}
			}
			else
			{
				for ( a = _cols - 1; a >= _e_cols; a-- )
				{
					if ( goEdgeAddItem( _e_rows, a ))
						break;
				}
			}
		}

		/**
		 * 到达上或下边缘
		 * @param row 行数 ， -1为到达上边缘
		 */
		private function goUpOrDownAtEdge( row:int ):void
		{
			_vecThird = new Vector.<IElement>();
			//添加边界外的节点
			var i:int = 0;
			if ( _s_cols > _e_cols )
			{
				for ( i = _s_cols; i >= _e_cols; i-- )
				{
					_vecThird.push( createTempItem( i, row ));
				}
			}
			else
			{
				for ( i = _s_cols; i <= _e_cols; i++ )
				{
					_vecThird.push( createTempItem( i, row ));
				}
			}
			if ( row == -1 )
			{
				for ( var a:int = 0; a <= _e_rows; a++ )
				{
					if ( goEdgeAddItem( a, _e_cols ))
						break;
				}
			}
			else
			{
				for ( a = _rows - 1; a >= _e_rows; a-- )
				{
					if ( goEdgeAddItem( a, _e_cols ))
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
			var item:IElement = _map[ _s_rows ][ col ];
			_vecFirst.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点 
					_seekGroups.push( _vecFirst );
				return true;
			}
			else
			{
				_vecSecond = new Vector.<IElement>();
				for ( var j:int = _s_rows - 1; j >= 0; j-- )
				{
					if ( goLeftRightCorner2( col, j ))
						break;
				}
				_vecSecond = new Vector.<IElement>();
				for ( j = _s_rows + 1; j < _rows; j++ )
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
			var item:IElement = _map[ row ][ _s_cols ];
			_vecFirst.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点 
					_seekGroups.push( _vecFirst );
				return true;
			}
			else
			{
				_vecSecond = new Vector.<IElement>();
				for ( var j:int = _s_cols - 1; j >= 0; j-- )
				{
					if ( goUpDownCorner2( row, j ))
						break;
				}
				_vecSecond = new Vector.<IElement>();
				for ( j = _s_cols + 1; j < _cols; j++ )
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
			var item:IElement = _map[ row ][ col ];
			_vecSecond.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点 
					_seekGroups.push( _vecFirst.concat( _vecSecond ));
				return true;
			}
			else
			{
				_vecThird = new Vector.<IElement>();
				for ( var k:int = col - 1; k >= _e_cols; k-- )
				{
					if ( goThirdAddItem( row, k ))
						break;
				}
				_vecThird = new Vector.<IElement>();
				for ( k = col + 1; k <= _e_cols; k++ )
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
			var item:IElement = _map[ row ][ col ];
			_vecSecond.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点
					_seekGroups.push( _vecFirst.concat( _vecSecond ));
				return true;
			}
			else
			{
				_vecThird = new Vector.<IElement>();
				for ( var k:int = row - 1; k >= _e_rows; k-- )
				{
					if ( goThirdAddItem( k, col ))
						break;
				}
				_vecThird = new Vector.<IElement>();
				for ( k = row + 1; k <= _e_rows; k++ )
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
			var item:IElement = _map[ row ][ col ];
			_vecThird.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点 
					_seekGroups.push( _vecFirst.concat( _vecThird ));
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
			var item:IElement = _map[ row ][ col ];
			_vecThird.push( item );
			if ( item.isReal )
			{
				if ( item == _endItem ) // 是结束节点
					_seekGroups.push( _vecFirst.concat( _vecSecond, _vecThird ));
				return true;
			}
			return false;
		}




		private function sortVec( a:Vector.<IElement>, b:Vector.<IElement> ):Number
		{
			if ( a.length > b.length )
				return -1;
			else if ( a.length < b.length )
				return 1;
			return 0;
		}

		private function createTempItem( cols:int, rows:int ):IElement
		{
			var item:IElement = new Element();
			item.parentTarget = _startItem.parentTarget;
			item.cols = cols;
			item.rows = rows;
			item.initialize();
			item.visible = false;
			return item;
		}

	}
}
