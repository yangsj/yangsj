package panel.select
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.system.fscommand;
	import flash.text.TextField;
	
	import net.jt_tech.ui.panel.ResourceSelectPanel;
	
	import scene.SelectPanelScene;
	
	
	/**
	 * 说明：StartSelectPanel
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-11
	 */
	
	public class StartSelectPanel extends Sprite
	{
		private var pane:ResourceSelectPanel;
		private var bgRes:Sprite;
		
		private var _callBackFunction:Function;
		
		public function StartSelectPanel()
		{
			createResource();
			addEvents();
		}
		
		private function createResource():void
		{
			bgRes = new scene.SelectPanelScene();
			this.addChild(bgRes);
			
			pane = new ResourceSelectPanel();
			this.addChild(pane);
			
			pane.x = (bgRes.width - pane.width) * 0.5;
			pane.y = (bgRes.height- pane.height)* 0.5;
		}
		
		private function addEvents():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function removeEvents():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		private function actionClose():void
		{
			removeEvents();
			if (callBackFunction != null)
			{
				callBackFunction.apply(this);
			}
			callBackFunction = null;
		}
		
		///////////// evetns functions handler /////////////
		
		protected function onClickHandler(event:MouseEvent):void
		{
			var targetName:String = event.target.name;
			if (targetName == pane.btnStartGame.name)
			{
				// 开始游戏
				actionClose();
			}
			else if (targetName == pane.btnExplain.name)
			{
				NativeApplication.nativeApplication.exit();
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			var scale:Number = Global.stage.stageWidth / this.width;
			this.scaleX = this.scaleY = scale;
		}
		
		/////////////// getter/setter //////////////////////////////////

		public function get callBackFunction():Function
		{
			return _callBackFunction;
		}

		public function set callBackFunction(value:Function):void
		{
			_callBackFunction = value;
		}

		
	}
	
}