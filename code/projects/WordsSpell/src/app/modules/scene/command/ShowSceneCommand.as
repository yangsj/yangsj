package app.modules.scene.command
{
	import app.modules.scene.view.SceneView;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class ShowSceneCommand extends BaseCommand
	{
		[Inject]
		public var scene:SceneView;
		
		public function ShowSceneCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			 scene.show();
		}
		
	}
}