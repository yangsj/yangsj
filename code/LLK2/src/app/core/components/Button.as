package app.core.components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import ui.components.UIButtonSkin;

	import app.AppStage;
	import app.core.SoundManager;
	import framework.interfaces.IDisposable;
	import app.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-28
	 */
	public class Button extends Sprite implements IDisposable
	{
		private var _skin:UIButtonSkin;
		private var _clickCallBack:Function;
		private var _stage:Stage;
		private var _txtName:TextField;
		private var _mcSkin:MovieClip;
		private var _tfm:TextFormat;

		public function Button( label:String, clickHandler:Function = null, fontSize:int = 50 )
		{
			_skin = new UIButtonSkin();
			_txtName = _skin.txtName;
			_mcSkin = _skin.mcSkin;
			addChild( _skin );

			_clickCallBack = clickHandler;

			_tfm = _txtName.defaultTextFormat;
			_tfm.align = TextFormatAlign.LEFT;
			_tfm.size = fontSize;

			_txtName.wordWrap = false;
			_txtName.defaultTextFormat = _tfm;
			_mcSkin.stop();

			mouseChildren = false;
			buttonMode = true;

			setLabel( label );

			addListener();

			AppStage.adjustScaleXY( this );
		}

		public function setLabel( label:String ):void
		{
			if ( label != _txtName.text )
			{
				_txtName.text = label;
				var tw:Number = _txtName.textWidth;
				var th:Number = _txtName.textHeight;
				_txtName.width = tw + 10;
				_txtName.height = th + 2;
				_txtName.x = -tw >> 1;
				_txtName.y = -th >> 1;
				_mcSkin.width = tw + 30;
				_mcSkin.height = th + 30;
			}
		}

		public function dispose():void
		{
			removeEventListener( Event.ADDED_TO_STAGE, addedToStageHandler );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			if ( _stage )
				_stage.removeEventListener( MouseEvent.MOUSE_UP, mouseHandler );

			_tfm = null;
			_stage = null;
			_mcSkin = null;
			_txtName = null;
			_clickCallBack = null;
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
			_mcSkin.gotoAndStop( isUp ? 1 : 2 );
			if ( isUp && event.target == this )
			{
				event.stopPropagation();
				safetyCall( _clickCallBack );
				SoundManager.playClickButton();
			}
		}

		override public function set mouseChildren( enable:Boolean ):void
		{
			if ( enable != mouseChildren )
			{
				super.mouseChildren = false;
			}
		}

	}
}
