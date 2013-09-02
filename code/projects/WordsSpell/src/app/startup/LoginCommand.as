package app.startup
{
	import app.events.LoadEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-27
	 */
	public class LoginCommand extends BaseCommand
	{
		public function LoginCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			loginSuccess();
		}
		
		private function loginSuccess():void
		{
			dispatch( new LoadEvent( LoadEvent.LOAD_START ));
		}
		
	}
}