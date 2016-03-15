package net.victor.code.framework
{
	import net.victor.code.managers.AppManagersCenter;
	import net.victor.code.managers.interfaces.IManagersCenter;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AppCommand extends SimpleCommand
	{
		/**
		 * 管理器中心部 
		 * @return 
		 * 
		 */		
		protected function get managerCenter():IManagersCenter
		{
			return AppManagersCenter.instance;
		}
		
		protected function getProxy(proxyName:String):IProxy
		{
			return facade.retrieveProxy(proxyName);
		}
	}
}