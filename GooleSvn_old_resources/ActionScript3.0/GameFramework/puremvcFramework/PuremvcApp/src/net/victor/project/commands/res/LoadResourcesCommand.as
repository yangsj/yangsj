package net.victor.project.commands.res
{
	
	import flash.system.LoaderContext;
	
	import net.victor.project.commands.base.AppLogicCommandBase;
	import net.victor.project.models.loading.LoadingBarDataVo;
	import net.victor.project.notificationNames.HomePageNotificationNames;
	import net.victor.project.notificationNames.LoadingBarNotificationNames;
	import net.victor.project.notificationNames.LoginNotificationNames;
	import net.victor.project.notificationNames.StartGameNotificationNames;
	import net.victor.code.loader.LoadBatch;
	import net.victor.code.loader.LoadBatchEvent;
	import net.victor.code.loader.LoadType;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class LoadResourcesCommand extends AppLogicCommandBase
	{
		/////////////////////////////////////////static /////////////////////////////////
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var _loadingBarData:LoadingBarDataVo = new LoadingBarDataVo();
		
		public function LoadResourcesCommand()
		{
			super();
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override public function execute(notification:INotification):void
		{
			this.facade.sendNotification(LoadingBarNotificationNames.ClosePreloaderBarCommand);
			
			var _commonResXMLPath:Array = this.confProxy.getAllPathArray(this.confProxy.getCommonResXMLData);
			var _resListXMLPath:Array = this.confProxy.getAllPathArray(this.confProxy.getResouresListData);
			
			var loadBatch:LoadBatch = new LoadBatch();
			loadBatch = new LoadBatch();
			loadBatch.loaderComtext = new LoaderContext(false, this.uiResourceManager.currentUIDomain);
			
			var pathStr:*;
			for each (pathStr in _commonResXMLPath)
			{
				loadBatch.addLoad(pathStr, LoadType.SWF);
			}
			
			for each (pathStr in _resListXMLPath)
			{
				loadBatch.addLoad(pathStr, LoadType.SWF);
			}
			
			if (_commonResXMLPath == null && _resListXMLPath == null)
			{
				sendNotificationStart();
				loadBatch = null;
			}
			else
			{
				loadBatch.addEventListener(LoadBatchEvent.LOAD_BATCH_EVENT_COMPLETE, onCompleteResources);
				loadBatch.addEventListener(LoadBatchEvent.LOAD_BATCH_EVENT_PROGRESS, onCompleteProgress);
				loadBatch.startLoad();
			}
			
		}
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function onCompleteResources(e:LoadBatchEvent):void
		{
			var loadBatch:LoadBatch = e.target as LoadBatch;
			loadBatch.removeEventListener(LoadBatchEvent.LOAD_BATCH_EVENT_PROGRESS, onCompleteProgress);

			sendNotificationStart();
		
		}
		
		private function sendNotificationStart():void
		{
			this.facade.sendNotification(LoadingBarNotificationNames.CloseLoadingBarCommand);
			this.facade.sendNotification(HomePageNotificationNames.ShowHomePageCommand);
		}
		
		private function onCompleteProgress(e:LoadBatchEvent):void
		{
			_loadingBarData.loaded = e.loadedNum;
			_loadingBarData.total = e.totalNum;
			
			this.facade.sendNotification(LoadingBarNotificationNames.LoadingBarProgressCommand, _loadingBarData);
			trace(e.loadedNum + " / " + e.totalNum);
		}
	}
}