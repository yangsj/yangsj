package view
{

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import global.Global;
	
	import manager.ui.UIAlertManager;
	
	import utils.TextFieldTyper;


	/**
	 * 说明：Alert
	 * @author Victor
	 * 2012-11-9
	 */

	public class AlertPanel extends Sprite
	{
		private static var _instance : AlertPanel;

		private var txtTitle : TextField;
		private var txtDescribe : TextField;
		private var buttonClose : Sprite;

		private var writeManager : TextFieldTyper;
		
		public var callFun:Function;

		public function AlertPanel()
		{
			this.graphics.lineStyle( 1 );
			this.graphics.beginFill( 0xffffff, 0.7 );
			this.graphics.drawRect( 0, 0, 320, 240 );
			this.graphics.moveTo( 0, 40 );
			this.graphics.lineTo( 320, 40 );
			this.graphics.endFill();

			writeManager = TextFieldTyper.create( txtDescribe );

			initVars();
		}

		public static function get instance() : AlertPanel
		{
			if ( _instance == null )
				_instance = new AlertPanel();
			return _instance;
		}

		public function show( describe : String, title : String = "alert panel", autoClose : Boolean = false ) : void
		{
			txtDescribe.text = describe + "";
			txtTitle.text = title + "";

			writeManager.text = describe;
			writeManager.startWrite();

			UIAlertManager.addChild( this );
			this.x = ( Global.stageWidth - this.width ) * 0.5;
			this.y = ( Global.stageHeight - this.height ) * 0.5;

			buttonClose.visible = !autoClose;
			if ( autoClose == false )
				buttonClose.addEventListener( MouseEvent.CLICK, onClose );
		}

		protected function onClose( event : MouseEvent ) : void
		{
			removed();
			if (callFun != null)
			{
				callFun.call(this);
				callFun = null;
			}
		}

		public function removed() : void
		{
			if ( this.parent )
				this.parent.removeChild( this );
			if ( buttonClose.hasEventListener( MouseEvent.CLICK ))
				buttonClose.removeEventListener( MouseEvent.CLICK, onClose );
		}


		private function initVars() : void
		{
			if ( txtDescribe == null )
			{
				txtDescribe = new TextField();
				var textFormat1 : TextFormat = new TextFormat();
				textFormat1.bold = true;
				textFormat1.color = 0x000000;
				textFormat1.font = "Courier New";
				textFormat1.size = "20";
				textFormat1.italic = false;
				textFormat1.align = "left";
				textFormat1.leftMargin = 0;
				textFormat1.rightMargin = 0;
				textFormat1.leading = 2;
				textFormat1.indent = 0;
				txtDescribe.multiline = true;
				txtDescribe.wordWrap = true;
				txtDescribe.selectable = false;
				txtDescribe.mouseEnabled = false;
				txtDescribe.defaultTextFormat = textFormat1;

				txtDescribe.name = "_txtDescribe";
				txtDescribe.x = 20;
				txtDescribe.y = 50.25;
				txtDescribe.width = 280;
				txtDescribe.height = 174.8;
				txtDescribe.scaleX = 1;
				txtDescribe.scaleY = 1;
				txtDescribe.alpha = 1;
				txtDescribe.rotation = 0;
			}
			addChild( txtDescribe );

			if ( txtTitle == null )
			{
				txtTitle = new TextField();
				var textFormat0 : TextFormat = new TextFormat();
				textFormat0.bold = true;
				textFormat0.color = 0xff0000;
				textFormat0.font = "Courier New";
				textFormat0.size = "25";
				textFormat0.italic = false;
				textFormat0.align = "center";
				textFormat0.leftMargin = 0;
				textFormat0.rightMargin = 0;
				textFormat0.leading = 2;
				textFormat0.indent = 0;
				txtTitle.multiline = false;
				txtTitle.wordWrap = false;
				txtTitle.selectable = false;
				txtTitle.mouseEnabled = false;
				txtTitle.defaultTextFormat = textFormat0;

				txtTitle.name = "_txtTitle";
				txtTitle.x = 0;
				txtTitle.y = 6;
				txtTitle.width = 320;
				txtTitle.height = 32.3;
				txtTitle.scaleX = 1;
				txtTitle.scaleY = 1;
				txtTitle.alpha = 1;
				txtTitle.rotation = 0;
			}
			addChild( txtTitle );

			buttonClose = getButton( "X" );
			buttonClose.x = this.width - buttonClose.width - 2;
			buttonClose.y = 2;
			addChild( buttonClose );
		}

		private function getButton( $name : String ) : Sprite
		{
			var button : Sprite = new Sprite();
			button.graphics.beginFill( 0xffffff, 0.8 );
			button.graphics.drawRect( 0, 0, 19, 18 );
			button.graphics.endFill();

			var text : TextField = new TextField();
			text.text = $name;
			text.width = text.textWidth + 2;
			text.height = text.textHeight + 2;
			text.x = ( button.width - text.width ) * 0.5;
			text.y = ( button.height - text.height ) * 0.5;
			button.addChild( text );
			button.mouseChildren = false;
			button.buttonMode = true;

			return button;
		}


	}

}
