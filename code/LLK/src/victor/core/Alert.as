package victor.core
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;

	import victor.GameStage;
	import victor.components.Button;
	import victor.utils.DisplayUtil;
	import victor.utils.ToolUtil;
	import victor.utils.safetyCall;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-8-1
	 */
	public class Alert extends Sprite
	{
		private static var _alert:Alert;

		private var txtContent:TextField;
		private var skin:Sprite;

		private var btnConfirm:Button;
		private var btnCancel:Button;
		private var confirmCallBackFun:Function, cancelCallBackFun:Function;

		public function Alert()
		{
			super();
			this.graphics.beginFill( 0xffffff, 0 );
			this.graphics.drawRect( 0, 0, GameStage.stageWidth, GameStage.stageHeight );
			this.graphics.endFill();

			skin = new Sprite();
			skin.graphics.beginFill( 0 );
			skin.graphics.drawRoundRect( 0, 0, 480, 240, 20 );
			skin.graphics.endFill();
			skin.x = ( width - skin.width ) >> 1;
			skin.y = ( height - skin.height ) >> 1;
			addChild( skin );

			txtContent = ToolUtil.getTextFiled( 24, 0xffffff, TextFormatAlign.CENTER, true );
			txtContent.width = ( skin.width - 40 );
			txtContent.height = ( skin.height - 120 );
			txtContent.x = 20;
			txtContent.y = 30;
			skin.addChild( txtContent );

			var num1:Number = txtContent.y + txtContent.height + 10;
			var num2:Number = skin.height - num1;

			btnConfirm = new Button( " 确 定 ", btnConfirmHandler, 35 );
			btnConfirm.x = ( skin.width >> 1 ) - ( btnConfirm.width >> 1 ) - 20;
			btnConfirm.y = num1 + (( num2 - btnConfirm.height ) >> 1 );
			skin.addChild( btnConfirm );

			btnCancel = new Button( " 取 消 ", btnCancelHandler, 35 );
			btnCancel.x = ( skin.width >> 1 ) + ( btnCancel.width >> 1 ) + 20;
			btnCancel.y = num1 + (( num2 - btnCancel.height ) >> 1 );
			skin.addChild( btnCancel );
		}

		private function btnCancelHandler():void
		{
			safetyCall( cancelCallBackFun );
			close();
		}

		private function btnConfirmHandler():void
		{
			safetyCall( confirmCallBackFun );
			close();
		}

		public function show( content:String, confirmCallBackFun:Function = null, cancelCallBackFun:Function = null ):void
		{
			txtContent.htmlText = content;
			this.confirmCallBackFun = confirmCallBackFun;
			this.cancelCallBackFun = cancelCallBackFun;
			ViewStruct.addChild( this, ViewStruct.ALERT );

			txtContent.y = ( btnCancel.y - 15 - txtContent.textHeight ) >> 1;
		}

		public function close():void
		{
			DisplayUtil.removedFromParent( this );
			confirmCallBackFun = null;
			cancelCallBackFun = null;
		}

		public static function show( content:String, confirmCallBackFun:Function = null, cancelCallBackFun:Function = null ):void
		{
			_alert ||= new Alert();
			_alert.show( content, confirmCallBackFun, cancelCallBackFun );
		}

		public static function close():void
		{
			if ( _alert )
				_alert.close();
		}

	}
}
