package test.drag
{
	import flash.events.MouseEvent;
	
	import victor.components.drag.DragItem;
	import victor.framework.managers.DragManager;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class TestDragItem extends DragItem
	{
		public function TestDragItem()
		{
			super();
			
			graphics.beginFill(0xff0000);
			graphics.drawRect(0,0,50,50);
			graphics.endFill();
			graphics.beginFill(0);
			graphics.drawRect(10,10,30,30);
			graphics.endFill();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
		}
		
		protected function mouseHandler(event:MouseEvent):void
		{
			DragManager.instance.drag(this);
		}
	}
}