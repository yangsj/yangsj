package
{

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	/**
	 * 说明：TestWinNative
	 * @author Victor
	 * 2012-10-15
	 */

	public class TestWinNative extends Sprite
	{

		private var moveNativeWin : Sprite;
		private var isMaxWin:Boolean = false;

		public function TestWinNative()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected function addedToStageHandler(event : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

			moveNativeWin = new Sprite();
			moveNativeWin.graphics.beginFill(0xffffff, 0.1);
			moveNativeWin.graphics.drawRect(0, 0, stage.stageWidth, 20);
			moveNativeWin.graphics.endFill();
			stage.addChild(moveNativeWin);
			
			var buttonClose : Sprite = getButton("X");
			var buttonMax:Sprite = getButton("口");
			var buttonMin:Sprite = getButton("—");
			
			buttonClose.y = buttonMax.y = buttonMin.y = 1;
			buttonClose.x = moveNativeWin.width - 20;
			buttonMax.x = moveNativeWin.width - 40;
			buttonMin.x = moveNativeWin.width - 60;

			moveNativeWin.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			buttonClose.addEventListener(MouseEvent.CLICK, buttonCloseHandler);
			buttonMax.addEventListener(MouseEvent.CLICK, buttonMaxHandler);
			buttonMin.addEventListener(MouseEvent.CLICK, buttonMinHandler);
		}
		
		protected function buttonMinHandler(event:MouseEvent):void
		{
			stage.nativeWindow.minimize();
			trace(stage.nativeWindow.maximizable , stage.nativeWindow.minimizable);
		}
		
		protected function buttonMaxHandler(event:MouseEvent):void
		{
			if (isMaxWin)
			{
				stage.nativeWindow.restore();
				isMaxWin = false;
			}
			else
			{
				stage.nativeWindow.maximize();
				isMaxWin = true;
			}
		}
		
		protected function buttonCloseHandler(event : MouseEvent) : void
		{
			NativeApplication.nativeApplication.exit();
		}

		protected function onDown(event : MouseEvent) : void
		{
			stage.nativeWindow.startMove();
		}
		
		
		private function getButton($name:String):Sprite
		{
			var button : Sprite = new Sprite();
			button.graphics.beginFill(0xffffff, 0.8);
			button.graphics.drawRect(0, 0, 19, 18);
			button.graphics.endFill();
			moveNativeWin.addChild(button);
			
			var text : TextField = new TextField();
			text.text = $name;
			text.width = text.textWidth + 2;
			text.height = text.textHeight + 2;
			text.x = (button.width - text.width) * 0.5;
			text.y = (button.height - text.height) * 0.5;
			button.addChild(text);
			button.mouseChildren = false;
			button.buttonMode = true;
			
			return button;
		}


	}

}
