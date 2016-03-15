package net.victor.code.app.managers
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import net.victor.code.app.ContainerLayer;
	import net.victor.code.app.AppMainMediator;
	import net.victor.code.app.managers.interfaces.IPanelManager;
	import net.victor.code.framework.AppFacade;
	import net.victor.code.framework.AppViewMediator;
	import net.victor.code.managers.AppManagerIn;

	/**
	 * 面板显示管理器 
	 * 
	 */	
	public class AppPanelManager implements IPanelManager
	{
		static private var _showingPanel:Dictionary = new Dictionary(true);
		
		AppManagerIn static function setPanelShow(meidatorName:String):void
		{
			_showingPanel[meidatorName] = meidatorName;
			
			trace("[show view]:" + meidatorName);
		}
		
		AppManagerIn static function setPanelHide(meidatorName:String):void
		{
			delete _showingPanel[meidatorName];
			trace("[hide view]:" + meidatorName);
		}
		
		private var _managerName:String = "";
		
		
		
		public function AppPanelManager()
		{
		}
		
		public function showPanel(meidatorName:String, layer:String="", $alpha:Number=0.4):void
		{
			var mediator:AppViewMediator = getMediator(meidatorName);
			for each(var dis:DisplayObject in mediator.viewers)
			{
				dis.cacheAsBitmap = true;
				switch(layer)
				{
					case ContainerLayer.PANEL_LAYER:
					case "":
						mainMediator.addPanel(dis, -1, $alpha);
						break;
					case ContainerLayer.TOP_LAYER:
						mainMediator.addPanelToTop(dis, -1, $alpha);
						break;
					case ContainerLayer.SCENE_LAYER:
						mainMediator.addPanelToSceneLayer(dis, -1, $alpha)
						break;
				}
				
			}
			AppPanelManager.AppManagerIn::setPanelShow(meidatorName);
//			_showingPanel[meidatorName] = meidatorName;
		}
		
		public function hidePanel(meidatorName:String):void
		{
			var mediator:AppViewMediator = getMediator(meidatorName);
			if(!mediator)
			{
				trace("[hide view]:Can not find - " + meidatorName);
				return;
			}
			for each(var dis:DisplayObject in mediator.viewers)
			{
				mainMediator.removePanel(dis);
			}
			AppPanelManager.AppManagerIn::setPanelHide(meidatorName);
//			delete _showingPanel[meidatorName];
		}
		
		public function destroyPanel(meidatorName:String):void
		{
			hidePanel(meidatorName);
			AppFacade.instance.removeMediator(meidatorName);
		}
		
		public function isPanelShow(meidatorName:String):Boolean
		{
			if(_showingPanel[meidatorName])
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function get managerName():String
		{
			return _managerName;
		}
		
		public function setManagerName(value:String):void
		{
			_managerName = value;
		}
		
		protected function get mainMediator():AppMainMediator
		{
			return AppFacade.instance.retrieveMediator(AppMainMediator.AppMainMediatorName) as AppMainMediator;
		}
		
		protected function getMediator(meidatorName:String):AppViewMediator
		{
			return AppFacade.instance.retrieveMediator(meidatorName) as AppViewMediator;
		}
	}
}