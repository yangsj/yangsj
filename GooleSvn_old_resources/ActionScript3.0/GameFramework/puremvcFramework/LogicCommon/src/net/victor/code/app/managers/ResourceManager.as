package net.victor.code.app.managers
{	
	import net.victor.code.managers.AppManagerIn;
	import net.victor.code.managers.ManagerCenterableBase;
	import net.victor.code.managers.interfaces.IManagerCernterable;
	
	public class ResourceManager extends ManagerCenterableBase implements IManagerCernterable
	{
		/////////////////////////////////////////static /////////////////////////////////
		static private var _instance:ResourceManager;
		static AppManagerIn function get instance():ResourceManager
		{
			if(!_instance)
			{
				_instance = new ResourceManager();
			}
			return _instance;
		}
		
		
		/////////////////////////////////////////vars /////////////////////////////////
		
		public function ResourceManager()
		{
			if(_instance)
			{
				throw new Error("Singleton Error");
			}
			else
			{
				_instance = this;
			}
		}
		/////////////////////////////////////////public /////////////////////////////////
		
		public function isExist(id:String):Boolean
		{
			var rb:Boolean;
			
			
			return rb;
		}
		
		
		/////////////////////////////////////////override ///////////////////////////////
		
		
		
		/////////////////////////////////////////protected ///////////////////////////////
		
		
		
		/////////////////////////////////////////private ////////////////////////////////
		
		
		
		/////////////////////////////////////////events//////////////////////////////////
	}
}