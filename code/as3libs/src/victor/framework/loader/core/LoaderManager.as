package victor.framework.loader.core
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import victor.framework.loader.events.LoaderEvent;
	import victor.framework.loader.events.LoaderProgressEvent;


	[Event(name="loader_event_start", type="victor.framework.loader.events.LoaderEvent")]
	[Event(name="loader_event_complete", type="victor.framework.loader.events.LoaderEvent")]
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class LoaderManager extends EventDispatcher implements ILoaderManager
	{
		private static var dict:Dictionary = new Dictionary();

		private var list:Vector.<LoaderListItemData>;

		private var numTotal:int = 0;
		private var numCurrent:int = 0;
		private var currentItemData:LoaderListItemData;

		public var loaderContext:LoaderContext;

		public function LoaderManager()
		{
			list = new Vector.<LoaderListItemData>();
			loaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
		}

		public function setUrls( list:Vector.<LoaderListItemData> ):void
		{
			this.list.concat( list );
		}

		public function addUrl( url:String, type:String, name:String = "" ):void
		{
			list.push( new LoaderListItemData( url, type, name ));
		}

		public function getTargetByUrlOrName( urlOrName:String ):*
		{
			return dict[ urlOrName ];
		}

		public function startLoad():void
		{
			numCurrent = 0;
			numTotal = list.length;

			dispatchEvent( new LoaderEvent( LoaderEvent.START ));

			loadItem();
		}

		private function loadItem():void
		{
			if ( list && list.length > 0 )
			{
				var itemData:LoaderListItemData;
				while ( itemData == null )
				{
					itemData = list.shift();
					numCurrent++;
				}
				currentItemData = itemData;
				if ( itemData )
				{
					if ( dict[ itemData.name ] || dict[ itemData.url ])
					{
						loadItem();
						return;
					}
					var urlRequest:URLRequest = new URLRequest( itemData.url );
					switch ( itemData.type )
					{
						case LoaderType.SWF:
							createLoader( urlRequest );
							break;
						case LoaderType.XML:
							createURLLoader( urlRequest );
							break;
						case LoaderType.IMAGE:
							createLoader( urlRequest );
							break;
						case LoaderType.TEXT:
							createURLLoader( urlRequest );
							break;
						default:
							createLoader( urlRequest );
					}
				}
			}
			else
			{
				onAllComplete();
			}
		}

		private function onAllComplete():void
		{
			dispatchEvent( new LoaderEvent( LoaderEvent.COMPLETE ));
		}

		private function createLoader( urlRequest:URLRequest ):void
		{
			var loader:Loader = new Loader();
			addEvents( loader.contentLoaderInfo );
			loader.load( urlRequest, loaderContext );
		}

		private function createURLLoader( urlRequest:URLRequest ):void
		{
			var urlLoader:URLLoader = new URLLoader();
			addEvents( urlLoader );
			urlLoader.load( urlRequest );
		}

		private function addEvents( loaderTarget:IEventDispatcher ):void
		{
			loaderTarget.addEventListener( Event.COMPLETE, onItemLoadedComlete );
			loaderTarget.addEventListener( ProgressEvent.PROGRESS, itemLoadedProgress );
			loaderTarget.addEventListener( IOErrorEvent.IO_ERROR, onItemLoadedError );
		}

		private function removeEvents( loaderTarget:IEventDispatcher ):void
		{
			loaderTarget.removeEventListener( Event.COMPLETE, onItemLoadedComlete );
			loaderTarget.removeEventListener( ProgressEvent.PROGRESS, itemLoadedProgress );
			loaderTarget.removeEventListener( IOErrorEvent.IO_ERROR, onItemLoadedError );
		}

		private function onItemLoadedComlete( event:Event ):void
		{
			if ( currentItemData )
			{
				var type:String = currentItemData.type;
				var url:String = currentItemData.url;
				var resName:String = currentItemData.name;
				if ( type == LoaderType.TEXT || type == LoaderType.XML )
				{
					if ( url )
						dict[ url ] = ( event.target as URLLoader ).data;
					if ( resName )
						dict[ resName ] = ( event.target as URLLoader ).data;
				}
				else
				{
					if ( url )
						dict[ url ] = ( event.target.content as DisplayObject );
					if ( resName )
						dict[ resName ] = ( event.target.content as DisplayObject );
				}
			}
			currentItemData = null;
			loadItem();
		}

		private function onItemLoadedError( event:IOErrorEvent ):void
		{
			dispatchEvent( event );
		}

		private function itemLoadedProgress( event:ProgressEvent ):void
		{
			//
			var single:Number = ( 100 / numTotal );
			var percent:Number = event.bytesLoaded / event.bytesTotal;
			percent = single * ( numCurrent - 1 + percent );

			var loaderProgressEvent:LoaderProgressEvent = new LoaderProgressEvent( LoaderProgressEvent.PROGRESS );
			loaderProgressEvent.numLoaded = numCurrent;
			loaderProgressEvent.numTotal = numTotal;
			loaderProgressEvent.progressLoaded = percent;
			loaderProgressEvent.progressTotal = 100;

			dispatchEvent( loaderProgressEvent );
		}




	}
}
