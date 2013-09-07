package app.modules.scene.command
{
	import app.modules.scene.event.SceneEvent;
	import app.modules.scene.view.SceneMediator;
	import app.modules.scene.view.SceneView;
	
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
			// 主场景
			addView( "", SceneView, SceneMediator );
			
			
			commandMap.mapEvent( SceneEvent.SHOW, ShowSceneCommand, SceneEvent );
		}
		
	}
}