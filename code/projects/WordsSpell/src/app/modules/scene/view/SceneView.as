package app.modules.scene.view
{
	import flash.events.MouseEvent;
	
	import app.modules.scene.event.SceneEvent;
	import app.utils.appStage;
	
	import victor.framework.core.BaseScene;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class SceneView extends BaseScene
	{
		public function SceneView()
		{
			this.graphics.beginFill( 0 );
			this.graphics.drawRect(0,0,appStage.stageWidth, appStage.stageHeight);
			this.graphics.endFill();
			
			addEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new SceneEvent( SceneEvent.OPEN_TEST ));
		}
	}
}