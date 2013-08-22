package app.module.setting
{
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import app.utils.DisplayUtil;
	import app.utils.safetyCall;
	
	import framework.interfaces.IDisposable;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-22
	 */
	public class Switch extends Sprite implements IDisposable
	{
		private var bgShape:Shape;
		private var txtBg:TextField;
		private var txtOn:TextField;
		private var txtOff:TextField;
		private var barShape:Shape;
		private var container:Sprite;
		
		private var _callBack:Function;
		private var _switchResult:Boolean = false;
		
		public function Switch( label:String, callBack:Function = null, switchResultBoo:Boolean = true )
		{
			super();
			
			_callBack = callBack;
			
			txtBg = DisplayUtil.getTextFiled( 34, 0xffffff );
			txtBg.width = 160;
			txtBg.height = 43;
			txtBg.selectable = false;
			txtBg.mouseEnabled = false;
			txtBg.text = label;
			addChild( txtBg );
			
			container = new Sprite();
			container.x = 165;
			addChild( container );
			
			bgShape = new Shape();
			bgShape.graphics.beginFill(0xffffff);
			bgShape.graphics.drawRoundRect(0,0, 200, 40, 40);
			bgShape.graphics.endFill();
			container.addChild( bgShape );
			
			txtOn = DisplayUtil.getTextFiled( 34, 0, TextFormatAlign.CENTER);
			txtOn.text = "ON";
			txtOn.width = 100;
			txtOn.height = txtOn.textHeight + 2;
			txtOn.y = (40 - txtOn.textHeight) * 0.5;
			container.addChild( txtOn );
			
			txtOff = DisplayUtil.getTextFiled( 34, 0, TextFormatAlign.CENTER);
			txtOff.text = "OFF";
			txtOff.width = 100;
			txtOff.height = txtOff.textHeight + 2;
			txtOff.y = (40 - txtOff.textHeight) * 0.5;
			txtOff.x = 100;
			container.addChild( txtOff );
			
			barShape = new Shape();
			barShape.graphics.beginFill(0x333333);
			barShape.graphics.drawRoundRect(0,0,100,40,40);
			barShape.graphics.endFill();
			container.addChild( barShape );
			
			switchResultBoo ? on() : off();
			
			container.addEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			switchResult ? off() : on();
			
			safetyCall( callBack );
		}
		
		public function dispose():void
		{
			container.removeEventListener( MouseEvent.CLICK, clickHandler );
		}
		
		public function on():void
		{
			TweenMax.to( barShape, 0.3, { x: 0 });
			
			switchResult = true;
		}
		
		public function off():void
		{
			TweenMax.to( barShape, 0.3, { x: 100 });
			
			switchResult = false;
		}

		public function get switchResult():Boolean
		{
			return _switchResult;
		}

		public function set switchResult(value:Boolean):void
		{
			_switchResult = value;
		}

		public function get callBack():Function
		{
			return _callBack;
		}

		public function set callBack(value:Function):void
		{
			_callBack = value;
		}
		
		
	}
}