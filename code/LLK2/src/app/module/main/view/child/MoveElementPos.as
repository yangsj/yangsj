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
					byUpMoveLeft();
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
				
				case DirectionType.moveDownLeft:
					moveDownLeft();
					break;
				case DirectionType.moveDownRight:
					moveDownRight();
					break;
				case DirectionType.moveUpLeft:
					moveUpLeft();
					break;
				case DirectionType.moveUpRight:
					moveUpRight();
					break;
				
//				case DirectionType.byCenterFromUpAndDown:
//					byCenterFromUpAndDown();
//					break;
//				case DirectionType.byCenterFromLeftAndRight:
//					byCenterFromLeftAndRight();
//					break;
				case DirectionType.byCenterFromLeftAndRightAndUpAndDown:
					byCenterFromLeftAndRightAndUpAndDown();
					break;
				case DirectionType.byCenterFromUpAndDownThenMoveLeft:
					byCenterFromUpAndDownThenMoveLeft();
					break;
				case DirectionType.byCenterFromUpAndDownThenMoveRight:
					byCenterFromUpAndDownThenMoveRight();
					break;
				case DirectionType.byCenterFromLeftAndRightThenMoveDown:
					byCenterFromLeftAndRightThenMoveDown();
					break;
				case DirectionType.byCenterFromLeftAndRightThenMoveUp:
					byCenterFromLeftAndRightThenMoveUp();
					break;
				default:
					break;
			}
			moveRowOrCol();
		}

		private function moveDown( startCol:int = 0, endCol:int = ElementConfig.COLS, borderRow:int = ElementConfig.ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = borderRow - 1; row >= 0; row-- )
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
							element.rows = 0;
							_map[ 0 ][ col ] = element;
							row++;
							num++;
						}
					}
				}
			}
		}

		private function moveUp( startCol:int = 0, endCol:int = ElementConfig.COLS, borderRow:int = 0 ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			var end:int = ElementConfig.ROWS - 1;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = borderRow; row < ElementConfig.ROWS; row++ )
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

		private function moveLeft( startRow:int = 0, endRow:int = ElementConfig.ROWS, borderCol:int = 0 ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = borderCol; col < ElementConfig.COLS; col++ )
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

		private function moveRight( startRow:int = 0, endRow:int = ElementConfig.ROWS, borderCol:int = ElementConfig.COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = borderCol - 1; col >= 0; col-- )
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
							element.cols = 0
							_map[ row ][ 0 ] = element;
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
			moveUp( 0, int( ElementConfig.COLS >> 1 ))
			moveDown( int( ElementConfig.COLS >> 1 ), ElementConfig.COLS );
		}

		private function moveDownUp():void
		{
			moveDown( 0, int( ElementConfig.COLS >> 1 ))
			moveUp( int( ElementConfig.COLS >> 1 ), ElementConfig.COLS );
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
		
		private function moveDownLeft():void
		{
			moveDown();
			moveLeft();
		}
		
		private function moveDownRight():void
		{
			moveDown();
			moveRight();
		}
		
		private function moveUpLeft():void
		{
			moveUp();
			moveLeft();
		}
		
		private function moveUpRight():void
		{
			moveUp();
			moveRight();
		}
		
		private function byCenterFromLeftAndRight():void
		{
			byLeft( ElementConfig.COLS >> 1, ElementConfig.COLS );
			byRight( 0, ElementConfig.COLS >> 1 );
			moveDown( 0, ElementConfig.COLS, ElementConfig.ROWS >> 1 );
			moveUp(0, ElementConfig.COLS, ElementConfig.ROWS >> 1 );
		}
		private function byCenterFromUpAndDown():void
		{
			byUp( ElementConfig.ROWS >> 1, ElementConfig.ROWS);
			byDown( 0, ElementConfig.ROWS >> 1 );
			moveLeft( 0, ElementConfig.ROWS, ElementConfig.COLS >> 1 );
			moveRight( 0, ElementConfig.ROWS, ElementConfig.COLS >> 1 );
		}
		
		private function byCenterFromLeftAndRightAndUpAndDown():void
		{
			moveDown( 0, ElementConfig.COLS, ElementConfig.ROWS >> 1 );
			moveUp(0, ElementConfig.COLS, ElementConfig.ROWS >> 1 );
			moveLeft( 0, ElementConfig.ROWS, ElementConfig.COLS >> 1 );
			moveRight( 0, ElementConfig.ROWS, ElementConfig.COLS >> 1 );
		}
		
		private function byCenterFromLeftAndRightThenMoveDown():void
		{
			byCenterFromLeftAndRight();
			moveDown();
		}
		
		private function byCenterFromLeftAndRightThenMoveUp():void
		{
			byCenterFromLeftAndRight();
			moveUp();
		}
		
		private function byCenterFromUpAndDownThenMoveLeft():void
		{
			byCenterFromUpAndDown();
			moveLeft();
		}
		
		private function byCenterFromUpAndDownThenMoveRight():void
		{
			byCenterFromUpAndDown();
			moveRight();
		}

		private function byUpOrDown( isDown:Boolean, startRow:int = 0, endRow:int = ElementConfig.ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			var num:int = 0;
			var row:int = ( isDown ? endRow - 1 : startRow );
			for ( row; ( isDown ? row >= startRow : row < endRow ); ( isDown ? row-- : row++ ))
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
				if ( isMove && ( isDown ? row > startRow : row < endRow ))
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
					num++;
					isDown ? row++ : row--;
				}
				if ( num >= ElementConfig.ROWS )
				{
					break;
				}
			}
		}

		private function byLeftOrRight( isLeft:Boolean, startCol:int = 0, endCol:int = ElementConfig.COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			var num:int = 0;
			var col:int = isLeft ? startCol : endCol - 1;
			for ( col; ( isLeft ? col < endCol : col >= startCol ); ( isLeft ? col++ : col-- ))
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
				if ( isMove && ( isLeft ? col < endCol : col > startCol) )
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
					num++;
					isLeft ? col-- : col++;
				}
				if ( num >= ElementConfig.COLS )
				{
					break;
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
