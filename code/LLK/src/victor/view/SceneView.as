package victor.view
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import victor.core.IItem;
	import victor.view.res.Item;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class SceneView extends Sprite
	{
		private const cols:int = 10;
		private const rows:int = 15;

		// item 列表显示容器
		private var _listContainer:Sprite;
		// 路径线显示容器
		private var _lineContainer:Sprite;

		private var markList:Vector.<int>;

		private var listAry:Vector.<Vector.<IItem>>;
		private var markAry:Vector.<int>;

		private var startItem:IItem;
		private var endItem:IItem;

		public function SceneView()
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
		}

		private function randomMarkList():void
		{
			markAry.sort( abc );
			function abc( a:int, b:int ):Number
			{
				return int( Math.random() * 3 ) - 1;
			}
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
					if ( startItem.mark != target.mark )
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


		///////////// seek

		private function seek():void
		{
			var s_cols:int = startItem.cols;
			var s_rows:int = startItem.rows;
			var e_cols:int = endItem.cols;
			var e_rows:int = endItem.rows;
			if (( Math.abs( s_cols - e_cols ) == 1 && s_rows == e_rows ) || ( Math.abs( s_rows - e_rows ) == 1 && s_cols == e_cols ))
			{
				// 相邻
				var vec:Vector.<Point> = new Vector.<Point>();
				vec.push( startItem.globalPoint );
				vec.push( endItem.globalPoint );
				drawLine( vec );
				startItem.removeFromParent();
				endItem.removeFromParent();
			}
			else
			{
				// 在左边(包含当前列
				if ( s_rows - e_rows >= 0)
				{
					if (s_cols - e_cols >= 0)//在上边（包含当前行）
					{
						
					}
					else
					{
						
					}
				}
				else 
				{
					if (s_cols - e_cols >= 0)//在上边（包含当前行）
					{
						
					}
					else
					{
						
					}
				}
				
				var isLeft:Boolean = s_rows - e_rows >= 0;
				var isRight:Boolean = !isLeft;
				var isUP:Boolean = s_cols - e_cols >= 0;
				var isDown:Boolean = !isUP;
				var isCols:Boolean = s_cols - e_cols == 0;// 同列
				var isRows:Boolean = s_rows - e_rows == 0;// 同行
				
				//向上
//				if 
				
				
			}
		}

		private function drawLine( points:Vector.<Point> ):void
		{
			if ( points && points.length > 1 )
			{
				var point:Point = points.shift();
				_lineContainer.graphics.lineStyle( 2, 0xff0000 );
				_lineContainer.graphics.moveTo( point.x, point.y );
				for each ( point in points )
				{
					_lineContainer.graphics.lineTo( point.x, point.y );
				}
				TweenMax.delayedCall( 0.5, clearLine );
			}
			_listContainer.mouseChildren = false;
		}

		private function clearLine():void
		{
			_lineContainer.graphics.clear();
			_listContainer.mouseChildren = true;
		}



	}
}
