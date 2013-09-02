package victor.framework.drag
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * ……
	 * @author yangsj
	 */
	public class DragItem extends Sprite implements IDragItem
	{
		private var _upTarget:DisplayObject;
		
		public function DragItem()
		{
			mouseChildren = false;
		}
		
		public function onDragFailed():void
		{
			_upTarget = null;
		}
		
		public function onDragSuccess():void
		{
		}
		
		public function onDragStart():void
		{
		}
		
		public function get cloneTarget():DisplayObject
		{
			return this;
		}
		
		public function get upTargetClassType():Class
		{
			return IDragItem;
		}
		
		public function get upTarget():DisplayObject
		{
			return _upTarget;
		}
		
		public function set upTarget(value:DisplayObject):void
		{
			_upTarget = value
		}
	}
}