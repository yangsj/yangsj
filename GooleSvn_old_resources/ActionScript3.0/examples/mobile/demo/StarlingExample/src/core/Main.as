package core
{
	import core.game.DispelMain;
	import core.manager.PanelManager;
	import core.manager.SceneManager;
	import core.panel.selectpanel.SelectPanel;
	
	import flash.display.Bitmap;
	
	import scene.SceneBackGround001;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		private var thisBackGround:Image;
		private var selectPanel:SelectPanel;
		
		public function Main()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, initialization);
		}
		
		private function initialization(event:Event):void
		{	
			thisBackGround = Image.fromBitmap(new Bitmap(new SceneBackGround001()));
//			var b_scalex:Number = Starling.current.viewPort.width / thisBackGround.width;
//			var b_scaley:Number = Starling.current.viewPort.height / thisBackGround.height;
//			thisBackGround.scaleX = thisBackGround.scaleY = b_scalex > b_scaley ? b_scalex : b_scaley;
			this.addChild(thisBackGround);
			
			var sceneContainer:Sprite = new Sprite();
			this.addChild(sceneContainer);
			
			var panelContainer:Sprite = new Sprite();
			this.addChild(panelContainer);
			
			SceneManager.sceneContainer = sceneContainer;
			PanelManager.panelContainer = panelContainer;
			
			addSelectPanel();
		}
		
		
		private function addSelectPanel():void
		{
			selectPanel = new SelectPanel();
			PanelManager.addPanel(selectPanel);
			selectPanel.callBackFunction = selectPanelCallBackFunction;
			selectPanel.initialization();
		}
		
		private function selectPanelCallBackFunction():void
		{
			PanelManager.removePanel(selectPanel);
			
			SceneManager.addChild(new DispelMain());
		}
		
	}
}