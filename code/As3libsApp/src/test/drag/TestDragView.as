package test.drag
{
	import flash.display.Sprite;
	
	import victor.framework.managers.DragManager;
	
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class TestDragView extends Sprite
	{
		public function TestDragView()
		{
			
			var sprite1:Sprite = new Sprite();
			var sprite2:Sprite = new Sprite();
			addChild(sprite1);
			addChild(sprite2);
			DragManager.instance.init(sprite2);
			
			for (var i:int = 0; i < 15; i++)
			{
				var item:TestDragItem = new TestDragItem();
				item.x = 50 + 75 * (i % 5);
				item.y = 50 + 75 *int(i / 5 );
				sprite1.addChild(item);
			}
		}
	}
}