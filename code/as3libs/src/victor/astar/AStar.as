package victor.astar
{
	import flash.utils.getTimer;

	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-20
	 */
	public class AStar
	{
		private var mapAry:Vector.<Vector.<AStarItem>>;
		private var openAry:Vector.<AStarItem>;
		private var closeAry:Vector.<AStarItem>;
		private var startPos:AStarPoint;
		private var endPos:AStarPoint;
		private var lengx:int;
		private var lengy:int;
		private var curItem:AStarItem;
		private var endItem:AStarItem;
		private var searchTime:int = 0;

		public function AStar()
		{
		}

		public function initVars( initAry:Array ):void
		{
			var x:int = 0;
			var y:int = 0;
			mapAry = new Vector.<Vector.<AStarItem>>();
			lengy = initAry.length;
			for each ( var ary:Array in initAry )
			{
				var vec:Vector.<AStarItem> = new Vector.<AStarItem>();
				for each ( var val:int in ary )
				{
					var item:AStarItem = new AStarItem();
					item.isBlock = val == 0;
					item.isCan = val != 0;
					item.x = x++;
					item.y = y;
					vec.push( item );
				}
				lengx = x;
				x = 0;
				y++;
				mapAry.push( vec );
			}
		}

		public function find( startPos:AStarPoint, endPos:AStarPoint ):Vector.<AStarPoint>
		{
			searchTime = 0;
			initSets();
			var item:AStarItem = mapAry[ startPos.y ][ startPos.x ];
			this.startPos = startPos;
			this.endPos = endPos;
			openAry.push( item );
			loop();
			return getResult();
		}

		private function loop():void
		{
			var item:AStarItem = openAry.shift();
			while ( item && toFind( item.x, item.y ) == false )
			{
				item = openAry.pop();
			}
		}

		private function toFind( x:int, y:int ):Boolean
		{
			var item:AStarItem = mapAry[ y ][ x ];
			curItem = item;
			closeAry.push( item );
			if ( closeAry.length == 1 )
			{
				item.isStart = true;
				item.parentNode = null;
			}
			return check( item );
		}

		private function check( item:AStarItem ):Boolean
		{
			var itemx:int = item.x;
			var itemy:int = item.y;
			var x:int, y:int;

			var canLeft:Boolean;
			var canRight:Boolean;
			var canUp:Boolean;
			var canDown:Boolean;

			// 中左
			x = itemx - 1;
			y = itemy;
			item = getAStarItem( x, y );
			canLeft = item && item.isCan;
			if ( addToOpenAry( item, 10 ))
				return true;

			// 中右
			x = itemx + 1;
			item = getAStarItem( x, y );
			canRight = item && item.isCan;
			if ( addToOpenAry( item, 10 ))
				return true;

			// 中上
			x = itemx;
			y = itemy - 1;
			item = getAStarItem( x, y );
			canUp = item && item.isCan;
			if ( addToOpenAry( item, 10 ))
				return true;

			// 中下
			y = itemy + 1;
			item = getAStarItem( x, y );
			canDown = item && item.isCan;
			if ( addToOpenAry( item, 10 ))
				return true;

			// 左上
			x = itemx - 1;
			if ( canLeft && canUp )
			{
				y = itemy - 1;
				item = getAStarItem( x, y );
				if ( addToOpenAry( item, 14 ))
					return true;
			}

			// 左下
			if ( canLeft && canDown )
			{
				y = itemy + 1;
				item = getAStarItem( x, y );
				if ( addToOpenAry( item, 14 ))
					return true;
			}

			x = itemx + 1;
			// 右上
			if ( canRight && canUp )
			{
				y = itemy - 1;
				item = getAStarItem( x, y );
				if ( addToOpenAry( item, 14 ))
					return true;
			}

			// 右下
			if ( canRight && canDown )
			{
				y = itemy + 1;
				item = getAStarItem( x, y );
				if ( addToOpenAry( item, 14 ))
					return true;
			}

			var time:Number = getTimer();
			var str:String = "";
//			if ( isSort )
//			{
//				str = "loop";
				openAryMinToFrist();
//			}
//			else
//			{
//				str = "sort";
//				openAry.sort( openArySort );
//			}
			trace( str + "-------------------------耗时：" + ( getTimer() - time ) + "   " + openAry.length );
			return openAry.length == 0;

		}

		public var isSort:Boolean = true;

		private function openAryMinToFrist():void
		{
			var length:int = openAry.length;
			var a:AStarItem;
			var b:AStarItem;
			if ( length > 2 )
			{
				for ( var i:int = 1; i < length; i++ )
				{
					a = openAry[ i ];
					b = openAry[ i - 1 ];
					if ( a.f > b.f )
					{
						openAry[ i ] = b;
						openAry[ i - 1 ] = a;
					}
				}
			}
			else if ( length == 2 )
			{
				a = openAry[ 0 ];
				b = openAry[ 1 ];
				if ( a.f > b.f )
				{
					openAry[ 0 ] = b;
					openAry[ 1 ] = a;
				}
			}
		}

		private function openArySort( a:AStarItem, b:AStarItem ):Number
		{
			if ( a.f > b.f )
				return -1;
			else if ( a.f < b.f )
				return 1;
			return 0;
		}

		private function getAStarItem( x:int, y:int ):AStarItem
		{
			if ( x >= 0 && x < lengx && y >= 0 && y < lengy )
			{
				return mapAry[ y ][ x ];
			}
			return null;
		}

		private function addToOpenAry( item:AStarItem, g:int ):Boolean
		{
			if ( item && item.isCan && !checkInCloseAry( item ) && !checkInOpenAry( item ))
			{
				trace( "搜索" + ++searchTime + "次  : " + item.x + " | " + item.y );

				var endx:int = endPos.x;
				var endy:int = endPos.y;
				var h:int = 10 * ( Math.abs( endx - item.x ) + Math.abs( endy - item.y ));
				var temp_g:int = curItem.g + g;
				var temp_f:int = temp_g + h;

				if ( item.parentNode == null || temp_f < item.f )
				{
					item.h = h;
					item.g = temp_g;
					item.f = temp_f;
					item.parentNode = curItem;
				}
				if ( h == 0 )
				{
					item.isEnd = true;
					endItem = item;
					return true;
				}
				openAry.push( item );
			}
			return false;
		}

		/**
		 * 是否已经存在打开列表中
		 * @param item
		 * @return true存在，false不存在
		 */
		private function checkInOpenAry( item:AStarItem ):Boolean
		{
			for each ( var it:AStarItem in openAry )
			{
				if ( it.x == item.x && it.y == item.y )
				{
					return true;
				}
			}
			return false;
		}

		/**
		 * 是否已经存在关闭列表中
		 * @param item
		 * @return
		 */
		private function checkInCloseAry( item:AStarItem ):Boolean
		{
			for each ( var it:AStarItem in closeAry )
			{
				if ( it.x == item.x && it.y == item.y )
				{
					return true;
				}
			}
			return false;
		}

		private function getResult():Vector.<AStarPoint>
		{
			var vec:Vector.<AStarPoint> = new Vector.<AStarPoint>();
			if ( endItem )
			{
				vec.push( new AStarPoint( endItem.x, endItem.y ));
				var item:AStarItem = endItem.parentNode;
				while ( item )
				{
					vec.push( new AStarPoint( item.x, item.y ));
					item = item.parentNode;
				}
			}
			return vec;
		}

		private function initSets():void
		{
			dispose();
			openAry = new Vector.<AStarItem>();
			closeAry = new Vector.<AStarItem>();
		}

		private function dispose():void
		{
			openAry = null;
			closeAry = null;
			endItem = null;
			curItem = null;
			endPos = null;
		}


	}
}
