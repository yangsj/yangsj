package net.victor.code.managers
{
	import net.victor.code.managers.interfaces.IManagerCernterable;
	
	public class ManagerCenterableBase implements IManagerCernterable
	{
		private var _managerName:String = "";
		public function ManagerCenterableBase()
		{
		}
		
		public function get managerName():String
		{
			return _managerName;
		}
		
		public function setManagerName(value:String):void
		{
			_managerName = value;
		}
	}
}