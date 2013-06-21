package components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-6-20
	 */
	public class Button extends Sprite
	{
		private var upState:Sprite;
		private var overState:Sprite;
		private var downState:Sprite;

		private var callHandler:Function;

		public function Button( label:String = "label", handler:Function = null )
		{
			this.callHandler = handler;

			this.mouseChildren = false;
			this.buttonMode = true;
			upState = createSkin( label, 0xff0000 );
			overState = createSkin( label, 0xfff000 );
			downState = createSkin( label, 0xffff00 );
			addChild( upState );
			addChild( overState );
			addChild( downState );

			addEventListener( Event.ADDED, addedHandler );
			addEventListener( Event.REMOVED, removedHandler );
		}

		protected function removedHandler( event:Event ):void
		{
			removeEventListener( MouseEvent.CLICK, clickHandler );
			removeEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			removeEventListener( Event.ADDED, addedHandler );
			removeEventListener( Event.REMOVED, removedHandler );

			callHandler = null;
		}

		protected function addedHandler( event:Event ):void
		{
			addEventListener( MouseEvent.CLICK, clickHandler );
			addEventListener( MouseEvent.MOUSE_DOWN, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT));
		}

		protected function clickHandler( event:MouseEvent ):void
		{
			if ( callHandler != null )
				callHandler.call( this );
		}

		protected function mouseHandler( event:MouseEvent ):void
		{
			var type:String = event.type;
			upState.visible = type == MouseEvent.MOUSE_OUT;
			overState.visible = type == MouseEvent.MOUSE_OVER;
			downState.visible = type == MouseEvent.MOUSE_DOWN;
		}

		private function createSkin( label:String, color:uint ):Sprite
		{
			var txt:TextField = new TextField();
			txt.text = "  " + label + "  ";
			var bitdata:BitmapData = new BitmapData( txt.textWidth + 4, txt.textHeight + 2, false, color );
			bitdata.draw( txt );
			var bitmap:Bitmap = new Bitmap( bitdata, "auto", true );
			var sprite:Sprite = new Sprite();
			sprite.addChild( bitmap );
			return sprite;
		}
	}
}
