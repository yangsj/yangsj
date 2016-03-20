package
{

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import gem.view.home.HomeView;
	
	import manager.ui.UIMainManager;
	import manager.ui.UIViewContainer;
	
	import sounds.SoundType;
	


	/**
	 * 说明：AppMain
	 * @author Victor
	 * 2012-10-7
	 */

	public class AppMain extends Sprite
	{


		public function AppMain()
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
			
			// set stage background color
			stage.color = 0x000000;
			// set stage frameRate
			stage.frameRate = 60;

			// initialization the view containers 
			new UIViewContainer(stage);
			
			// create main view
			// initialization the appMain
			UIMainManager.addChild(new HomeView());
			
			stage.addChild(new Stats());
			
			var cls:Class = getDefinitionByName(SoundType.Sounds102) as Class;
		}


	}

}
