package app.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import victor.framework.utils.BitmapUtil;
	import victor.framework.utils.DisplayUtil;
	import app.utils.safetyCall;

	/**
	 * ……
	 * @author yangsj
	 */
	public class Image extends Sprite
	{
		private static var _pool:Dictionary = new Dictionary();

		private const defaultUrl:String = "image_defaultUrl";

		private var _onCompleteCall:Function;
		private var _onErrorCall:Function;
		private var _url:String;

		private var _loader:Loader;
		private var _bitmap:Bitmap;
		private var _bitmapWidth:Number = 0;
		private var _bitmapHeight:Number = 0;
		private var _loadResult:Boolean = true; // 加载结果（是否正确加载）


		public function Image( url:String, onComplete:Function = null, onError:Function = null )
		{
			reset( url, onComplete, onError );
		}

///////////////////////// public functions 

		public function reset( url:String, onComplete:Function = null, onError:Function = null ):void
		{
			_url = url;
			_onCompleteCall = onComplete;
			_onErrorCall = onError;

			var img:BitmapData = _pool[ url ] as BitmapData;
			if ( img )
			{
				// 若已存储的BitmapData已经调用dispose方法后将重新加载
				try
				{
					if ( img.width > 0 )
					{
						setBitmapdata( img );
					}
					else
					{
						startLoading();
					}
				}
				catch ( e:ArgumentError )
				{
					startLoading();
				}
				catch ( e:Error )
				{
					trace( "warning:被销毁的位图资源重新加载！" );
				}
				addedToParant();
			}
			else
			{
				startLoading();
			}
		}

		public function setPosXY( x:Number, y:Number ):void
		{
			this.x = x;
			this.y = y;
		}

		public function setSize( width:Number, height:Number ):void
		{
			_bitmapWidth = width;
			_bitmapHeight = height;
			setBitmapSize();
		}

		public function clear():void
		{
			clearLoader();
			_onCompleteCall = null;
			_onErrorCall = null;
			_bitmap = null;
			_url = "";
		}

		public function dispose():void
		{
			clear();
			DisplayUtil.removedAll( this );
		}

/////////////////////////// private functions 

		private function addedToParant():void
		{
			if ( parent )
			{
				addedToStageHandler( null );
			}
			else
			{
				addEventListener( Event.ADDED, addedToStageHandler );
			}
		}

		private function setBitmapdata( bitmapdata:BitmapData ):void
		{
			try
			{
				DisplayUtil.removedFromParent( _bitmap );
				_bitmap = new Bitmap( bitmapdata, "auto", true );
				addChild( _bitmap );
			}
			catch ( e:Error )
			{
				trace( "Image中setBitmapdata函数创建位图资源失败！" );
			}
			setBitmapSize();
		}

		private function setBitmapSize():void
		{
			if ( _bitmap && _bitmapWidth > 0 && _bitmapHeight > 0 )
			{
				var scale:Number = Math.min( _bitmapWidth / _bitmap.width, _bitmapHeight / _bitmap.height );
				_bitmap.scaleX = _bitmap.scaleY = scale;
				_bitmap.x = ( _bitmapWidth - _bitmap.width ) * 0.5;
				_bitmap.y = ( _bitmapHeight - _bitmap.height ) * 0.5;
			}
		}

		private function clearLoader():void
		{
			if ( _loader )
			{
				_loader.unload();
				_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadedComplete );
				_loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onLoadedError );
				_loader = null;
			}
		}

		private function startLoading():void
		{
//			YLogger.printImgInfoProgress( "开始加载：" + _url + "____________________________start" );
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadedComplete );
			_loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onLoadedError );
			try
			{
				_loader.load( new URLRequest( _url ));
			}
			catch ( e:Error )
			{
				trace( "Image加载startLoading函数加载器报错！" );
			}
		}

//////////////////// events handlers functions

		protected function onLoadedComplete( event:Event ):void
		{
//			YLogger.printImgInfoProgress( "结束加载：" + _url + "____________________________end" );
			var bitmapdata:BitmapData;
			var loadContent:DisplayObject = event.target.content;
			if ( loadContent is Bitmap )
			{
				bitmapdata = ( loadContent as Bitmap ).bitmapData;
			}
			else
			{
				try
				{
					bitmapdata = BitmapUtil.cloneBitmapFromTarget( loadContent ).bitmapData;
				}
				catch ( e:Error )
				{
					trace( "Image资源加载完成创建位图资源出错！" );
				}
			}
			_loadResult = true;
			setBitmapdata( bitmapdata );
			_pool[ _url ] = bitmapdata;
			addedToParant();
		}

		protected function onLoadedError( event:IOErrorEvent ):void
		{
			try
			{
				var bitmapdata:BitmapData = _pool[ defaultUrl ];
				if ( bitmapdata )
				{
					_pool[ _url ] = bitmapdata;
				}
				else
				{
					_pool[ defaultUrl ] = _pool[ _url ] = bitmapdata = new BitmapData( 5, 5, true, 0 );
				}
				setBitmapdata( bitmapdata );
			}
			catch ( e:Error )
			{
				trace( "Image加载资源Error函数创建默认位图错误！" );
			}

			trace( "加载：[" + _url + "]失败!" );
			_loadResult = false;
			addedToParant();
		}

		protected function addedToStageHandler( event:Event ):void
		{
			removeEventListener( Event.ADDED, addedToStageHandler );
			safetyCall( _loadResult ? _onCompleteCall : _onErrorCall, this );
			clear();
		}

	}
}
