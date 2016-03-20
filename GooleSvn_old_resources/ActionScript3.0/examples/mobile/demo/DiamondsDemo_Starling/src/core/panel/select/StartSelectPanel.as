package core.panel.select
{
	import button.spark.Butto_Spark_Down;
	import button.spark.Butto_Spark_Up;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import scene.SelectPanelScene;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	
	/**
	 * 说明：StartSelectPanel
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-9-11
	 */
	
	public class StartSelectPanel extends Sprite
	{
		private var bgRes:Image;
		private var btnStartNewGame:Button;
		private var btnRanking:Button;
		
		private var _callBackFunction:Function;
		
		public function StartSelectPanel()
		{
			createResource();
			addEvents();
		}
		
		private function createResource():void
		{
			bgRes = Image.fromBitmap(Global.drawAsBitmap(new scene.SelectPanelScene()));;
			this.addChild(bgRes);
			
			btnStartNewGame = new Button(Texture.fromBitmap(Global.drawAsBitmap(new Butto_Spark_Up)), "开始新游戏", Texture.fromBitmap(Global.drawAsBitmap(new Butto_Spark_Down)));
			btnStartNewGame.x = 100;
			btnStartNewGame.y = 100;
			btnStartNewGame.name = "startNewGameBtn";
			this.addChild(btnStartNewGame);
			
			btnRanking = new Button(Texture.fromBitmap(Global.drawAsBitmap(new Butto_Spark_Up)), "游戏说明", Texture.fromBitmap(Global.drawAsBitmap(new Butto_Spark_Down)));
			btnRanking.x = 100;
			btnRanking.y = 200;
			btnRanking.name = "btnRanking";
			this.addChild(btnRanking);
		}
		
		private function addEvents():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
//			btnStartNewGame.addEventListener(TouchEvent.TOUCH, btnStartNewGameHandler);
			btnStartNewGame.addEventListener(Event.TRIGGERED, btnStartNewGameHandler);
		}
		
		private function removeEvents():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
//			btnStartNewGame.removeEventListener(TouchEvent.TOUCH, btnStartNewGameHandler);
			btnStartNewGame.removeEventListener(Event.TRIGGERED, btnStartNewGameHandler);
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
		
		private function btnStartNewGameHandler(e:Event):void
		{
			actionClose();
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			var scale:Number = this.stage.stageWidth / this.width;
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