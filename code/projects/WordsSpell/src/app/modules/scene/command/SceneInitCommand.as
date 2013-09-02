package app.modules.scene.command
{
	import app.modules.scene.event.SceneEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class SceneInitCommand extends BaseCommand
	{
		public function SceneInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			commandMap.mapEvent( SceneEvent.SHOW, ShowSceneCommand, SceneEvent );
		}
		
	}
}