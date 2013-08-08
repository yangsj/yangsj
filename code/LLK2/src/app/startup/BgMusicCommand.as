package app.startup
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;

	import framework.BaseCommand;

	import app.core.SoundManager;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-5
	 */
	public class BgMusicCommand extends BaseCommand
	{
		public function BgMusicCommand()
		{
			super();
		}

		override public function execute():void
		{
			SoundManager.playBgMusic();
			NativeApplication.nativeApplication.addEventListener( Event.ACTIVATE, activateHandler );
			NativeApplication.nativeApplication.addEventListener( Event.DEACTIVATE, deactivateHandler );
		}

		protected function deactivateHandler( event:Event ):void
		{
			SoundManager.stopBgMusic();
		}

		protected function activateHandler( event:Event ):void
		{
			SoundManager.playBgMusic( false );
		}

	}
}
