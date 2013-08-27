package app.startup
{
	import app.events.ServiceEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class InitServiceCommand extends BaseCommand
	{
		public function InitServiceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			connected();
		}
		
		private function connected():void
		{
			dispatch( new ServiceEvent( ServiceEvent.CONNECTED ));
		}
		
		private function failed():void
		{
			dispatch( new ServiceEvent( ServiceEvent.FAILED ));
		}
		
	}
}