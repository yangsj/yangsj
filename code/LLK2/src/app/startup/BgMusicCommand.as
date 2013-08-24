package app.startup
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import app.AppStage;
	import app.manager.SoundManager;
	
	import framework.BaseCommand;


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
			SoundManager.stopBgSndMusic();
			
			AppStage.stage.frameRate = 0.001;
		}

		protected function activateHandler( event:Event ):void
		{
			SoundManager.playBgMusic( false );
			
			AppStage.stage.frameRate = 24;
		}

	}
}
