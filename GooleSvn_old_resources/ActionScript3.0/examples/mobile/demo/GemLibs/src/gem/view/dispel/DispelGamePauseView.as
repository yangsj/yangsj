package gem.view.dispel
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import manager.ui.UIPanelManager;
	
	import scene.ResourceSceneBackGround0001;
	
	import ui.dispelscene.ResourceGamePauseAndExitView;
	
	
	/**
	 * 说明：DispelGamePauseView
	 * @author Victor
	 * 2012-10-9
	 */
	
	public class DispelGamePauseView extends Sprite
	{
		private var view:ResourceGamePauseAndExitView;
		private var backScene:Sprite;
		
		public var continueFunction:Function;
		public var exitFunction:Function;
		
		public function DispelGamePauseView()
		{
			super();
			
			createResource();
			
			addEvents();
		}
		
		public function open():void
		{
			UIPanelManager.addChild(this);
		}
		
		private function createResource():void
		{
			// init and create back
			backScene = new ResourceSceneBackGround0001();
			addChild(backScene);
			
			view = new ResourceGamePauseAndExitView();
			addChild(view);
			
			// set center align
			view.x = (backScene.width - view.width) * 0.5;
			view.y = (backScene.height- view.height)* 0.5;
		}
		
		private function addEvents():void
		{
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removeEvents():void
		{
			removeEventListener(MouseEvent.CLICK, onClick);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEvents();
			continueFunction = null;
			exitFunction = null;
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if (targetName == view.btnContinue.name)
			{
				clickContinue();
			}
			else if (targetName == view.btnExit.name)
			{
				clickExit();
			}
		}		
		
		private function clickContinue():void
		{
			if (continueFunction != null)
			{
				continueFunction.apply(this);
			}
			
			exit();
		}
		
		private function clickExit():void
		{
			if (exitFunction != null)
			{
				exitFunction.apply(this);
			}
			
			exit();
		}
		
		private function exit():void
		{
			UIPanelManager.removeChild(this);
		}
		
	}
	
}