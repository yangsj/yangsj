package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width = "480", height = "800", frameRate = "24", backgroundColor="0x000000")]
	/**
	 * 说明：GemAir
	 * @author Victor
	 * 2012-10-7
	 */
	
	public class GemAir extends Sprite
	{
		
		
		public function GemAir()
		{
			if (stage)
				initialization();
			else
				addEventListener(Event.ADDED_TO_STAGE, initialization);
		}
		
		protected function initialization(event : Event = null) : void
		{
			// remove added events
			removeEventListener(Event.ADDED_TO_STAGE, initialization);
			
			// initialization the appMain
			addChild(new AppMain());
		}
		
		
		
	}
	
}