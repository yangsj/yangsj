package loaders
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	
	/**
	 * 说明：LoaderManager
	 * @author Victor
	 * 2012-10-26
	 */
	
	public class LoaderManager extends EventDispatcher
	{
		
		public var list:Array = [];
		public var context:LoaderContext;
		public var items:Dictionary = new Dictionary();
		
		private var total:int = 0;
		private var current:int = 0;
		private var itemProgress:Number;
		private var loader:Loader;
		private var lastProgress:Number = -1;
		
		public function LoaderManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function add(url:String):void
		{
			list.push(url);
		}
		
		public function start():void
		{
			total = list.length;
			itemProgress = 1 / total;
			
			beginItem();
		}
		
		public function dispose():void
		{
			if (loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			}
			list = null;
			items = null;
			context = null;
		}
		
		private function beginItem():void
		{
			current++;
			
			if (current > total)
			{
				// complete
				if (loader)
				{
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
					loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				}
				this.dispatchEvent(new Event(Event.COMPLETE));
				return ;
			}
			var urlString:String = list[current - 1] as String;
			trace("加载第" + current + "个资源   地址=" + urlString);
			try
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
				loader.load(new URLRequest(urlString), context);
			}
			catch ( e:* )
			{
				
			}
			
		}
		
		protected function progressHandler(event:ProgressEvent):void
		{
			var progress:Number = event.bytesLoaded / event.bytesTotal;
			progress = itemProgress * progress;
			progress = int((((current - 1) / total) + progress) * 100);
			
			if (lastProgress != progress)
			{
				lastProgress = progress;
				var evt:LoaderProgressEvent = new LoaderProgressEvent(LoaderProgressEvent.PROGRESS);
				evt.current = progress;
				this.dispatchEvent(evt);
			}
		}
		
		protected function completeHandler(event:Event):void
		{
			var urlString:String = list[current - 1] as String;
			items[urlString] = event.target.content as DisplayObject;
			beginItem();
		}		
		
		
		
	}
	
}