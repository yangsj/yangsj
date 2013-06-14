package victor.components.scroll
{
	import flash.display.Sprite;
	
	/**
	 * ……
	 * @author yangsj
	 */
	public interface ITouchScrollPanel
	{
		/**
		 * 销毁对象时调用回收内存
		 */
		function dispose():void;
		
		/**
		 * 更新显示（刷新）
		 */
		function refresh():void;
		
		/**
		 * 设置被滚动的对象，指定后需要调用 <code>refresh()</code>
		 */
		function get scrollList():Sprite;
		function set scrollList( value:Sprite ):void
	}
}