package net.victor.code.loader
{
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.system.LoaderContext;

	[Event(name="load_batch_event_complete", type="seeegg.com.loader.LoadBatchEvent")]
	
	[Event(name = "load_batch_event_progress", type="seeegg.com.loader.LoadBatchEvent")]
	
	/**
	 *单个加载进度 
	 */	
	[Event(name="load_progress_event_progress", type="seeegg.com.loader.LoadProgressEvent")]
	public class LoadBatch extends EventDispatcher
	{
		
		private static var _batchIndex:int = 0;
		
		private var _loadItems:Vector.<LoadItem> = new Vector.<LoadItem>();
		
		private var _loaderComtext:LoaderContext;
		
//		private var _loadedDataItems:Vector.<LoadData> = new Vector.<LoadData>();
		
		private var _batchID:int = 0;
		private var _completeNum:int = 0;
		public function LoadBatch()
		{
			_batchID = ++ _batchIndex;
			
			
		}
		
		public function get loaderComtext():LoaderContext
		{
			return _loaderComtext;
		}

		public function set loaderComtext(value:LoaderContext):void
		{
			_loaderComtext = value;
		}

		public function get loadItems():Vector.<LoadItem>
		{
			return _loadItems;
		}

//		public function get loadedDataItems():Vector.<LoadData>
//		{
//			return _loadedDataItems;
//		}

		public function get id():int
		{
			return _batchID;
		}
		
		public function get length():int
		{
			return this._loadItems.length;
		}
		
		public function addLoad(url:String, type:String):void
		{
			var li:LoadItem = LoadFactory.createLoadItem(url, type);
			this.addLoadItem(li);
		}
		
		public function addLoadItem(litem:LoadItem):void
		{
			_loadItems.push(litem);
			addItemEvents(litem);
		}
		
		public function startLoad():void
		{
			for each(var li:LoadItem in this._loadItems)
			{
				if(_loaderComtext)
				{
					li.loaderContext = _loaderComtext;
				}
				li.startLoad();
			}
		}
		
		public function dispose():void
		{
			for each(var li:LoadItem in this._loadItems)
			{
				removeItemEvents(li);
			}
		}
		
		private function addItemEvents(item:LoadItem):void
		{
			item.addEventListener(LoadItemEvent.LOAD_ITEM_EVENT_COMPLETE, onItemComplete);
			item.addEventListener(ProgressEvent.PROGRESS, onItemProgress);
		}
		
		private function removeItemEvents(item:LoadItem):void
		{
			item.removeEventListener(LoadItemEvent.LOAD_ITEM_EVENT_COMPLETE, onItemComplete);
			item.removeEventListener(ProgressEvent.PROGRESS, onItemProgress);
		}
		
		private function onItemProgress(e:ProgressEvent):void
		{
			var evt:LoadProgressEvent = new LoadProgressEvent(LoadProgressEvent.LOAD_PROGRESS_EVENT_PROGRESS);
			evt.bytesLoaded = e.bytesLoaded;
			evt.bytesTotal = e.bytesTotal;
			
			var li:LoadItem = e.target as LoadItem;
			if(li)
			{
				evt.loadItemIndex = li.index;
			}
			
			this.dispatchEvent(evt);
		}
		
		private function onItemComplete(e:LoadItemEvent):void
		{
			_completeNum ++;
//			_loadedDataItems.push(e.data);
			dispatchNumProgress();
			if(_completeNum >= this.length)
			{
				this.dispatchEvent(new LoadBatchEvent(LoadBatchEvent.LOAD_BATCH_EVENT_COMPLETE));
			}
		}
		
		private function dispatchNumProgress():void
		{
			var progressEvt:LoadBatchEvent = new LoadBatchEvent(LoadBatchEvent.LOAD_BATCH_EVENT_PROGRESS);
			progressEvt.totalNum = this.length;
			progressEvt.loadedNum = this._completeNum;
			this.dispatchEvent(progressEvt);
		}
	}
}