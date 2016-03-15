package
{
	import code.MainControl;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * 说明：PinTuSimple
	 * @author Victor
	 * @email acsh_ysj@163.com
	 * 2012-4-16
	 */
	
	public class PinTuSimple extends Sprite
	{
		
		/////////////////////////////////static ////////////////////////////
		
		
		
		///////////////////////////////// vars /////////////////////////////////
		
		private var mainControl:MainControl;
		
		public function PinTuSimple()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(e:Event):void
		{
			mainControl = new MainControl();
			this.addChild(mainControl);
		}
		
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
		
		
	}
	
}