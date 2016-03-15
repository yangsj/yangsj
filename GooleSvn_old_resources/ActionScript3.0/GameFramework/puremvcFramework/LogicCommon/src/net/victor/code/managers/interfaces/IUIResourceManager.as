package net.victor.code.managers.interfaces
{
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;

	public interface IUIResourceManager extends IManagerCernterable
	{
		/**
		 * ui控件资源的当前域 
		 * @return 
		 * 
		 */		
		function get currentUIDomain():ApplicationDomain;
		
		/**
		 * 取得类 
		 * @param name
		 * @return 
		 * 
		 */		
		function getDefinition(name:String):Object;
		/**
		 * 是否存在类 
		 * @param name
		 * @return 
		 * 
		 */		
		function hasDefinition(name:String):Boolean;
		
		/**
		 * 取得一个显示资源 
		 * @param className
		 * @return 
		 * 
		 */		
		function createDefinitionByClassName(className:String):Object;
		
	}
}