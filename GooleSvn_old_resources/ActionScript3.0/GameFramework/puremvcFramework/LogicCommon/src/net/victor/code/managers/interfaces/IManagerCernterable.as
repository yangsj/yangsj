package net.victor.code.managers.interfaces
{
	/**
	 * 子类请实现JTManagerIn命名空间下的static方法getInstance(); getInstance()可实成单例类或多例类 
	 * @author jonee
	 * @see net.jt_tech.managers.JTManagerIn
	 */	
	public interface IManagerCernterable
	{
		/**
		 *  管理器的唯一标识
		 * @return 
		 * 
		 */		
		function get managerName():String;
		
		/**
		 * 
		 * 这个地方别改成setter形式，防止误赋值
		 */
		function setManagerName(value:String):void;
	}
}