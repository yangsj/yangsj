package panel.gamepause
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import managers.PanelManager;
	
	import net.jt_tech.ui.JTPanelBase;
	import net.jt_tech.ui.panel.ResourceGamePausePanel;
	
	import scene.SelectPanelScene;
	
	
	/**
	 * 说明：GamePausePanel
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-19
	 */
	
	public class GamePausePanel extends JTPanelBase
	{
		
		public var exitCallBackFun:Function;
		public var continueCallBackFun:Function;
		
		
		private var btnMenuRes:ResourceGamePausePanel;
		private var bgRes:DisplayObject;
		
		public function GamePausePanel()
		{
			super();
			if (_instance)
			{
				throw new Error("该类为单例类，只能实例化一次，请访问instance属性获得");
			}
			_instance = this;
			initCreateResource();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		public function initialization():void
		{
			addEvents();
		}
		
		private function initCreateResource():void
		{
			bgRes = new scene.SelectPanelScene();
			bgRes.alpha = 0.8;
			this.addChild(bgRes);
			
			btnMenuRes = new ResourceGamePausePanel();
			this.addChild(btnMenuRes);
			
			btnMenuRes.x = (bgRes.width - btnMenuRes.width) * 0.5;
			btnMenuRes.y = (bgRes.height- btnMenuRes.height)* 0.5;
		}
		
		private function closePanel():void
		{
			PanelManager.instance.removePanel(this);
		}
		
		private function addEvents():void
		{
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.scaleX = this.scaleY = this.stage.stageWidth / this.width;
		}
		
		private function removeEvents():void
		{
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if (targetName == btnMenuRes.btnExit.name)
			{
				// 退出
				closePanel();
				if (exitCallBackFun != null)
				{
					exitCallBackFun.apply(this);
					exitCallBackFun = null;
				}
			}
			else if (targetName == btnMenuRes.btnContinue.name)
			{
				// 继续
				closePanel();
				if (continueCallBackFun != null)
				{
					continueCallBackFun.apply(this);
					continueCallBackFun = null;
				}
			}
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeEvents();
		}
		
		///////////////////////////////////////////////////////
		
		private static var _instance:GamePausePanel;
		
		public static function get instance():GamePausePanel
		{
			if (_instance == null) new GamePausePanel();
			return _instance;
		}
		
		
	}
	
}