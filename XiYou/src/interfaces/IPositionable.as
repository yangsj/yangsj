package interfaces
{
	/**
	 * 可定位的接口，用于获取坐标
	 * @author Chenzhe
	 */	
	public interface IPositionable
	{
		function get x() : Number;
		function get y() : Number;
		function set x(val : Number) : void;
		function set y(val : Number) : void;
	}
}