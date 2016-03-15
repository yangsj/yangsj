package net.victor.project.views.homepage
{
	import net.victor.project.notificationNames.HomePageNotificationNames;
	import net.victor.project.views.JTViewEvent;
	import net.victor.project.views.ViewMediatorBase;
	
	import org.puremvc.as3.interfaces.INotification;
	
	
	/** 
	 * 说明：
	 * @author 杨胜金
	 * 2011-11-14 下午02:55:21
	 */
	public class HomePageMediator extends ViewMediatorBase
	{
		/////////////////////////////////////////vars /////////////////////////////////
		
		private var homeView:HomePageView;
		
		public function HomePageMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
			initViews();
			addAndRemoveEvents(true);
		}
		
		/////////////////////////////////////////static /////////////////////////////////
		
		
		
		/////////////////////////////////////////public /////////////////////////////////
		
		/**
		 * 如果 value 的值存在，则不是登陆进入
		 * @param value
		 * 
		 */
		public function setInitData(value:Object = null):void
		{
			
		}
		
		public function clears():void
		{
			homeView.clears();
		}
		
		/////////////////////////////////////////override ///////////////////////////////
		
		override protected function initAbstract():void 
		{
			
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.name)
			{
				
			}
		}
		
		override public function listNotificationInterests():Array
		{
			return [];
		}
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		private function initViews():void
		{
			homeView = new HomePageView();
			this.viewers.push(homeView);
		}
		
		/////////////////////////////////////////events//////////////////////////////////
		
		private function addAndRemoveEvents(isAdd:Boolean):void
		{
			if (isAdd)
			{
				
				homeView.addEventListener(JTViewEvent.PANEL_CLOSE, closePanelHandler);
			}
			else
			{
				homeView.removeEventListener(JTViewEvent.PANEL_CLOSE, closePanelHandler);
			}
		}
		
		private function closePanelHandler(e:JTViewEvent):void
		{
			this.facade.sendNotification(HomePageNotificationNames.CloseHomePageCommand);
		}
		
		
	}
	
}