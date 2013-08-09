package app.module.main.view.child
{
	import app.module.main.DirectionType;
	import app.module.main.view.ElementConfig;
	import app.module.main.view.element.IElement;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-9
	 */
	public class MoveElementPos
	{
		private var _map:Vector.<Vector.<IElement>>;
		private var _moveIntervalTime:Number = 0;

		public function MoveElementPos()
		{
		}

		public function initMap( map:Vector.<Vector.<IElement>> ):void
		{
			_map = map;
		}

		public function moveElements( direction:uint, moveIntervalTime:Number ):void
		{
			_moveIntervalTime = moveIntervalTime;
			switch ( direction )
			{
				case DirectionType.DEFAULT:
					break;
				case DirectionType.DOWN:
					moveDown();
					break;
				case DirectionType.UP:
					moveUp();
					break;
				case DirectionType.LEFT:
					moveLeft();
					break;
				case DirectionType.RIGHT:
					moveRight();
					break;
				case DirectionType.downAndUp:
					moveDownUp();
					break;
				case DirectionType.leftAndRight:
					moveLeftRight();
					break;
				case DirectionType.upAndDown:
					moveUpDown();
					break;
				case DirectionType.rightAndLeft:
					moveRightLeft();
					break;
				case DirectionType.byDown:
					byDown();
					break;
				case DirectionType.byUp:
					byUp();
					break;
				case DirectionType.byLeft:
					byLeft();
					break;
				case DirectionType.byRight:
					byRight();
					break;
				case DirectionType.byLeftMoveDown:
					byLeftMoveDown();
					break;
				case DirectionType.byLeftMoveUp:
					byLeftMoveUp();
					break;
				case DirectionType.byRightMoveDown:
					byRightMoveDown();
					break;
				case DirectionType.byRightMoveUp:
					byRightMoveUp();
					break;
				case DirectionType.byUpMoveLeft:
					byUpMoveRight();
					break;
				case DirectionType.byUpMoveRight:
					byUpMoveRight();
					break;
				case DirectionType.byDownMoveLeft:
					byDownMoveLeft();
					break;
				case DirectionType.byDownMoveRight:
					byDownMoveRight();
					break;
				default:
					break;
			}
			moveRowOrCol();
			_moveIntervalTime = 0;
		}

		private function moveDown( startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = ElementConfig.ROWS - 1; row >= 0; row-- )
				{
					if ( num < ElementConfig.ROWS )
					{
						element = _map[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = row; i > 0; i-- )
							{
								temp = _map[ i - 1 ][ col ];
								temp.rows = i;
								_map[ i ][ col ] = temp;
							}
							element.rows = startCol;
							_map[ startCol ][ col ] = element;
							row++;
							num++;
						}
					}
				}
			}
		}

		private function moveUp( startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			var end:int = ElementConfig.ROWS - 1;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = 0; row < ElementConfig.ROWS; row++ )
				{
					if ( num < ElementConfig.ROWS )
					{
						element = _map[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = row; i < end; i++ )
							{
								temp = _map[ i + 1 ][ col ];
								temp.rows = i;
								_map[ i ][ col ] = temp;
							}
							element.rows = end;
							_map[ end ][ col ] = element;
							row--;
							num++;
						}
					}
				}
			}
		}

		private function moveLeft( startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = 0; col < ElementConfig.COLS; col++ )
				{
					if ( num < ElementConfig.COLS )
					{
						element = _map[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = col; i < ElementConfig.COLS - 1; i++ )
							{
								temp = _map[ row ][ i + 1 ];
								temp.cols = i;
								_map[ row ][ i ] = temp;
							}
							element.cols = ElementConfig.COLS - 1;
							_map[ row ][ ElementConfig.COLS - 1 ] = element;
							col--;
							num++;
						}
					}
				}
			}
		}

		private function moveRight( startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = ElementConfig.COLS - 1; col >= 0; col-- )
				{
					if ( num < ElementConfig.COLS )
					{
						element = _map[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = col; i > 0; i-- )
							{
								temp = _map[ row ][ i - 1 ];
								temp.cols = i;
								_map[ row ][ i ] = temp;
							}
							element.cols = startRow
							_map[ row ][ startRow ] = element;
							col++;
							num++;
						}
					}
				}
			}
		}

		private function byUp( startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			byUpOrDown( false, startRow, endRow );
		}

		private function byDown( startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			byUpOrDown( true, startRow, endRow );
		}

		private function byLeft( startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			byLeftOrRight( true, startCol, endCol );
		}

		private function byRight( startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			byLeftOrRight( false, startCol, endCol );
		}

		private function moveUpDown():void
		{
			moveDown( 0, int( ElementConfig.COLS >> 1 ))
			moveUp( int( ElementConfig.COLS >> 1 ), ElementConfig.COLS );
		}

		private function moveDownUp():void
		{
			moveUp( 0, int( ElementConfig.COLS >> 1 ))
			moveDown( int( ElementConfig.COLS >> 1 ), ElementConfig.COLS );
		}

		private function moveLeftRight():void
		{
			moveLeft( 0, int( ElementConfig.ROWS >> 1 ));
			moveRight( int( ElementConfig.ROWS >> 1 ), ElementConfig.ROWS );
		}

		private function moveRightLeft():void
		{
			moveRight( 0, int( ElementConfig.ROWS >> 1 ));
			moveLeft( int( ElementConfig.ROWS >> 1 ), ElementConfig.ROWS );
		}

		private function byRightMoveUp():void
		{
			moveUp();
			byRight();
		}

		private function byRightMoveDown():void
		{
			moveDown();
			byRight();
		}

		private function byLeftMoveUp():void
		{
			moveUp();
			byLeft();
		}

		private function byLeftMoveDown():void
		{
			moveDown();
			byLeft();
		}

		private function byUpMoveLeft():void
		{
			moveLeft();
			byUp();
		}

		private function byUpMoveRight():void
		{
			moveRight();
			byUp();
		}

		private function byDownMoveLeft():void
		{
			moveLeft();
			byDown();
		}

		private function byDownMoveRight():void
		{
			moveRight();
			byDown();
		}

		private function byUpOrDown( isDown:Boolean, startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var row:int = endRow - 1; row >= startRow; row-- )
			{
				isMove = true;
				for ( var col:int = 0; col < ElementConfig.COLS; col++ )
				{
					element = _map[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && row > startRow )
				{
					for ( col = 0; col < ElementConfig.COLS; col++ )
					{
						temp = _map[ row ][ col ];
						if ( isDown )
						{
							for ( var i:int = row - 1; i >= startRow; i-- )
							{
								element = _map[ i ][ col ];
								element.rows = i + 1;
								_map[ i + 1 ][ col ] = element;
							}
							_map[ startRow ][ col ] = temp;
						}
						else
						{
							for ( i = row + 1; i < endRow; i++ )
							{
								element = _map[ i ][ col ];
								element.rows = i - 1;
								_map[ i - 1 ][ col ] = element;
							}
							_map[ endRow - 1 ][ col ] = temp;
						}
					}
				}
			}
		}

		private function byLeftOrRight( isLeft:Boolean, startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var col:int = endCol - 1; col >= startCol; col-- )
			{
				isMove = true;
				for ( var row:int = 0; row < ElementConfig.ROWS; row++ )
				{
					element = _map[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && col > startCol )
				{
					for ( row = 0; row < ElementConfig.ROWS; row++ )
					{
						temp = _map[ row ][ col ];
						if ( isLeft )
						{
							for ( var i:int = col + 1; i < endCol; i++ )
							{
								element = _map[ row ][ i ];
								element.cols = i - 1;
								_map[ row ][ i - 1 ] = element;
							}
							_map[ row ][ endCol - 1 ] = temp;
						}
						else
						{
							for ( i = col - 1; i >= startCol; i-- )
							{
								element = _map[ row ][ i ];
								element.cols = i + 1;
								_map[ row ][ i + 1 ] = element;
							}
							_map[ row ][ startCol ] = temp;
						}
					}
				}
			}
		}

		private function moveRowOrCol():void
		{
			var element:IElement;
			for ( var row:int = 0; row < ElementConfig.ROWS; row++ )
			{
				for ( var col:int = 0; col < ElementConfig.COLS; col++ )
				{
					element = _map[ row ][ col ];
					element.refresh();
					element.tween( _moveIntervalTime );
				}
			}
		}


	}
}
