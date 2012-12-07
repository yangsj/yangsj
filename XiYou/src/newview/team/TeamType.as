package newview.team
{


	/**
	 * 说明：TeamType
	 * @author Victor
	 * 2012-11-14
	 */

	public class TeamType
	{

		
		public static const TYPE_WAITING : int = 0;

		public static const TYPE_SELECTED : int = 1;
		
		/**
		 * 人物启用标识
		 */
		public static const STATUS_YES:int = 1;
		/**
		 * 人物未启用标识
		 */
		public static const STATUS_NO:int = 0;

		
		///// 数据定义字段名
		/**
		 * 人物id
		 */		
		public static const DATA_ID:String = "id";
		/**
		 * 人物等级
		 */
		public static const DATA_LEVEL:String = "level";
		/**
		 * 人物启用状态
		 */
		public static const DATA_STATUS:String = "status";
		/**
		 * 人物攻击力值
		 */
		public static const DATA_ATK:String = "atk";
		/**
		 * 人物防御力值
		 */
		public static const DATA_DEFENSE:String = "defense";

	}

}
