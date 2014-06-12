package victor.app
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import victor.app.components.Button;
	import victor.app.scene.StartScene;
	import victor.framework.constant.TransitionType;
	import victor.framework.core.AutoLayout;
	import victor.framework.core.Instance;
	import victor.framework.core.Scene;
	import victor.framework.interfaces.IScene;
	import victor.framework.utils.appstage;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-13
	 */
	public class Main extends Scene
	{	
		///////////////
		
		private var uiMain:UI_Main;
		
		public function Main()
		{
			super();
		}
		
		public static function firstTransition():void
		{
			var main:IScene = Instance.getSceneInstance( Main );
			main.isTransition = false;
			main.transitionIn();
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		override protected function createUI():void
		{
			uiMain = new UI_Main();
			addChild( uiMain );
			AutoLayout.layout( uiMain );
			
			uiMain.addEventListener( MouseEvent.CLICK, uiMainClickHandler );
		}
		
		private function uiMainClickHandler( event:MouseEvent ):void
		{
			var target:InteractiveObject = event.target as InteractiveObject;
			if ( target == uiMain.btnStart )
			{
				Instance.getSceneInstance( StartScene ).transitionIn( TransitionType.LEFT_RIGHT );
			}
		}
		
	}
}