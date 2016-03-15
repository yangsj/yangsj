package net.victor.code.framework
{
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class AppFacade extends Facade
	{
		/**
		 * 程序 Facade实例 
		 * @return 
		 * 
		 */		
		public static function get instance():AppFacade
		{
			return getInstance();
		}
		
		/**
		 * 兼容Facde的写法 
		 * @return EPAppFacade
		 * 
		 */		
		public static function getInstance():AppFacade
		{
			if(null == _instance)
			{
				_instance = new AppFacade();
			}
			return _instance as AppFacade;
		}
		
	
	}
}