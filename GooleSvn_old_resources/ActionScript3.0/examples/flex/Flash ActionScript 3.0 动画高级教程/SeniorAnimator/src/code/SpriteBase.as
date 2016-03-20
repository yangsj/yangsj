package code
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 * 说明：SpriteBase
	 * @author victor
	 * 2012-4-10 下午11:55:19
	 */
	
	public class SpriteBase extends Sprite
	{
		
		////////////////// vars /////////////////////////////////
		
		
		
		public function SpriteBase()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			initialization();
		}
		
		protected function initialization():void
		{
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.stage.addEventListener(MouseEvent.CLICK, onClickHandler);
		}
		
		protected function onEnterFrame(e:Event):void
		{
			
		}
		
		protected function onClickHandler(e:MouseEvent):void
		{
			initialization();
			trace("this.numChildren = " + this.numChildren);
			trace("stage.numChildren = " + stage.numChildren);
		}
		
		////////////////// static /////////////////////////////////
		
		
		
		////////////////// public /////////////////////////////////
		
		
		
		////////////////// private ////////////////////////////////
		
		
		
		////////////////// events//////////////////////////////////
		
		
		
	}
}