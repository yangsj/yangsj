package app.managers
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import victor.framework.utils.ArrayUtil;
	import app.utils.safetyCall;
	import app.utils.log;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-27
	 */
	public class LoaderManager
	{
		private static var _instance:LoaderManager;

		public static function get instance():LoaderManager
		{
			return _instance ||= new LoaderManager;
		}

		///////////////////////////////////////////////////////

		private static const dictResLoaded:Dictionary = new Dictionary();
		private static const dictResList:Dictionary = new Dictionary();
		private static const dictContext:Dictionary = new Dictionary();
		private static const loginLoad:Array = [];

		private static const context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );

		///////////////////////////////////////////////////////

		public function LoaderManager()
		{
		}

		public function setApplicationConfig( applicationXml:XML ):void
		{
			var xmllist:XMLList = applicationXml.children();
			for each ( var xml:XML in xmllist )
			{
				var name:String = String( xml.@name );
				var url:String = String( xml.@url );
				var version:String = String( xml.@version );
				var path:String = Global.serverURL + url + "?t=" + version;
				dictResList[ name ] = path;
				if ( int( xml.@first ) == 1 )
				{
					loginLoad.push( name );
				}
				log( name + ":" + path );
			}
		}

		public function startLoadLogin( completeCallBack:Function = null, progressCallBack:Function = null ):void
		{
			load( loginLoad, completeCallBack, progressCallBack );
		}

		public function load( resNameAry:Array, completeCallBack:Function = null, progressCallBack:Function = null ):void
		{
			var ary:Array = ArrayUtil.cloneArray( resNameAry );
			var totalNum:int = ary.length;
			var loadNum:int = 0;
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, errorHandler );
			
			loadItem();

			function loadItem():void
			{
				if ( ary.length > 0 )
				{
					try
					{
						var name:String = ary.shift();
						if ( dictResLoaded[ name ])
						{
							loadItem();
						}
						else
						{
							var url:String = dictResList[ name ];
							dictResLoaded[ name ] = url;
							loader.load( new URLRequest( url ), context );
						}
					}
					catch ( e:* )
					{
						completeHandler( null );
					}
				}
				else
				{
					safetyCall( completeCallBack );
					loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, completeHandler );
					loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, progressHandler );
					loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, errorHandler );
					loader = null;
				}
			}

			function completeHandler( event:Event ):void
			{
				loadNum++;
				loadItem();
			}

			function progressHandler( event:ProgressEvent ):void
			{
				var perent:Number = event.bytesLoaded / event.bytesTotal;
				perent = perent * ( 1 / totalNum ) + ( loadNum / totalNum );
				safetyCall( progressCallBack, perent );
			}

			function errorHandler( event:IOErrorEvent ):void
			{
				completeHandler( null );
			}
		}
		
		public function getObj( linkName:String, resName:String = "" ):Object
		{
			try
			{
				return new ( getClass( linkName, resName ))();
			}
			catch ( e:Error )
			{
			}
			return null;
		}
		
		public function getClass( linkName:String, resName:String = "" ):Class
		{
			try
			{
				if ( resName == "")
					return getDefinitionByName( linkName ) as Class;
				else
				{
					
				}
			}
			catch ( e:Error )
			{
			}
			return null;
		}

	}
}
