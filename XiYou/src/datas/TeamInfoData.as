package datas
{

	import manager.LocalStoreManager;


	/**
	 * 说明：TeamInfoData
	 * @author Victor
	 * 2012-10-9
	 */

	public class TeamInfoData
	{

		private static var STORE_NAME_SELECTED : String = "datas_TeamInfoData_dataName_selected"; // 已经选择编队的数据存取名称
		private static var STORE_NAME_WAITING : String = "datas_TeamInfoData_dataName_waiting"; // 等待选择编队的数据存取名称

		private static var _selected : Array = RolesID.defalutSelectedRoleId;
		private static var _waiting : Array = RolesID.defalutWaitingRoleId;
		
		private static var _enemyerTeams:Array = null;

		public static function get selected() : Array
		{
//			var temp : Object = LocalStoreManager.getData(STORE_NAME_SELECTED);
//			if (temp)
//			{
//				return temp as Array;
//			}
//			return RolesID.defalutSelectedRoleId;
			return _selected;
		}

		public static function set selected(value : Array) : void
		{
//			if (value)
//			{
//				LocalStoreManager.setData(STORE_NAME_SELECTED, value);
//			}
			_selected = value;
		}

		public static function get waiting() : Array
		{
//			var temp : Object = LocalStoreManager.getData(STORE_NAME_WAITING);
//			if (temp)
//			{
//				return temp as Array;
//			}
//			return RolesID.defalutWaitingRoleId;
			return _waiting;
		}

		public static function set waiting(value : Array) : void
		{
//			if (value)
//			{
//				LocalStoreManager.setData(STORE_NAME_WAITING, value);
//			}
			_waiting = value;
		}

		public static function get enemyerTeams():Array
		{
			return _enemyerTeams;
		}

		public static function set enemyerTeams(value:Array):void
		{
			_enemyerTeams = value;
		} 


	}

}
