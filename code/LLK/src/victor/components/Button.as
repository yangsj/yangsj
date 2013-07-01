package victor.components
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
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

		public function Button( label:String, clickHandler:Function = null, fontSize:int = 50 )
		{
			skin = new UIButtonSkin();
			addChild( skin );
			
			var tfm:TextFormat = skin.txtName.defaultTextFormat;
			tfm.size = fontSize;
			
			skin.txtName.defaultTextFormat = tfm;

			skin.txtName.text = label;
			skin.mcSkin.stop();

			mouseChildren = false;
			buttonMode = true;
			
			skin.txtName.width = skin.txtName.textWidth + 15;
			skin.txtName.height = skin.txtName.textHeight + 5;
			skin.txtName.x = -skin.txtName.width >> 1;
			skin.txtName.y = -skin.txtName.height >> 1;
			skin.mcSkin.width = skin.txtName.textWidth + 30;
			skin.mcSkin.height = skin.txtName.textHeight + 30;

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
			skin.mcSkin.gotoAndStop( isUp ? 1 : 2 );
			if ( isUp )
			{
				if (event.target == this)
					safetyCall( clickCallBack );
			}
		}

	}
}
