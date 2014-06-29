package victor.framework.core
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import victor.framework.interfaces.IPanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-6-12
	 */
	public class Panel extends Sprite implements IPanel
	{
		protected var targetName:String;
		protected var target:InteractiveObject;

		public function Panel()
		{
			super();
			onceInit();
			addEventListener(MouseEvent.CLICK, clickedHandler );
		}
		
		protected function clickedHandler(event:MouseEvent):void
		{
			target = event.target as InteractiveObject;
			targetName = target.name;
		}
		
		protected function onceInit():void { }
		
		protected function showBefore():void { }
		
		protected function showAfter():void { }
		
		protected function clear():void { }
		
		final public function show():void
		{
			showBefore();
			ViewStruct.addPanel( this, true );
			showAfter();
		}
		
		final public function hide():void
		{
			ViewStruct.removePanel( this );
			clear();
		}
		
		public function dispose():void
		{
			hide();
			removeEventListener(MouseEvent.CLICK, clickedHandler );
		}
		
	}
}