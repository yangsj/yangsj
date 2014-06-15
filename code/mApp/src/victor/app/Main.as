package victor.app
{
	import flash.desktop.NativeApplication;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	
	import victor.app.scene.BreathTrainningScene;
	import victor.app.scene.MemoryTrainningSceme;
	import victor.framework.constant.TransitionType;
	import victor.framework.core.AutoLayout;
	import victor.framework.core.Instance;
	import victor.framework.core.Scene;
	import victor.framework.interfaces.IScene;
	
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
		
		public static function openScene():void
		{
			Instance.getSceneInstance( Main ).transitionIn( TransitionType.RIGHT_LEFT );
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
			if ( target == uiMain.btnBreath )
			{
				Instance.getSceneInstance( BreathTrainningScene ).transitionIn( TransitionType.LEFT_RIGHT );
			}
			else if ( target == uiMain.btnMemory )
			{
				Instance.getSceneInstance( MemoryTrainningSceme ).transitionIn( TransitionType.LEFT_RIGHT );
			}
			else if ( target == uiMain.btnExit )
			{
				NativeApplication.nativeApplication.exit();
			}
		}
		
	}
}