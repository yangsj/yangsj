package gem.view.home
{
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import gem.view.ViewBase;
	import gem.view.dispel.DispelView;
	
	import manager.ui.UIMainManager;
	
	import scene.ResourceSceneBackGround0001;
	
	import ui.home.ResourceHomeView;
	
	
	/**
	 * 说明：HomeView
	 * @author Victor
	 * 2012-10-7
	 */
	
	public class HomeView extends ViewBase
	{
		private const btnNameArray:Array = ["btnStartGame", "btnRanking", "btnExplain", "btnExit"];
		
		private var backScene:Sprite;
		private var homeView:ResourceHomeView;
		private var type:int = 0;
		
		public function HomeView()
		{
			super();
			
			createResource();
		}
		
		private function createResource():void
		{
			// init and create back
			backScene = new ResourceSceneBackGround0001();
			addChild(backScene);
			
			// init and create main view
			homeView = new ResourceHomeView();
			addChild(homeView);
			
			// set center align
			homeView.x = (backScene.width - homeView.width) * 0.5;
			homeView.y = (backScene.height- homeView.height)* 0.5;
		}
		
		override protected function onClick(event:MouseEvent):void
		{
			super.onClick(event);
			if (btnNameArray.indexOf(targetName) != -1)
			{
				this["handler_" + targetName]();
			}
		}
		
		private function handler_btnStartGame():void
		{
			jtrace("开始游戏");
			type = 1;
			exit();
		}
		
		private function handler_btnRanking():void
		{
			jtrace("排行榜");
			type = 2;
		}
		private function handler_btnExplain():void
		{
			jtrace("游戏说明");
			type = 3;
		}
		
		private function handler_btnExit():void
		{
			jtrace("开始游戏");
			type = 4;
			NativeApplication.nativeApplication.exit();
		}
		
		override protected function actionClose():void
		{
			super.actionClose();
			switch (type)
			{
				case 1:
					var dispelView:DispelView = new DispelView();
					UIMainManager.addChild(dispelView);
					dispelView.initialization();
					break;
				case 2:
					
					break;
				case 3:
					
					break;
			}
		}
		
	}
	
}