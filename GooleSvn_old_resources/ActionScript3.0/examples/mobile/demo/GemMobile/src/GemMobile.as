package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="480", height="800", frameRate="60")]
	/**
	 * 说明：GemMobile
	 * @author Victor
	 * 2012-10-9
	 */
	
	public class GemMobile extends Sprite
	{
		
		
		public function GemMobile()
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