package interfaces
{

	import flash.events.IEventDispatcher;
	import flash.geom.Point;


	/**
	 * 实现走路动作的接口
	 */
	public interface IWalkable extends IPositionable, IEventDispatcher
	{
		/**
		 * 向左转
		 */
		function turnLeft() : void;
		/**
		 * 向右转
		 */
		function turnRight() : void;
		/**
		 * 人物的朝向，由Orientation类定义。例如，Orientation.LEFT代表人物朝向左边
		 */
		function get orientation() : int;

		function get speed() : Number;
	}
}
