package victor.components
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import ui.components.UIButtonSkin;

	import victor.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class Button extends Sprite
	{
		private var skin:UIButtonSkin;

		private var clickCallBack:Function;

		private var _stage:Stage;

		public function Button( label:String, clickHandler:Function = null )
		{
			skin = new UIButtonSkin();
			addChild( skin );

			skin.txtName.text = label;
			skin.stop();

			mouseChildren = false;
			buttonMode = true;

			clickCallBack = clickHandler;

			addListener();
		}

		public function dispose():void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			if ( _stage )
				_stage.removeEventListener( MouseEvent.MOUSE_UP, mouseHandler );

			_stage = null;
			clickCallBack = null;
		}

		private function addListener():void
		{
			if ( _stage )
			{
				addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
				_stage.addEventListener( MouseEvent.MOUSE_UP, mouseHandler );
			}
			else
			{
				addEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			}
		}

		protected function addedToStageHandler( event:Event ):void
		{
			_stage = this.stage;
			addListener();
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
		}

		protected function mouseHandler( event:MouseEvent ):void
		{
			var isUp:Boolean = event.type == MouseEvent.MOUSE_UP;
			skin.gotoAndStop( isUp ? 1 : 2 );
			if ( isUp )
			{
				if (event.target == this)
					safetyCall( clickCallBack );
			}
		}

	}
}
