package app.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import app.managers.LoaderManager;
	import app.utils.appStage;
	import app.utils.safetyCall;
	
	import victor.framework.components.Reflection;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-5
	 */
	public class Alert extends Sprite
	{
		
///// static vars
		public static const YES:uint = 0;
		public static const NO:uint = 1;
		public static const CLOSE:uint = 2;
		
		private static const YES_NAME:String = "确定";
		private static const NO_NAME:String = "取消";
		
		private static var _instance:Alert;

///// resource uis 
		private var _skin:Sprite;
		
		public var btnConfirm1:Sprite;
		public var btnConfirm2:Sprite;
		public var btnCancel:Sprite;
		public var btnClose:InteractiveObject;
		public var dragTarget:Sprite;
		public var txtMsg:TextField;
		public var txtTitle:TextField;
		
		private var _txtBtnConfirm1:TextField;
		private var _txtBtnConfirm2:TextField;
		private var _txtBtnCancel:TextField;
		
		private var _rectangle:Rectangle;
	
////// params vars
		private var _container:Sprite;
		private var _complete:Function;
		private var _msg:String = "";
		private var _btnName1:String = "";
		private var _btnName2:String = "";
		private var _title:String = "";
		
		public function Alert()
		{
			createSkin();
			
		}
		
		private function centerAlign():void
		{
			x = ( appStage.stageWidth - width ) >> 1;
			y = ( appStage.stageHeight - height ) >> 1;
		}
		
		private function setTxtMsg( msg:String ):void
		{
			if ( msg != _msg ) 
				txtMsg.htmlText = msg;
			
			_msg = msg;
		}
		
		private function setTitle( title:String ):void
		{
			if ( title != _title )
				txtTitle.text = title;
			
			_title = title;
		}
		
		private function setBtnPosAndName( btnName1:String, btnName2:String ):void
		{
			btnCancel.visible = Boolean(btnName2);
			btnConfirm1.visible = Boolean(btnName2);
			btnConfirm2.visible = !Boolean(btnName2);
			
			if ( btnName1 != _btnName1 )
			{
				_txtBtnConfirm1.text = btnName1;
				_txtBtnConfirm2.text = btnName2;
			}
			if ( btnName2 != _btnName2 )
				_txtBtnCancel.text = btnName2;
			
			_btnName1 = btnName1;
			_btnName2 = btnName2;
		}
		
		private function setMask( isAdd:Boolean ):void
		{
			_container.mouseEnabled = isAdd;
			_container.graphics.clear();
			if ( isAdd )
			{
				_container.graphics.beginFill(0,0);
				_container.graphics.drawRect( 0,0,appStage.stageWidth,appStage.stageHeight);
				_container.graphics.endFill();
			}
		}

		private function createSkin():void
		{
			_container ||= ViewStruct.getContainer( ViewStruct.ALERT ) as Sprite;
			
			_skin = new ui_AlertSkin();
			addChild( _skin );
			
			Reflection.reflection( this, _skin );
			
			if ( btnConfirm1 )
			{
				_txtBtnConfirm1 = btnConfirm1.getChildByName( "txtName" ) as TextField;
				_txtBtnConfirm1.mouseEnabled = false;
				btnConfirm1.addEventListener(MouseEvent.CLICK, btnConfirmHandler );
			}
			
			if ( btnConfirm2 )
			{
				_txtBtnConfirm2 = btnConfirm2.getChildByName( "txtName" ) as TextField;
				_txtBtnConfirm2.mouseEnabled = false;
				btnConfirm2.addEventListener(MouseEvent.CLICK, btnConfirmHandler );
			}
			
			if ( btnCancel )
			{
				_txtBtnCancel= btnCancel.getChildByName( "txtName" ) as TextField;
				_txtBtnCancel.mouseEnabled = false;
				btnCancel.addEventListener(MouseEvent.CLICK, btnCancelHandler );
			}
			
			if ( btnClose )
				btnClose.addEventListener(MouseEvent.CLICK, btnCloseHandler );
			
			if ( dragTarget )
			{
				_rectangle = this.getBounds( this );
				_rectangle = new Rectangle( _rectangle.x, _rectangle.y, appStage.stageWidth - dragTarget.width, appStage.stageHeight - dragTarget.height );
				dragTarget.addEventListener(MouseEvent.MOUSE_DOWN, dragTargetMouseHandler );
			}
			
			if ( txtMsg )
				txtMsg.mouseEnabled = false;
			
			if ( txtTitle )
				txtTitle.mouseEnabled = false;
		}
		
		protected function btnCloseHandler(event:MouseEvent):void
		{
			safetyCall( _complete, CLOSE );
			hide();
		}
		
		protected function btnCancelHandler(event:MouseEvent):void
		{
			safetyCall( _complete, NO );
			hide();
		}
		
		protected function btnConfirmHandler(event:MouseEvent):void
		{
			safetyCall( _complete, YES );
			hide();
		}
		
		protected function dragTargetMouseHandler(event:MouseEvent):void
		{
			if ( event.type == MouseEvent.MOUSE_DOWN )
			{
				dragTarget.buttonMode = true;
				startDrag( false, _rectangle );
				appStage.addEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
			else if ( event.type == MouseEvent.MOUSE_UP )
			{
				stopDrag();
				dragTarget.buttonMode = false;
				appStage.removeEventListener(MouseEvent.MOUSE_UP, dragTargetMouseHandler );
			}
		}
		
//////////////////// public functions //////////////////
		
		/**
		 * 显示alert提示
		 * @param msg 提示信息msg
		 * @param callBackFun 点击按钮操作后回调函数，需要一个参数：操作结果的值。Alert.YES（1）：点击确定按钮/Alert.NO：点击取消按钮（0）
		 * @param btnName1 确定按钮名称，默认显示“确定”
		 * @param btnName2 取消按钮名称，默认显示“取消”。若是空字符串值则不显示该按钮，确定按钮居中显示
		 * @param title 标题内容
		 */
		public function show( msg:String, callBackFun:Function = null, btnName1:String = Alert.YES_NAME, btnName2:String = Alert.NO_NAME, title:String = "提示" ):void
		{
			_complete = callBackFun;
			
			centerAlign();
			setBtnPosAndName( btnName1 ? btnName1 : Alert.YES_NAME, btnName2 );
			setTxtMsg( msg );
			setTitle( title );
			setMask( true );
			_container.addChild( this );
		}
		
		/**
		 * 关闭alert
		 */
		public function hide():void
		{
			setMask( false );
			DisplayUtil.removedFromParent( this );
		}
		
		/**
		 * 显示alert提示
		 * @param msg 提示信息msg
		 * @param callBackFun 点击按钮操作后回调函数，需要一个参数：操作结果的值。Alert.YES（1）：点击确定按钮/Alert.NO：点击取消按钮（0）
		 * @param btnName1 确定按钮名称，默认显示“确定”
		 * @param btnName2 取消按钮名称，默认显示“取消”。若是空字符串值则不显示该按钮，确定按钮居中显示
		 * @param title 标题内容
		 */
		public static function show( msg:String, callBackFun:Function = null, btnName1:String = Alert.YES_NAME, btnName2:String = Alert.NO_NAME, title:String = "提示" ):void
		{
			instance.show( msg, callBackFun, btnName1, btnName2, title );
		}
		
		/**
		 * 关闭alert
		 */
		public static function hide():void
		{
			instance.hide();
		}

		/**
		 * 获取实例
		 */
		public static function get instance():Alert
		{
			return _instance ||= new Alert();
		}


	}
}