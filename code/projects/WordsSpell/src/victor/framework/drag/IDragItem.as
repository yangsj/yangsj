package victor.framework.drag
{
	import flash.display.DisplayObject;

	/**
	 * ……
	 * @author yangsj
	 */
	public interface IDragItem
	{
		/**
		 * 没有拖拽到指定目标类型上时调用（弹起后的目标对象不是指定的 upTargetClassType）
		 */
		function onDragFailed():void;

		/**
		 * 拖拽到指定目标类型上时调用
		 */
		function onDragSuccess():void;
		
		/**
		 * 开始拖拽时调用
		 */
		function onDragStart():void;

		/**
		 * 克隆对象
		 */
		function get cloneTarget():DisplayObject;

		/**
		 * 指定弹起的目标类型
		 */
		function get upTargetClassType():Class;
		
		/**
		 * 弹起的目标对象
		 */
		function get upTarget():DisplayObject;
		function set upTarget(value:DisplayObject):void;
	}
}
