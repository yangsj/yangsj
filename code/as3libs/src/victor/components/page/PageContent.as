package victor.components.page
{

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	import victor.utils.DisplayUtil;


	/**
	 * ……
	 * @author yangsj
	 */
	public class PageContent extends Sprite implements IPageContent
	{
		private const TYPE_NULL:int = 0;
		private const TYPE_PREV:int = 1;
		private const TYPE_NEXT:int = 2;

		protected var _pages:IPages;
		protected var _items:Array;
		protected var _btnPrev:MovieClip;
		protected var _btnNext:MovieClip;
		protected var _txtFlip:TextField;
		protected var _showRect:Rectangle;
		protected var _isLoop:Boolean = false;
		protected var _isRefresh:Boolean = false;
		protected var _typePage:int;
		protected var _currList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		private var _lastList:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		public function PageContent( showRect:Rectangle, pageSize:int = 8, isLoop:Boolean = false )
		{
			_showRect = showRect;
			_isLoop = isLoop;
			_pages = new Pages( pageSize );
			_pages.isLoop = _isLoop;

			graphics.beginFill( 0, 0 );
			graphics.drawRect( 0, 0, showRect.width, showRect.height );
			graphics.endFill();

			scrollRect = showRect;
		}

//////////////////////

		protected function gotoCurr():void
		{
			_typePage = TYPE_NULL;
			setPageList( _pages.curPage );
		}

		protected function gotoPrev():void
		{
			_typePage = TYPE_PREV;
			setPageList( _pages.prevPage );
		}

		protected function gotoNext():void
		{
			_typePage = TYPE_NEXT;
			setPageList( _pages.nextPage );
		}

		protected function beforeCreate():void
		{
			if ( _isRefresh )
			{
				removeAll();
			}
			else
			{
				_lastList = _currList.splice( 0, _currList.length );
			}
		}

		protected function createList( array:Array ):void
		{
		}

		protected function afterCreate():void
		{
			removeArray( _lastList );
		}

		protected function setBtnStatus():void
		{
			if ( _pages.isLoop == false )
			{
				if ( _btnPrev )
				{
					_btnPrev.gotoAndStop( _pages.isFirstPage ? 2 : 1 );
					_btnPrev.mouseChildren = false;
					_btnPrev.mouseEnabled = !_pages.isFirstPage;
				}
				if ( _btnNext )
				{
					_btnNext.gotoAndStop( _pages.isLastPage ? 2 : 1 );
					_btnNext.mouseChildren = false;
					_btnNext.mouseEnabled = !_pages.isLastPage;
				}
			}
			if ( _txtFlip )
			{
				_txtFlip.text = _pages.pageStr;
			}
		}

////////////////////// private functions 

		private function setPageList( array:Array ):void
		{
			beforeCreate();
			createList( array );
			afterCreate();
			setBtnStatus();
			_isRefresh = false;
		}

		private function removeAll():void
		{
			removeArray( _lastList );
			removeArray( _currList );
		}

		private function removeArray( array:Vector.<DisplayObject> ):void
		{
			if ( array )
			{
				while ( array.length > 0 )
				{
					DisplayUtil.removedFromParent( array.pop());
				}
			}
		}

		private function removeEvent():void
		{
			if ( _btnPrev )
				_btnPrev.removeEventListener( MouseEvent.CLICK, btnPrevHandler );
			if ( _btnNext )
				_btnNext.removeEventListener( MouseEvent.CLICK, btnNextHandler );
		}

		private function addEvent():void
		{
			if ( _btnPrev )
				_btnPrev.addEventListener( MouseEvent.CLICK, btnPrevHandler );
			if ( _btnNext )
				_btnNext.addEventListener( MouseEvent.CLICK, btnNextHandler );
		}

		protected function btnPrevHandler( event:MouseEvent ):void
		{
			gotoPrev();
		}

		protected function btnNextHandler( event:MouseEvent ):void
		{
			gotoNext();
		}

////////////////////// public functions 

		public function dispose():void
		{
			removeAll();
			removeEvent();
			if ( _pages )
			{
				_pages.dispose();
			}
			_pages = null;
			_items = null;
			_btnPrev = null;
			_btnNext = null;
			_txtFlip = null;
			_showRect = null;
			_currList = null;
			_lastList = null;
		}

		public function initialize():void
		{
			addEvent();
			gotoCurr();
		}

		public function refresh():void
		{
			_isRefresh = true;
			gotoCurr();
		}

		public function reset():void
		{
			_pages.curPageNo = 1;
		}

//////////////////// getters/setters 

		public function get items():Array
		{
			return _items;
		}

		public function set items( value:Array ):void
		{
			_items = value;
			_pages.items = value;
		}

		public function set btnPrev( value:MovieClip ):void
		{
			_btnPrev = value;
		}

		public function set btnNext( value:MovieClip ):void
		{
			_btnNext = value;
		}

		public function set txtFlip( txt:TextField ):void
		{
			_txtFlip = txt;
		}
	}
}
