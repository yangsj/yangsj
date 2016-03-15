package net.victor.code.loader
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	/**
	 * 加载完成 
	 */	
	[Event(name="load_item_event_complete", type="seeegg.com.loader.LoadItemEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	public class LoadItem extends EventDispatcher
	{
		
		private static var _itemIndex:int = 0;
		
		private var _url:String = "";
		private var _type:String = "";
		
		private var _loadData:LoadData;
		private var _bytesLoaded:uint = 0;
		private var _bytesTotal:uint = 0;
		
		private var _index:int = 0;
		
		private var _loaderContext:LoaderContext;
		public function LoadItem()
		{
			_index = ++ _itemIndex;
		}
		
		public function get loaderContext():LoaderContext
		{
			return _loaderContext;
		}

		public function set loaderContext(value:LoaderContext):void
		{
			_loaderContext = value;
		}

		public function get index():int
		{
			return _index;
		}
		
		public function get bytesLoaded():uint
		{
			return _bytesLoaded
		}
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		public function get loadData():LoadData
		{
			return _loadData;
		}
		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		public function startLoad():void
		{
			toLoad();
		}
		
		private function toLoad():void
		{
			var urlreq:URLRequest = new URLRequest(this.url);
			if(null == _loaderContext)
			{
				_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			}
			switch(this.type)
			{
				case LoadType.BINARY:
					var uloader:URLLoader = new URLLoader();
					uloader.dataFormat = URLLoaderDataFormat.BINARY;
					addLoadEvents(uloader);
					uloader.load(urlreq);
					break;
				case LoadType.SWF:
				case LoadType.IMAGE:
					var imgloader:Loader = new Loader();
					addLoadEvents(imgloader.contentLoaderInfo);
					imgloader.load(urlreq, _loaderContext);
					break;
				case LoadType.XML:
					var xloader:URLLoader = new URLLoader();
					addLoadEvents(xloader);
					xloader.load(urlreq);
					break;
			}
		}
		
		private function addLoadEvents(loadDispatcher:EventDispatcher):void
		{
			loadDispatcher.addEventListener(Event.COMPLETE, onComplete);
			loadDispatcher.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loadDispatcher.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loadDispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
		}
		
		private function removeLoadEvents(loadDispatcher:EventDispatcher):void
		{
			loadDispatcher.removeEventListener(Event.COMPLETE, onComplete);
			loadDispatcher.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loadDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loadDispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
		}
		
		private function onComplete(e:Event):void
		{
			this._loadData = new LoadData();
			this._loadData.bytesTotal = this.bytesTotal;
			this._loadData.type = this.type;
			this._loadData.url = this.url;
			
			var urlloader:URLLoader = e.target as URLLoader;
			if(urlloader)
			{
				this._loadData.data = urlloader.data
			}
			var loaderinfo:LoaderInfo = e.target as LoaderInfo;
			if(loaderinfo)
			{
				this._loadData.data = loaderinfo.content;
				this._loadData.loader = loaderinfo.loader;
				if(loaderinfo.content is Bitmap)
				{
					this._loadData.bitmap = loaderinfo.content as Bitmap;
				}
			}
			
			var loadItemEvt:LoadItemEvent = new LoadItemEvent(LoadItemEvent.LOAD_ITEM_EVENT_COMPLETE);
			loadItemEvt.loadData = this.loadData;
			this.dispatchEvent(loadItemEvt);
			
			removeLoadEvents(e.currentTarget as EventDispatcher);
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			this._bytesLoaded = e.bytesLoaded;
			this._bytesTotal = e.bytesTotal;
			this.dispatchEvent(e);
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			
		}
		
		private function onHttpStatus(e:HTTPStatusEvent):void
		{
			
		}
	}
}