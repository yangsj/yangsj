package api 
{
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author King
	 */
	public interface IArt 
	{
		/**
		 * 将所选工具所绘制的图形作为元素添加到画板上，并对添加的元素进行是否拖动侦听
		 * @param value  为DisplayObject类型
		 * @return 存储元素的数组长度
		 */
		function addElement(value:DisplayObject):uint;
		
		/**
		 * 假如能在指定数组中找到指定索引的元素，并是一个DisplayObject，则返回该元素，否则返回一个新初始化的Sprite类实例
		 * @param index 指定数组中的索引值
		 * @return DisplayObject
		 */
		function getElementAt(index:int):DisplayObject;
		
		/**
		 * 返回指定数组的最后一个元素
		 * @return DisplayObject
		 */
		function getLastEmlement():DisplayObject;
		
		/**
		 * 判断所传入的DisplayObject对象在指定的数组中能否找到，能找到则将DisplayObject对象的alpha值设置为0.5；
		 */
		function select(value:DisplayObject):void;
		
		/**
		 * 判断所传入的DisplayObject对象与画板中的DisplayObject对象是否相交，若相交将画板中画板中相交的的alpha值设置为0.5并添加到一个显示容器中，对该显示容器进行是否拖动侦听
		 */
		function multiSelect(value:DisplayObject):void;
		
		/**
		 * 恢复被改变Alpha值的画板中的DisplayObject对象的Alpha
		 */
		function recoverElement():void;
		
		/**
		 * 
		 */
		function nextElement():void;
		
		/**
		 * 
		 */
		function backElement():void;
		
		function addArrayToArray(value:Array):void;
		
		function delElement():void;
		
		function del():void;
	}
	
}