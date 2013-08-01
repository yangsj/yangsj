package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import victor.GameStage;
	import victor.core.Alert;
	import victor.view.EffectPlayCenter;
	import victor.core.ViewStruct;
	import victor.view.scenes.main.MenuView;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-21
	 */
	public class LLK extends Sprite
	{
		public function LLK()
		{
			if ( stage )
				initApp();
			else
				addEventListener( Event.ADDED_TO_STAGE, initApp );
		}

		protected function initApp( event:Event = null ):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			trace( NativeApplication.nativeApplication.systemIdleMode );
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;

			GameStage.initStage( stage );
			ViewStruct.initialize( stage );

			addChild( MenuView.instance );

			addChild( EffectPlayCenter.instance );
		}
	}
}
