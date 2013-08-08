package app.module.main.view.child
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenAlign;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.TweenEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import app.AppStage;
	import app.EffectControl;
	import app.core.SoundManager;
	import app.core.components.Button;
	import app.data.LevelVo;
	import app.module.main.DirectionType;
	import app.module.main.events.MainEvent;
	import app.module.main.view.element.Element;
	import app.module.main.view.element.IElement;
	import app.utils.ArrayUtil;

	[Event( name = "back_menu", type = "app.module.main.events.MainEvent" )]

	[Event( name = "dispel_success", type = "app.module.main.events.MainEvent" )]

	[Event( name = "add_score", type = "app.module.main.events.MainEvent" )]

	[Event( name = "add_time", type = "app.module.main.events.MainEvent" )]

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class LogicComp extends Sprite
	{
		private const COLS:uint = 6;
		private const ROWS:uint = 9;
		private const COMB_TIME_UNIT:uint = 2000;
		private const COMB_REWAR_SCORE_UNIT:uint = 5;
		private const LENGTH:uint = COLS * ROWS;
		private const HALF:uint = LENGTH >> 1;

		// item 列表显示容器
		private var _listContainer:Sprite;
		// 路径线显示容器
		private var _drawPathLine:DrawPathLine;
		private var _markList:Vector.<int>;
		private var _listAry:Vector.<Vector.<IElement>>;
		private var _markAry:Vector.<int>;
		private var _seekGroups:Vector.<Vector.<IElement>>;
		private var _startItem:IElement;
		private var _endItem:IElement;
		private var _dispelNumber:int = 0;
		private var _levelVo:LevelVo;
		private var _lastClickTime:Number = 0;
		private var _combNumber:int = 0;
		private var _isOver:Boolean = false;
		private var _btnRefresh:Button;
		private var _btnBack:Button;
		private var _findPath:FindPath;

		private var _moveIntervalTime:Number = 0;

		public function LogicComp()
		{
			mouseEnabled = false;
			intiVars();
		}

		private function intiVars():void
		{
			var vec1:Vector.<IElement>;
			_listAry = new Vector.<Vector.<IElement>>( ROWS );
			for ( var i:uint = 0; i < ROWS; i++ )
			{
				vec1 = new Vector.<IElement>( COLS );
				for ( var j:uint = 0; j < COLS; j++ )
				{
					vec1[ j ] = new Element();
				}
				_listAry[ i ] = vec1;
			}
			//
			var leng:uint = 40;
			_markList = new Vector.<int>( leng );
			for ( i = 0; i != leng; i++ )
			{
				_markList[ i ] = ( i + 1 );
			}

			_drawPathLine = new DrawPathLine();
			_listContainer = new Sprite();
			_listContainer.y = 130 * AppStage.scaleY;
			_listContainer.x = ( AppStage.stageWidth - (( _listAry[ 0 ][ 0 ].itemWidth + 5 ) * COLS )) >> 1;

			_btnRefresh = new Button( " 刷 新 ", btnRefreshHandler );
			_btnRefresh.x = ( AppStage.stageWidth >> 1 ) - ( _btnRefresh.width >> 1 ) - 10;
			_btnRefresh.y = AppStage.stageHeight - _btnRefresh.height - 10;

			_btnBack = new Button( " 返 回 ", btnBackHandler );
			_btnBack.x = ( AppStage.stageWidth >> 1 ) + ( _btnBack.width >> 1 ) + 10;
			_btnBack.y = AppStage.stageHeight - _btnBack.height - 10;

			_listContainer.mouseEnabled = false;
			_listContainer.addEventListener( MouseEvent.CLICK, clickHandler );

			_findPath = new FindPath();
			_findPath.initMap( ROWS, COLS, _listAry );

			addChild( _listContainer );
			addChild( _btnRefresh );
			addChild( _btnBack );
			addChild( _drawPathLine );
		}

		private function btnBackHandler():void
		{
			dispatchEvent( new MainEvent( MainEvent.BACK_MENU ));
		}

		private function initMarkData( limit:uint ):void
		{
			limit = Math.min( limit, LENGTH * 0.5 );
			ArrayUtil.randomSort( _markList );
			_markAry ||= new Vector.<int>( LENGTH );
			for ( var i:uint = 0; i < LENGTH; i += 2 )
			{
				_markAry[ i ] = _markAry[ i + 1 ] = _markList[ uint( Math.random() * limit )];
			}
		}

		private function btnRefreshHandler():void
		{
			refresh();
		}

		public function initialize():void
		{
		}

		public function startAndReset( levelVo:LevelVo ):void
		{
			_isOver = false;
			_btnBack.mouseEnabled = false;
			_btnRefresh.mouseEnabled = false;
			_listContainer.removeChildren();
			_dispelNumber = 0;
			_lastClickTime = 0;
			_combNumber = 0;
			_levelVo = levelVo;

			initMarkData( levelVo.picNum );
			ArrayUtil.randomSort( _markAry );

			var item:IElement;
			var groupAry:Array;
			var tweenGroup:TimelineMax;
			for ( var i:uint = 0; i < ROWS; i++ )
			{
				groupAry = [];
				for ( var j:uint = 0; j < COLS; j++ )
				{
					item = _listAry[ i ][ j ];
					item.parentTarget = _listContainer;
					item.mark = _markAry[ i * COLS + j ];
					item.cols = j;
					item.rows = i;
					item.initialize();

					groupAry.push( TweenMax.from( item, 0.5, { x: item.x, y: item.y - AppStage.stageHeight, ease: Back.easeOut }));
				}
				tweenGroup = new TimelineMax();
				tweenGroup.addEventListener( TweenEvent.COMPLETE, complete );
				tweenGroup.appendMultiple( groupAry, 1, TweenAlign.START, 0.1 );
				tweenGroup.play();
			}

			function complete( event:TweenEvent ):void
			{
				var target:TimelineMax = event.target as TimelineMax;

				if ( target )
					target.removeEventListener( TweenEvent.COMPLETE, complete );

				if ( _btnRefresh )
					_btnRefresh.mouseEnabled = true;

				if ( _btnBack )
					_btnBack.mouseEnabled = true;
			}
		}

		private function refresh():void
		{
			var item:IElement;
			ArrayUtil.randomSort( _listAry );
			for ( var i:uint = 0; i < ROWS; i++ )
			{
				for ( var j:uint = 0; j < COLS; j++ )
				{
					item = _listAry[ i ][ j ];
					item.cols = j;
					item.rows = i;
					item.refresh();
				}
			}
			_moveIntervalTime = 0;
			moveElements();
		}

		protected function clickHandler( event:MouseEvent ):void
		{
			var target:IElement = event.target as IElement;
			if ( target )
			{
				event.stopPropagation();
				if ( _startItem == null )
				{
					_startItem = target;
					_startItem.selected = true;

					SoundManager.playClickItem();
				}
				else
				{
					_endItem = target;
					if ( _endItem == _startItem )
					{
						_startItem.selected = false;
						_startItem = null;

						SoundManager.playClickItem();
					}
					else if ( _startItem.mark != target.mark )
					{
						_startItem.selected = false;
						_endItem.selected = false;
						_startItem = null;
						_endItem = null;

						SoundManager.playClickError();
					}
					else
					{
						_endItem.selected = true;

						seek();
					}
				}
			}
		}

		///////////// seek

		private function seek():void
		{
			var tempVec1:Vector.<IElement> = _findPath.seek( _startItem, _endItem );
			// get short path
			if ( tempVec1 && tempVec1.length > 0 )
			{
				_dispelNumber++;
				setDrawLine( tempVec1 );
				checkGameProgress();
				checkAddScore();
				SoundManager.playLinkItem();

				moveElements();
			}
			else
			{
				_startItem.selected = false;
				_endItem.selected = false;
				SoundManager.playClickError();
			}
			_startItem = null;
			_endItem = null;
		}

		private function setDrawLine( tempVec1:Vector.<IElement> ):void
		{
			var tempVec2:Vector.<Point> = new Vector.<Point>();
			_moveIntervalTime = 0.05 * ( tempVec1.length );

			for each ( var item:IElement in tempVec1 )
				tempVec2.push( item.globalPoint );

			_drawPathLine.setPoints( tempVec2 );
			_startItem.removeFromParent( _moveIntervalTime );
			_endItem.removeFromParent( _moveIntervalTime );
		}

		private function checkGameProgress():void
		{
			_isOver = _dispelNumber >= HALF;
			if ( _isOver )
				dispatchEvent( new MainEvent( MainEvent.DISPEL_SUCCESS ));
			else
				dispatchEvent( new MainEvent( MainEvent.ADD_TIME, 1 ));
		}

		private function checkAddScore():void
		{
			// score
			var score:int = _levelVo.score;

			if ( getTimer() - _lastClickTime <= COMB_TIME_UNIT )
				_combNumber++;
			else
				_combNumber = 0;

			score += _combNumber * COMB_REWAR_SCORE_UNIT;
			EffectControl.instance.playCombWords( _combNumber );
			trace( "连击：" + _combNumber, "》》》》》增加分数：" + score );

			if ( _combNumber > 0 && _combNumber % 3 == 0 )
				TweenMax.delayedCall( 0.5, EffectControl.instance.playGoodWords );

			_lastClickTime = getTimer();
			dispatchEvent( new MainEvent( MainEvent.ADD_SCORE, score ));
		}

		private function moveElements():void
		{
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
				case DirectionType.DOWN_UP:
					moveDownUp();
					break;
				case DirectionType.LEFT_RIGHT:
					moveLeftRight();
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

		private function moveDown( startCol:int = 0, endCol:int = COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = ROWS - 1; row >= 0; row-- )
				{
					if ( num < ROWS )
					{
						element = _listAry[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = row; i > 0; i-- )
							{
								temp = _listAry[ i - 1 ][ col ];
								temp.rows = i;
								_listAry[ i ][ col ] = temp;
							}
							element.rows = 0;
							_listAry[ 0 ][ col ] = element;
							row++;
							num++;
						}
					}
				}
			}
		}

		private function moveUp( startCol:int = 0, endCol:int = COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			var end:int = ROWS - 1;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				num = 0;
				for ( var row:int = 0; row < ROWS; row++ )
				{
					if ( num < ROWS )
					{
						element = _listAry[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = row; i < end; i++ )
							{
								temp = _listAry[ i + 1 ][ col ];
								temp.rows = i;
								_listAry[ i ][ col ] = temp;
							}
							element.rows = end;
							_listAry[ end ][ col ] = element;
							row--;
							num++;
						}
					}
				}
			}
		}

		private function moveLeft( startRow:int = 0, endRow:int = ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = 0; col < COLS; col++ )
				{
					if ( num < COLS )
					{
						element = _listAry[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = col; i < COLS - 1; i++ )
							{
								temp = _listAry[ row ][ i + 1 ];
								temp.cols = i;
								_listAry[ row ][ i ] = temp;
							}
							element.cols = COLS - 1;
							_listAry[ row ][ COLS - 1 ] = element;
							col--;
							num++;
						}
					}
				}
			}
		}

		private function moveRight( startRow:int = 0, endRow:int = ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var num:int = 0;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				num = 0;
				for ( var col:int = COLS - 1; col >= 0; col-- )
				{
					if ( num < COLS )
					{
						element = _listAry[ row ][ col ];
						if ( element.isReal == false )
						{
							for ( var i:int = col; i > 0; i-- )
							{
								temp = _listAry[ row ][ i - 1 ];
								temp.cols = i;
								_listAry[ row ][ i ] = temp;
							}
							element.cols = 0
							_listAry[ row ][ 0 ] = element;
							col++;
							num++;
						}
					}
				}
			}
		}

		private function byUp( startRow:int = 0, endRow:int = ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var row:int = startRow; row < endRow; row++ )
			{
				isMove = true;
				for ( var col:int = 0; col < COLS; col++ )
				{
					element = _listAry[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && row < endRow - 1 )
				{
					for ( col = 0; col < COLS; col++ )
					{
						temp = _listAry[ row ][ col ];
						for ( var i:int = row + 1; i < endRow; i++ )
						{
							element = _listAry[ i ][ col ];
							element.rows = i - 1;
							_listAry[ i - 1 ][ col ] = element;
						}
						_listAry[ endRow - 1 ][ col ] = temp;
					}
				}
			}
		}

		private function byDown( startRow:int = 0, endRow:int = ROWS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var row:int = endRow - 1; row >= startRow; row-- )
			{
				isMove = true;
				for ( var col:int = 0; col < COLS; col++ )
				{
					element = _listAry[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && row > startRow )
				{
					for ( col = 0; col < COLS; col++ )
					{
						temp = _listAry[ row ][ col ];
						for ( var i:int = row - 1; i >= startRow; i-- )
						{
							element = _listAry[ i ][ col ];
							element.rows = i + 1;
							_listAry[ i + 1 ][ col ] = element;
						}
						_listAry[ 0 ][ col ] = temp;
					}
				}
			}
		}

		private function byLeft( startCol:int = 0, endCol:int = COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var col:int = startCol; col < endCol; col++ )
			{
				isMove = true;
				for ( var row:int = 0; row < ROWS; row++ )
				{
					element = _listAry[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && col < endCol - 1 )
				{
					for ( row = 0; row < ROWS; row++ )
					{
						temp = _listAry[ row ][ col ];
						for ( var i:int = col + 1; col < endCol - 1; i++ )
						{
							element = _listAry[ row ][ i ];
							element.cols = i - 1;
							_listAry[ row ][ i - 1 ] = element;
						}
						_listAry[ row ][ endCol - 1 ] = temp;
					}
				}
			}
		}

		private function byRight( startCol:int = 0, endCol:int = COLS ):void
		{
			var temp:IElement;
			var element:IElement;
			var isMove:Boolean = false;
			for ( var col:int = endCol - 1; col >= startCol; col-- )
			{
				isMove = true;
				for ( var row:int = 0; row < ROWS; row++ )
				{
					element = _listAry[ row ][ col ];
					if ( element.isReal )
					{
						isMove = false;
						break;
					}
				}
				if ( isMove && col > startCol )
				{
					for ( row = 0; row < ROWS; row++ )
					{
						temp = _listAry[ row ][ col ];
						for ( var i:int = col - 1; col > startCol; i-- )
						{
							element = _listAry[ row ][ i ];
							element.cols = i + 1;
							_listAry[ row ][ i + 1 ] = element;
						}
						_listAry[ row ][ 0 ] = temp;
					}
				}
			}
		}

		private function moveDownUp():void
		{
			moveUp( 0, int( COLS >> 1 ))
			moveDown( int( COLS >> 1 ), COLS );
		}

		private function moveLeftRight():void
		{
			moveLeft( 0, int( ROWS >> 1 ));
			moveRight( int( ROWS >> 1 ), ROWS );
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

		private function moveRowOrCol():void
		{
			var element:IElement;
			for ( var row:int = 0; row < ROWS; row++ )
			{
				for ( var col:int = 0; col < COLS; col++ )
				{
					element = _listAry[ row ][ col ];
					element.refresh();
					element.tween( _moveIntervalTime );
				}
			}
		}

		///***************

		public function get direction():uint
		{
			return _levelVo.direction;
		}


	}
}
