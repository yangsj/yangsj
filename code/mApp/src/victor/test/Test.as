package victor.test
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import victor.framework.core.Scene;
	import victor.framework.utils.apps;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Test extends Scene
	{
		
		
		public function Test()
		{
			isTransition = false;
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			removeEventListener( MouseEvent.CLICK, clickedHandler );
		}
		
		override public function transitionInComplete():void
		{
			super.transitionInComplete();
			isTransition = true;
		}
		
		override protected function createUI():void
		{
			this.graphics.beginFill( 0xff0000 );
			this.graphics.drawRect(0,0,apps.fullScreenWidth, apps.fullScreenHeight );
			this.graphics.endFill();
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat( null, 50);
			txt.text = "this is Test Scene";
			txt.width = txt.textWidth + 20;
			txt.height = txt.textHeight + 10;
			txt.x = ( width - txt.textWidth ) * 0.5;
			txt.y = ( height- txt.textHeight) * 0.5;
			txt.selectable = false;
			addChild( txt );
			
			addEventListener( MouseEvent.CLICK, clickedHandler );
		}
		
		protected function clickedHandler(event:MouseEvent):void
		{
			var scene:Test2 = new Test2();
			scene.transitionIn(int(Math.random() * 5 ));
		}
		
	}
}