package app.modules.scene.view
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.scene.event.SceneEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class SceneMediator extends BaseMediator
	{
		public function SceneMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( SceneEvent.OPEN_TEST, openTestHandler, SceneEvent );
		}
		
		private function openTestHandler( event:SceneEvent ):void
		{
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Test ));
		}		
		
	}
}