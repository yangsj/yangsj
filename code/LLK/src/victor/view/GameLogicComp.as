package victor.view
{
	import com.greensock.TweenMax;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import victor.GameStage;
	import victor.core.IItem;
	import victor.view.res.Item;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class GameLogicComp extends Sprite
	{
		private const cols:int = 10;
		private const rows:int = 13;

		// item 列表显示容器
		private var _listContainer:Sprite;
		// 路径线显示容器
		private var _lineContainer:Sprite;

		private var markList:Vector.<int>;

		private var listAry:Vector.<Vector.<IItem>>;
		private var markAry:Vector.<int>;

		private var seekGroups:Vector.<Vector.<IItem>>;

		private var startItem:IItem;
		private var endItem:IItem;

		public function GameLogicComp()
		{
			intiData();
		}

		private function intiData():void
		{
			var leng:int = cols * rows;
			var i:int = 0;
			var j:int = 0;
			markList = new Vector.<int>();
			for ( i = 1; i < 20; i++ )
			{
				markList.push( i );
			}

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
			markAry = new Vector.<int>( leng );
			for ( i = 0; i < leng; i += 2 )
			{
				markAry[ i ] = markAry[ i + 1 ] = markList[ int( Math.random() * markList.length )];
			}

			_listContainer = new Sprite();
			_lineContainer = new Sprite();
			addChild( _listContainer );
			addChild( _lineContainer );
			_listContainer.x = 50;
			_listContainer.y = 80;
			GameStage.adjustXY( _listContainer );
		}

		private function randomMarkList():void
		{
			markAry.sort( abc );
			function abc( a:int, b:int ):Number
			{
				return int( Math.random() * 3 ) - 1;
			}
		}

		public function initialize():void
		{
			_listContainer.removeChildren();
		}

		public function startAndReset():void
		{
			randomMarkList();
			for ( var i:int = 0; i < rows; i++ )
			{
				for ( var j:int = 0; j < cols; j++ )
				{
					var item:IItem = listAry[ i ][ j ];
					item.cols = j;
					item.rows = i;
					item.mark = markAry[ i * cols + j ];
					item.initialize();
					_listContainer.addChild( item as DisplayObject );
				}
			}

//			GameStage.adjustXYForTarget( _listContainer );

			_listContainer.mouseEnabled = false;
			_listContainer.addEventListener( MouseEvent.CLICK, clickHandler );

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

		private function drawLine( points:Vector.<Point> ):void
		{
			if ( points && points.length > 1 )
			{
				clearLine();

				var point:Point = points.shift();
				_lineContainer.graphics.lineStyle( 3, 0xff0000 );
				_lineContainer.graphics.moveTo( point.x, point.y );
				for each ( point in points )
				{
					_lineContainer.graphics.lineTo( point.x, point.y );
				}
				TweenMax.delayedCall( 0.5, clearLine );
			}
		}

		private function clearLine():void
		{
			_lineContainer.graphics.clear();
			_listContainer.mouseChildren = true;
		}


		///////////// seek

		private function seek():void
		{
			seekGroups = new Vector.<Vector.<IItem>>();
			goLeft();
			goRight();
			goUp();
			goDown();
			if ( seekGroups.length > 0 )
			{
				seekGroups.sort( sortVec );
				var tempVec1:Vector.<IItem> = seekGroups.pop();
				var temoVec2:Vector.<Point> = new Vector.<Point>();
				for each ( var item:IItem in tempVec1 )
				{
					temoVec2.push( item.globalPoint );
					item.removeFromParent();
				}
				drawLine( temoVec2 );
				startItem = null;
			}
			else
			{
				startItem.selected = false;
				endItem.selected = true;
				startItem = endItem;
			}
			endItem = null;
		}

		/**
		 * 向左查找
		 */
		private function goLeft():void
		{
			var s_cols:int = startItem.cols;
			var s_rows:int = startItem.rows;
			var e_cols:int = endItem.cols;
			var e_rows:int = endItem.rows;
			var vec1:Vector.<IItem> = new Vector.<IItem>();
			var vec2:Vector.<IItem>;
			var item:IItem;
			vec1.push( startItem );
			for ( var i:int = s_cols - 1; i >= -1; i-- ) //从当前点一次向左循环
			{
				if ( i == -1 ) // 超出左边界
				{
					var temp1:Vector.<IItem> = new Vector.<IItem>();
					temp1.push( createTempItem( -1, s_rows ), createTempItem( -1, e_rows )); //添加边界外的两个拐点
					for ( var a:int = 0; a <= e_cols; a++ )
					{
						item = listAry[ e_rows ][ a ];
						temp1.push( item );
						if ( item.isReal )
						{
							if ( item == endItem ) // 是结束节点
							{
								temp1.push( item );
								vec2 = new Vector.<IItem>();
								vec2 = vec1.concat( temp1 );
								seekGroups.push( vec2 );
							}
							break;
						}
					}
				}
				else
				{
					item = listAry[ s_rows ][ i ];
					vec1.push( item );
					if ( item.isReal )
					{
						if ( item == endItem ) // 是结束节点 
							seekGroups.push( vec1 );
						break;
					}
					else
					{
						var temp2:Vector.<IItem> = new Vector.<IItem>();
						for ( var j:int = s_rows - 1; j >= 0; j-- )
						{
							item = listAry[ j ][ i ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								var temp3:Vector.<IItem> = new Vector.<IItem>();
								for ( var k:int = i - 1; k >= 0; k-- )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_cols; k++ )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
						temp2 = new Vector.<IItem>();
						for ( j = s_rows + 1; j < rows; j++ )
						{
							item = listAry[ j ][ i ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_cols; k-- )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_cols; k++ )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
					}
				}
			}
		}

		/**
		 * 向右查找
		 */
		private function goRight():void
		{
			var s_cols:int = startItem.cols;
			var s_rows:int = startItem.rows;
			var e_cols:int = endItem.cols;
			var e_rows:int = endItem.rows;
			var vec1:Vector.<IItem> = new Vector.<IItem>();
			var vec2:Vector.<IItem>;
			var item:IItem;
			vec1.push( startItem );
			for ( var i:int = s_cols + 1; i <= cols; i++ ) //从当前点一次向右循环
			{
				if ( i == cols ) // 超出左边界
				{
					var temp1:Vector.<IItem> = new Vector.<IItem>();
					temp1.push( createTempItem( cols, s_rows ), createTempItem( cols, e_rows )); //添加边界外的两个拐点
					for ( var a:int = cols - 1; a >= e_cols; a-- )
					{
						item = listAry[ e_rows ][ a ];
						temp1.push( item );
						if ( item.isReal )
						{
							if ( item == endItem ) // 是结束节点
							{
								temp1.push( item );
								vec2 = new Vector.<IItem>();
								vec2 = vec1.concat( temp1 );
								seekGroups.push( vec2 );
							}
							break;
						}
					}
				}
				else
				{
					item = listAry[ s_rows ][ i ];
					vec1.push( item );
					if ( item.isReal )
					{
						if ( item == endItem ) // 是结束节点 
							seekGroups.push( vec1 );
						break;
					}
					else
					{
						var temp2:Vector.<IItem> = new Vector.<IItem>();
						for ( var j:int = s_rows - 1; j >= 0; j-- )
						{
							item = listAry[ j ][ i ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								var temp3:Vector.<IItem> = new Vector.<IItem>();
								for ( var k:int = i + 1; k <= e_cols; k++ )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_cols; k-- )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
						temp2 = new Vector.<IItem>();
						for ( j = s_rows + 1; j < rows; j++ )
						{
							item = listAry[ j ][ i ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_cols; k++ )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_cols; k-- )
								{
									item = listAry[ j ][ k ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
					}
				}
			}
		}

		/**
		 * 向上查找
		 */
		private function goUp():void
		{
			var s_cols:int = startItem.cols;
			var s_rows:int = startItem.rows;
			var e_cols:int = endItem.cols;
			var e_rows:int = endItem.rows;
			var vec1:Vector.<IItem> = new Vector.<IItem>();
			var vec2:Vector.<IItem>;
			var item:IItem;
			vec1.push( startItem );
			for ( var i:int = s_rows - 1; i >= -1; i-- ) //从当前点一次向上循环
			{
				if ( i == -1 ) // 超出左边界
				{
					var temp1:Vector.<IItem> = new Vector.<IItem>();
					temp1.push( createTempItem( s_cols, -1 ), createTempItem( e_cols, -1 )); //添加边界外的两个拐点
					for ( var a:int = 0; a <= e_rows; a++ )
					{
						item = listAry[ a ][ e_cols ];
						temp1.push( item );
						if ( item.isReal )
						{
							if ( item == endItem ) // 是结束节点
							{
								temp1.push( item );
								vec2 = new Vector.<IItem>();
								vec2 = vec1.concat( temp1 );
								seekGroups.push( vec2 );
							}
							break;
						}
					}
				}
				else
				{
					item = listAry[ i ][ s_cols ];
					vec1.push( item );
					if ( item.isReal )
					{
						if ( item == endItem ) // 是结束节点 
							seekGroups.push( vec1 );
						break;
					}
					else
					{
						var temp2:Vector.<IItem> = new Vector.<IItem>();
						for ( var j:int = s_cols - 1; j >= 0; j-- )
						{
							item = listAry[ i ][ j ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								var temp3:Vector.<IItem> = new Vector.<IItem>();
								for ( var k:int = i - 1; k >= e_rows; k-- )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_rows; k++ )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
						temp2 = new Vector.<IItem>();
						for ( j = s_cols + 1; j < cols; j++ )
						{
							item = listAry[ i ][ j ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_rows; k-- )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_rows; k++ )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
					}
				}
			}
		}

		/**
		 * 向上查找
		 */
		private function goDown():void
		{
			var s_cols:int = startItem.cols;
			var s_rows:int = startItem.rows;
			var e_cols:int = endItem.cols;
			var e_rows:int = endItem.rows;
			var vec1:Vector.<IItem> = new Vector.<IItem>();
			var vec2:Vector.<IItem>;
			var item:IItem;
			vec1.push( startItem );
			for ( var i:int = s_rows + 1; i <= rows; i++ ) //从当前点一次向下循环
			{
				if ( i == rows ) // 超出左边界
				{
					var temp1:Vector.<IItem> = new Vector.<IItem>();
					temp1.push( createTempItem( s_cols, rows ), createTempItem( e_cols, rows )); //添加边界外的两个拐点
					for ( var a:int = rows - 1; a >= e_rows; a-- )
					{
						item = listAry[ a ][ e_cols ];
						temp1.push( item );
						if ( item.isReal )
						{
							if ( item == endItem ) // 是结束节点
							{
								temp1.push( item );
								vec2 = new Vector.<IItem>();
								vec2 = vec1.concat( temp1 );
								seekGroups.push( vec2 );
							}
							break;
						}
					}
				}
				else
				{
					item = listAry[ i ][ s_cols ];
					vec1.push( item );
					if ( item.isReal )
					{
						if ( item == endItem ) // 是结束节点 
							seekGroups.push( vec1 );
						break;
					}
					else
					{
						var temp2:Vector.<IItem> = new Vector.<IItem>();
						for ( var j:int = s_cols - 1; j >= 0; j-- )
						{
							item = listAry[ i ][ j ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								var temp3:Vector.<IItem> = new Vector.<IItem>();
								for ( var k:int = i + 1; k < rows; k++ )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_rows; k-- )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
						temp2 = new Vector.<IItem>();
						for ( j = s_cols + 1; j < cols; j++ )
						{
							item = listAry[ i ][ j ];
							temp2.push( item );
							if ( item.isReal )
							{
								if ( item == endItem ) // 是结束节点
								{
									vec2 = new Vector.<IItem>();
									vec2 = vec1.concat( temp2 );
									seekGroups.push( vec2 );
								}
								break;
							}
							else
							{
								temp3 = new Vector.<IItem>();
								for ( k = i + 1; k <= e_rows; k++ )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
								temp3 = new Vector.<IItem>();
								for ( k = i - 1; k >= e_rows; k-- )
								{
									item = listAry[ k ][ j ];
									temp3.push( item );
									if ( item.isReal )
									{
										if ( item == endItem ) // 是结束节点
										{
											vec2 = new Vector.<IItem>();
											vec2 = vec1.concat( temp2, temp3 );
											seekGroups.push( vec2 );
										}
										break;
									}
								}
							}
						}
					}
				}
			}
		}


	}
}
