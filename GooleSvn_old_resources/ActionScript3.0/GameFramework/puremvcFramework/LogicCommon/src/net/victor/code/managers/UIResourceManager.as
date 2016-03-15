package net.victor.code.managers
{
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	import net.victor.code.errors.LCErrorTypes;
	import net.victor.code.managers.interfaces.IUIResourceManager;
	
	public class UIResourceManager extends ManagerCenterableBase implements IUIResourceManager
	{
		/////////////////////////////////////////static /////////////////////////////////
		static private var _instance:IUIResourceManager;
		static AppManagerIn function get instance():IUIResourceManager
		{
			if(_instance == null)
			{
				_instance = new UIResourceManager();
			}
			return _instance;
		}
		
		/////////////////////////////////////////vars /////////////////////////////////
		private var _currentUIDomain:ApplicationDomain;
		public function UIResourceManager()
		{
			if(_instance)
			{
				throw new Error(LCErrorTypes.SINGLETON_ERROR);
			}
			else
			{
				_instance = this;
			}
			currentUIDomain;
		}
		
		public function get currentUIDomain():ApplicationDomain
		{
			if(!_currentUIDomain)
			{
				//_currentUIDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
				_currentUIDomain = ApplicationDomain.currentDomain;
			}
			return _currentUIDomain;
		}
		
		public function getDefinition(name:String):Object
		{
			return this.currentUIDomain.getDefinition(name);
		}
		
		public function hasDefinition(name:String):Boolean
		{
			return this.currentUIDomain.hasDefinition(name);
		}
		
		public function createDefinitionByClassName(className:String):Object
		{
			var ClassReference:Class = getDefinition(className) as Class;
			var instance:Object = new ClassReference();
			return instance;
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}