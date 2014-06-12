package victor.app.components
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.Display;
	import victor.framework.utils.appstage;
	import victor.framework.utils.call;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-13
	 */
	public class Button extends Sprite implements IDisposable
	{
		private var callFun:Function;
		private var uiRes:UI_ButtonSkin;
		private var startHeight:Number = 0;
		
		private const HEIGHT:int = 150;
		
		public function Button(label:String, clickCallFun:Function = null )
		{
			this.callFun = clickCallFun;
			if ( callFun != null ) this.addEventListener( MouseEvent.CLICK, clicked );
			
			uiRes = new UI_ButtonSkin();
			uiRes.txtName.mouseEnabled = false;
			uiRes.txtName.htmlText = label;
			addChild( uiRes );
			
			startHeight = uiRes.height;
			
			scale = appstage.fullScreenHeight / 960;
			
			this.mouseEnabled = false;
		}
		
		protected function clicked(event:MouseEvent):void
		{
			call( callFun );
		}
		
		public function dispose():void
		{
			this.removeEventListener( MouseEvent.CLICK, clicked );
			Display.removedFromParent( uiRes );
			uiRes = null;
		}
		
		public function set scale( value:Number ):void
		{
			var height:Number = HEIGHT * value;
			if ( height != uiRes.height )
			{
				uiRes.scaleX = uiRes.scaleY = height / HEIGHT;
			}
		}
		
	}
}