package app.module.setting
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import app.AppStage;
	import app.utils.DisplayUtil;
	import app.utils.safetyCall;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class Bar extends Sprite
	{
		private var txtBg:TextField;
		private var mcBg:Sprite;
		private var mcBar:Sprite;
		private var rect:Rectangle;
		private var label:String;
		private var callBack:Function;
		
		public function Bar(label:String, callBack:Function = null)
		{
			super();
			this.label = label;
			this.callBack = callBack;
			createRes();
		}
		
		public function setValue(value:Number):void
		{
			mcBar.x = Math.min(rect.x + rect.width * value, rect.x + rect.width);
		}
		
		private function createRes():void
		{
			txtBg = DisplayUtil.getTextFiled( 34, 0xffffff );
			txtBg.width = 160;
			txtBg.height = 43;
			txtBg.selectable = false;
			txtBg.mouseEnabled = false;
			addChild( txtBg );
			
			txtBg.text = label;
			
			mcBg = new Sprite();
			mcBg.graphics.beginFill(0xffffff);
			mcBg.graphics.drawRect( 0, 0, 320, 40 );
			mcBg.graphics.endFill();
			mcBg.x = 160;
			mcBg.y = 2.5;
			addChild( mcBg );
			
			mcBar = new Sprite();
			mcBar.graphics.beginFill( 0x333333 );
			mcBar.graphics.drawRect( 0, 0, 41, 41 );
			mcBar.graphics.endFill();
			mcBar.x = mcBg.x;
			mcBar.y = mcBg.y;
			mcBar.buttonMode = true;
			addChild( mcBar );
			
			rect = new Rectangle( mcBg.x, mcBg.y, mcBg.width - mcBar.width, 0 );
			
			mcBar.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			AppStage.stage.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			AppStage.stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler );
			mcBar.startDrag( false, rect );
		}
		
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			changeValue();
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			AppStage.stage.removeEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			AppStage.stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMoveHandler );
			mcBar.stopDrag();
			
			changeValue();
		}
		
		private function changeValue():void
		{
			var per:Number = (mcBar.x - rect.x) / rect.width;
			safetyCall(callBack, per );
			trace( "音量" + per );
		}
		
	}
}