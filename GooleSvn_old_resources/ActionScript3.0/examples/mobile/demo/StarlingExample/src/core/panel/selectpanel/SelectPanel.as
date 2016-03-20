package core.panel.selectpanel
{
	import button.ButtonIntroduce_Down_Skin;
	import button.ButtonIntroduce_Up_Skin;
	import button.ButtonRanking_Down_Skin;
	import button.ButtonRanking_Up_Skin;
	import button.ButtonStartNewGame_Down_Skin;
	import button.ButtonStartNewGame_Up_Skin;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SelectPanel extends Sprite
	{
		private var btnStartNewGame:Button;
		private var btnRanking:Button;
		private var btnIntroduce:Button;
		
		
		public var callBackFunction:Function;
		
		public function SelectPanel()
		{
			super();
			
			createResource();
		}
		
		public function initialization():void
		{
			addEvents();
		}
		
		private function createResource():void
		{
			btnStartNewGame = new Button(Texture.fromBitmapData(new ButtonStartNewGame_Up_Skin()), "",  Texture.fromBitmapData(new ButtonStartNewGame_Down_Skin()));
			btnRanking = new Button(Texture.fromBitmapData(new ButtonRanking_Up_Skin), "",  Texture.fromBitmapData(new ButtonRanking_Down_Skin));
			btnIntroduce = new Button(Texture.fromBitmapData(new ButtonIntroduce_Up_Skin()), "",  Texture.fromBitmapData(new ButtonIntroduce_Down_Skin()));
			
			btnRanking.y = 85;
			btnIntroduce.y = 170;
			
			this.addChild(btnStartNewGame);
			this.addChild(btnRanking);
			this.addChild(btnIntroduce);
		}
		
		private function addEvents():void
		{
			btnStartNewGame.addEventListener(Event.TRIGGERED, btnStartNewGameClickHandler);
			btnRanking.addEventListener(Event.TRIGGERED, btnRankingClickHandler);
			btnIntroduce.addEventListener(Event.TRIGGERED, btnIntroduceClickHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removeEvents():void
		{
			btnStartNewGame.removeEventListener(Event.TRIGGERED, btnStartNewGameClickHandler);
			btnRanking.removeEventListener(Event.TRIGGERED, btnRankingClickHandler);
			btnIntroduce.removeEventListener(Event.TRIGGERED, btnIntroduceClickHandler);
		}
		
		private function btnStartNewGameClickHandler(event:Event):void
		{
			if (callBackFunction != null)
			{
				callBackFunction.apply(this);
				callBackFunction = null;
			}
		}
		
		private function btnRankingClickHandler(event:Event):void
		{
			
		}
		
		private function btnIntroduceClickHandler(event:Event):void
		{
			
		}
		
		private function removedFromStageHandler():void
		{
			removeEvents();
		}
		
		
		
	}
}