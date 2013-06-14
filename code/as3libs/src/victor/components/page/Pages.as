package victor.components.page
{

	/**
	 * ……
	 * @author yangsj
	 */
	public class Pages implements IPages
	{
		private var _curPageNo:int = 1;
		private var _totalPageNo:int = 1;
		private var _pageSize:int = 1;
		private var _totalSize:int = 1;
		private var _items:Array = [];
		private var _isLoop:Boolean = false;

		public function Pages( pageSize:int = 8 )
		{
			_pageSize = pageSize;
		}

		public function dispose():void
		{
			_items = null;
		}

		public function set items( value:Array ):void
		{
			_items = value;
			_totalSize = value.length;
			_totalPageNo = _totalSize % _pageSize == 0 ? ( _totalSize / _pageSize ) : int( _totalSize / _pageSize ) + 1;
			_totalPageNo = Math.max( 1, _totalPageNo );
		}

		public function get curPage():Array
		{
			_curPageNo = Math.min( _curPageNo, _totalPageNo );
			_curPageNo = Math.max( _curPageNo, 1 );
			return getPage( _curPageNo - 1 );
		}

		public function get prevPage():Array
		{
			_curPageNo--;
			if ( _isLoop )
			{
				_curPageNo = _curPageNo < 1 ? _totalPageNo : _curPageNo;
			}
			return curPage;
		}

		public function get nextPage():Array
		{
			_curPageNo++;
			if ( _isLoop )
			{
				_curPageNo = _curPageNo > _totalPageNo ? 1 : _curPageNo;
			}
			return curPage;
		}

		public function get pageStr():String
		{
			return _curPageNo + "/" + _totalPageNo;
		}

		public function get curPageNo():int
		{
			return _curPageNo;
		}

		public function set curPageNo( value:int ):void
		{
			_curPageNo = value;
		}

		public function get totalPageNo():int
		{
			return _totalPageNo;
		}

		public function get isFirstPage():Boolean
		{
			return _curPageNo == 1;
		}

		public function get isLastPage():Boolean
		{
			return _curPageNo == _totalPageNo;
		}

		public function get pageSize():int
		{
			return _pageSize;
		}

		public function get isLoop():Boolean
		{
			return _isLoop;
		}

		public function set isLoop( value:Boolean ):void
		{
			_isLoop = value;
		}

		private function getPage( index:int ):Array
		{
			index = Math.max( index, 0 );
			index = Math.min( index * _pageSize, _totalSize );
			var endIndex:int = Math.min( _totalSize, index + _pageSize );
			var array:Array = [];
			for ( var i:int = index; i < endIndex; i++ )
			{
				array.push( _items[ i ]);
			}
			return array;
		}


	}
}
