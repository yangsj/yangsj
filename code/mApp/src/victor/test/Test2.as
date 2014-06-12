package victor.test
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import victor.framework.core.Scene;
	import victor.framework.utils.appstage;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Test2 extends Scene
	{
		
		
		public function Test2()
		{
			super();
		}
		override public function dispose():void
		{
			super.dispose();
			
			removeEventListener( MouseEvent.CLICK, clickedHandler );
		}
		
		override protected function createUI():void
		{
			this.graphics.beginFill( 0xffff00 );
			this.graphics.drawRect(0,0,appstage.fullScreenWidth, appstage.fullScreenHeight );
			this.graphics.endFill();
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = new TextFormat( null, 50);
			txt.text = "this is Test2 Scene";
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
			var scene:Test = new Test();
			scene.isTransition = true;
			scene.transitionIn(int(Math.random() * 5 ));
		}
		
	}
}