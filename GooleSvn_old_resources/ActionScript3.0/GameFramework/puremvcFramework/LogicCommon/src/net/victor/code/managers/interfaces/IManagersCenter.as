package net.victor.code.managers.interfaces
{
	public interface IManagersCenter
	{
		function addManager(managerCenterAble:IManagerCernterable):void;
		
		function getManager(nanagerName:String):IManagerCernterable;
		
		/**
		 * 添加 实现了静态方法getInstance()的管理器 
		 * @param managerClass 实现了静态方法getInstance()的管理器
		 * @param namangerName 管理器名称
		 * 
		 */		
		function addManagerByClass(managerClass:Class, namangerName:String):void;
	}
}