package net.victor.code.managers
{
	
	import flash.utils.Dictionary;
	
	import net.victor.code.errors.LCErrorTypes;
	import net.victor.code.managers.interfaces.IManagerCernterable;
	import net.victor.code.managers.interfaces.IManagersCenter;

	/**
	 * 程序管理器中心部 
	 * 
	 */	
	public class AppManagersCenter implements IManagersCenter
	{
		private static var _instance:AppManagersCenter;
		public static function get instance():AppManagersCenter
		{
			if(null == _instance)
			{
				_instance = new AppManagersCenter();
			}
			return _instance;
		}
		
		private static const EXIST_MSG:String = "Repeated manager name";
		private static const CLASS_TYPE_ERROR:String = "This Class must implements 'IManagerCernterable'";
		private var _managers:Dictionary = new Dictionary();
		public function AppManagersCenter()
		{
			if(_instance)
			{
				throw new Error(LCErrorTypes.SINGLETON_ERROR);
			}
			else
			{
				_instance = this;
			}
		}
		/**
		 * 添加一个Manager 
		 * @param managerCenterAble
		 * 
		 */		
		public function addManager(managerCenterAble:IManagerCernterable):void
		{
			if(getManager(managerCenterAble.managerName))
			{
				throw(EXIST_MSG);
			}
			if(managerCenterAble)
			{
				_managers[managerCenterAble.managerName] = managerCenterAble;
			}
		}
		
		/**
		 * 根据名字取得manager 
		 * @param nanagerName
		 * 
		 */		
		public function getManager(nanagerName:String):IManagerCernterable
		{
			return _managers[nanagerName] as IManagerCernterable;
		}
		
		public function addManagerByClass(managerClass:Class, namangerName:String):void
		{
			if(getManager(namangerName))
			{
				throw(EXIST_MSG);
			}
			
			var manager:IManagerCernterable = managerClass.AppManagerIn::getInstance() as IManagerCernterable; 
			if(manager)
			{
				manager.setManagerName(namangerName);
				this.addManager(manager);
			}
			else
			{
				throw new Error(CLASS_TYPE_ERROR);
			}
		}
	}
}