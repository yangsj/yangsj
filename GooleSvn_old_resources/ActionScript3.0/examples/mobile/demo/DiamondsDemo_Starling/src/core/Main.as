package core
{
	import core.panel.select.StartSelectPanel;
	
	import scene.SelectPanelScene;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	/**
	 * 说明：Main
	 * @author victor
	 * 2012-9-18 上午11:19:06
	 */
	
	public class Main extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		private var selectPanel:StartSelectPanel;
		
		public function Main()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, initialization);
		}
		
		private function initialization(e:Event):void
		{
			addSelectPanel();
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		private function addSelectPanel():void
		{
			selectPanel = new StartSelectPanel();
			this.addChild(selectPanel);
			
			selectPanel.callBackFunction = startGame;
		}
		
		private function startGame():void
		{
			// TODO Auto Generated method stub
			removeSelectPanel();
		}
		
		private function removeSelectPanel():void
		{
			if (selectPanel)
			{
				if (selectPanel.parent) selectPanel.removeFromParent(true);
				selectPanel.dispose();
				selectPanel = null;
			}
		}
		
		////////////////// events//////////////////////////////////
		
		
		////////////////// getter/setter //////////////////////////
		
		
	}
}