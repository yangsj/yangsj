package api 
{
	
	/**
	 * ...
	 * @author King
	 * 
	 */
	public interface IPaintBoard 
	{	
		/**
		 * Getter/Setter
		 * 
		 */
		function get toolBox():IToolBox;
		function set toolBox(value:IToolBox):void;
		
		/**
		 *  Getter/Setter
		 * 
		 */
		function get art():IArt;
		function set art(value:IArt):void;
		
		/**
		 * Getter/Setter
		 * 
		 */
		function get optionArea():IOption;
		function set optionArea(value:IOption):void;
		
		/**
		 * Getter/Setter
		 * 
		 */
		function get controlBox():IControlBox;
		function set controlBox(value:IControlBox):void;
		
	}
	
}